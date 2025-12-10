<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<!-- Recursive template to insert hyphens -->
	<xsl:template name="hyphenate-serial-number">
		<xsl:param name="text"/>
		<xsl:param name="length"/>
		<xsl:choose>
			<xsl:when test="string-length($text) &gt; $length">
				<xsl:value-of select="substring($text, 1, $length)"/>
				<xsl:text>-</xsl:text>
				<xsl:call-template name="hyphenate-serial-number">
					<xsl:with-param name="text" select="substring($text, $length + 1)"/>
					<xsl:with-param name="length" select="$length"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$text"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>