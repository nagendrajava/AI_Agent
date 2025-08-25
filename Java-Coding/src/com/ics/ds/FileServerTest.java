package com.ics.ds;
import com.sun.net.httpserver.HttpServer;
import com.sun.net.httpserver.HttpHandler;
import com.sun.net.httpserver.HttpExchange;

import java.io.*;
import java.net.InetSocketAddress;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;

public class FileServerTest {

    public static void main(String[] args) throws IOException {
        int port = 9090;
        String baseDir = "C:\\Users\\nagendrapa\\OneDrive - Infinite Computer Solutions (India) Limited\\Desktop\\test_nagendra";

        HttpServer server = HttpServer.create(new InetSocketAddress(port), 0);
        server.createContext("/", new FileHandler(baseDir));
        server.setExecutor(null); // default executor
        server.start();

        System.out.println("File server started on http://localhost:" + port);
    }

    static class FileHandler implements HttpHandler {
        private final String baseDir;

        public FileHandler(String baseDir) {
            this.baseDir = baseDir;
        }

        @Override
        public void handle(HttpExchange exchange) throws IOException {
            String requestedPath = URLDecoder.decode(exchange.getRequestURI().getPath(), StandardCharsets.UTF_8);
            if (requestedPath.startsWith("/")) {
                requestedPath = requestedPath.substring(1);
            }
            Path filePath = Path.of(baseDir, requestedPath).normalize();

            if (!filePath.startsWith(Path.of(baseDir))) {
                sendBytes(exchange, 403, "Forbidden".getBytes(StandardCharsets.UTF_8), false, "text/plain");
                return;
            }

            boolean encrypt = shouldEncrypt(exchange);

            if (Files.exists(filePath)) {
                if (Files.isDirectory(filePath)) {
                    StringBuilder html = new StringBuilder();
                    html.append("<html><body><h2>Directory listing for ")
                            .append(requestedPath.isEmpty() ? "/" : requestedPath)
                            .append("</h2><ul>");

                    String basePath = requestedPath.isEmpty() ? "" : requestedPath + "/";
                    try (var stream = Files.list(filePath)) {
                        for (Path entry : stream.toList()) {
                            String name = entry.getFileName().toString();
                            String encodedName = URLEncoder.encode(name, StandardCharsets.UTF_8);
                            String link = basePath + encodedName;

                            html.append("<li><a href=\"/")
                                    .append(link.replace("\\", "/"))
                                    .append("\">")
                                    .append(name)
                                    .append("</a></li>");
                        }
                    }

                    html.append("</ul></body></html>");
                    byte[] responseBytes = html.toString().getBytes(StandardCharsets.UTF_8);
                    sendBytes(exchange, 200, responseBytes, encrypt, "text/html");
                } else {
                    // Serve file
                    String contentType = Files.probeContentType(filePath);
                    byte[] fileBytes = Files.readAllBytes(filePath);
                    sendBytes(exchange, 200, fileBytes, encrypt, contentType != null ? contentType : "application/octet-stream");
                }
            } else {
                String notFound = "404 - File Not Found";
                sendBytes(exchange, 404, notFound.getBytes(StandardCharsets.UTF_8), encrypt, "text/plain");
            }
        }

        private boolean shouldEncrypt(HttpExchange exchange) {
            String header = exchange.getRequestHeaders().getFirst("X-Encrypt");
            if (header != null && header.equalsIgnoreCase("true")) return true;
            String query = exchange.getRequestURI().getQuery();
            if (query != null) {
                for (String part : query.split("&")) {
                    int idx = part.indexOf('=');
                    String k = idx >= 0 ? part.substring(0, idx) : part;
                    String v = idx >= 0 ? part.substring(1 + idx) : "";
                    if ("encrypt".equalsIgnoreCase(k) && "true".equalsIgnoreCase(v)) return true;
                }
            }
            return false;
        }

        private void sendBytes(HttpExchange exchange, int status, byte[] data, boolean encrypt, String originalContentType) throws IOException {
            byte[] out;
            String contentType;
            if (encrypt) {
                String json = CryptoUtil.encryptToJson(data);
                out = json.getBytes(StandardCharsets.UTF_8);
                contentType = "application/json";
                exchange.getResponseHeaders().set("X-Encrypted", "true");
                exchange.getResponseHeaders().set("Content-Type", contentType);
            } else {
                out = data;
                contentType = originalContentType != null ? originalContentType : "application/octet-stream";
                if (contentType != null) {
                    exchange.getResponseHeaders().set("Content-Type", contentType);
                }
            }
            exchange.sendResponseHeaders(status, out.length);
            try (OutputStream os = exchange.getResponseBody()) {
                os.write(out);
            }
        }
    }
}