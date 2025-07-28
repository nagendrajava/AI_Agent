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
                exchange.sendResponseHeaders(403, -1); // Forbidden
                return;
            }

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
                    byte[] responseBytes = html.toString().getBytes();

                    exchange.getResponseHeaders().add("Content-Type", "text/html");
                    exchange.sendResponseHeaders(200, responseBytes.length);
                    try (OutputStream os = exchange.getResponseBody()) {
                        os.write(responseBytes);
                    }
                } else {
                    // Serve file
                    String contentType = Files.probeContentType(filePath);
                    exchange.getResponseHeaders().add("Content-Type", contentType != null ? contentType : "application/octet-stream");

                    byte[] fileBytes = Files.readAllBytes(filePath);
                    exchange.sendResponseHeaders(200, fileBytes.length);
                    try (OutputStream os = exchange.getResponseBody()) {
                        os.write(fileBytes);
                    }
                }
            } else {
                String notFound = "404 - File Not Found";
                exchange.sendResponseHeaders(404, notFound.length());
                try (OutputStream os = exchange.getResponseBody()) {
                    os.write(notFound.getBytes());
                }
            }
        }
    }
}