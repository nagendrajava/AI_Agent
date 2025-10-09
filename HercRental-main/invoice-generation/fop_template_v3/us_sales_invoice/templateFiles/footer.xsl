<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:template name="footer">
		<xsl:param name="is-last-page" select="false()"/>
		<fo:block
			xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<fo:table table-layout="fixed" width="100%">
				<fo:table-column column-width="30%" />
				<fo:table-column column-width="30%" />
				<fo:table-column column-width="30%" />
				<fo:table-column column-width="10%" />
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell column-number="1">
							<fo:block text-align="left" font-size="8pt">
								<fo:block>Legacy #: 
									<xsl:value-of
                                        select="Invoice/Detail/OrderInfo/Legacy" />
								</fo:block>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell column-number="2">
							<fo:block text-align="left" font-size="8pt">
								<fo:block>RES/QUOTE #: 
									<xsl:value-of
                                        select="Invoice/Detail/OrderInfo/ResQuote" />
								</fo:block>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<!-- Signature row, should visible only on the last page -->
					<xsl:if test="$is-last-page">
						<fo:table-row>
							<fo:table-cell number-columns-spanned="3">
								<fo:table table-layout="fixed" width="100%">
									<fo:table-column column-width="35%" />
									<fo:table-column column-width="15%" />
									<fo:table-column column-width="35%" />
									<fo:table-column column-width="15%" />
									<fo:table-body>
										<fo:table-row>
											<fo:table-cell padding-left="10pt" number-columns-spanned="2">
												<fo:block>
													<fo:leader leader-pattern="rule" leader-length="90%" rule-thickness="0.5pt"/>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell padding-left="10pt" number-columns-spanned="2">
												<fo:block>
													<fo:leader leader-pattern="rule" leader-length="90%" rule-thickness="0.5pt"/>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
										<fo:table-row>
											<fo:table-cell padding-left="10pt" column-number="1">
												<fo:block font-size="8pt">Customer Signature
                                        </fo:block>
											</fo:table-cell>
											<fo:table-cell padding-left="10pt" column-number="2">
												<fo:block font-size="8pt">Date
                                        </fo:block>
											</fo:table-cell>
											<fo:table-cell padding-left="10pt" column-number="3">
												<fo:block font-size="8pt">Branch Manager Signature
                                        </fo:block>
											</fo:table-cell>
											<fo:table-cell padding-left="10pt" column-number="4">
												<fo:block font-size="8pt">Date
                                        </fo:block>
											</fo:table-cell>
										</fo:table-row>
										<fo:table-row>
											<fo:table-cell padding-left="10pt" number-columns-spanned="2">
												<fo:block>
													<fo:leader leader-pattern="rule" leader-length="90%" rule-thickness="0.5pt"/>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell padding-left="10pt" number-columns-spanned="2">
												<fo:block>
													<fo:leader leader-pattern="rule" leader-length="90%" rule-thickness="0.5pt"/>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
										<fo:table-row>
											<fo:table-cell padding-left="10pt" column-number="1">
												<fo:block font-size="8pt">PRINT Customer Name
                                        </fo:block>
											</fo:table-cell>
											<fo:table-cell padding-left="10pt" column-number="2">
												<fo:block font-size="8pt">Title
                                        </fo:block>
											</fo:table-cell>
											<fo:table-cell padding-left="10pt" column-number="3">
												<fo:block font-size="8pt">PRINT Branch Manager Name
                                        </fo:block>
											</fo:table-cell>
											<fo:table-cell padding-left="10pt" column-number="4">
												<fo:block font-size="8pt"></fo:block>
											</fo:table-cell>
										</fo:table-row>
										<!-- <fo:table-row><fo:table-cell padding-left="10pt" number-columns-spanned="4"><fo:block font-weight="bold" text-align="left" font-size="8pt">Carefully read the terms and conditions on reverse side of this page
                                        </fo:block></fo:table-cell></fo:table-row> -->
									</fo:table-body>
								</fo:table>
							</fo:table-cell>
							<fo:table-cell display-align="center" column-number="4">
								<fo:block text-align="right" font-size="8pt"> Page 
									<fo:page-number /> of 
									<fo:page-number-citation
                                        ref-id="last-page" />
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</xsl:if>
					<xsl:if test="$is-last-page = false()">
						<fo:table-row>
							<fo:table-cell number-columns-spanned="3">
								<fo:block></fo:block>
							</fo:table-cell>
							<fo:table-cell display-align="center" column-number="4">
								<fo:block text-align="right" font-size="8pt"> Page 
									<fo:page-number /> of 
									<fo:page-number-citation
                                        ref-id="last-page" />
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</xsl:if>
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>
</xsl:stylesheet>