<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:template name="headerNotes">
		<fo:block
			xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<fo:block text-align="center" font-size="7pt">
				<xsl:value-of select="'&#x2028;'" />
				<xsl:value-of select="'&#x2028;'" />
				<xsl:value-of select="Invoice/Header/HeaderNotes" />
			</fo:block>
		</fo:block>
	</xsl:template>
</xsl:stylesheet>