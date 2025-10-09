<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:template name="orderDetailsHeader">
		<fo:block
			xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<fo:table table-layout="fixed" width="100%">
				<fo:table-column column-width="5%" />
				<fo:table-column column-width="40%" />
				<fo:table-column column-width="15%" />
				<fo:table-column column-width="40%" />
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell column-number="2">
							<xsl:call-template name="address" />
						</fo:table-cell>
						<fo:table-cell column-number="4">
							<xsl:call-template name="invoiceDetails" />
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
			<fo:table table-layout="fixed" width="100%">
				<fo:table-column column-width="100%" />
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell column-number="1">
							<page-number/>
							<fo:block></fo:block>
						</fo:table-cell>
					</fo:table-row>
					<fo:table-row>
						<fo:table-cell column-number="1">
							<fo:block></fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>
</xsl:stylesheet>