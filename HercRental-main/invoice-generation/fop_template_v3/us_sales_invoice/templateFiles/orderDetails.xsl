<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:output method="xml" indent="yes"/>
	<xsl:template match="/">
		<fo:root>
			<fo:layout-master-set>
				<fo:simple-page-master master-name="simple" page-height="11in" page-width="8.5in" margin="0.5in">
					<fo:region-body/>
				</fo:simple-page-master>
			</fo:layout-master-set>
			<fo:page-sequence master-reference="simple">
				<fo:flow flow-name="xsl-region-body">
					<xsl:call-template name="orderDetails"/>
				</fo:flow>
			</fo:page-sequence>
		</fo:root>
	</xsl:template>
	<xsl:template name="orderDetails">
		<fo:block width="100%">
			<fo:table table-layout="fixed" width="100%">
				<fo:table-column column-width="8%" />
				<fo:table-column column-width="15%" />
				<fo:table-column column-width="40%" />
				<fo:table-column column-width="12%" />
				<fo:table-column column-width="12%" />
				<fo:table-column column-width="13%" />
				<fo:table-header>
					<fo:table-row font-size="8pt" background-color="#c8c4c4">
						<fo:table-cell column-number="1" border="1pt solid black" text-align="center">
							<fo:block>QTY</fo:block>
						</fo:table-cell>
						<fo:table-cell column-number="2" border="1pt solid black" text-align="center">
							<fo:block>ITEMS #</fo:block>
						</fo:table-cell>
						<fo:table-cell column-number="3" border="1pt solid black" text-align="center">
							<fo:block>DESCRIPTION</fo:block>
						</fo:table-cell>
						<fo:table-cell column-number="4" border="1pt solid black" text-align="center">
							<fo:block>UNIT</fo:block>
						</fo:table-cell>
						<fo:table-cell column-number="5" border="1pt solid black" text-align="center">
							<fo:block>PRICE</fo:block>
						</fo:table-cell>
						<fo:table-cell column-number="6" border="1pt solid black" text-align="center">
							<fo:block>AMOUNT</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-header>
				<fo:table-body start-indent="0pt">
					<xsl:for-each select="Invoice/Detail/RentalEquipment/Equipment">
						<fo:table-row font-size="8pt">
							<fo:table-cell column-number="1" text-align="center">
								<fo:block>
									<xsl:value-of select="EquipmentQuantity" />
								</fo:block>
							</fo:table-cell>
							<fo:table-cell column-number="2" text-align="center">
								<fo:block>
									<xsl:value-of select="Item" />
								</fo:block>
							</fo:table-cell>
							<fo:table-cell column-number="3" text-align="left">
								<fo:block>
									<fo:block>
										<xsl:value-of select="Description" />
									</fo:block>
									<fo:block>
										<xsl:value-of select="ItemNumber" />
									</fo:block>
									<xsl:call-template name="wrap-texty">
										<xsl:with-param name="text" select="LineItemComment" />
									</xsl:call-template>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell column-number="4" text-align="right">
								<fo:block>
									<xsl:value-of select="UNIT" />
								</fo:block>
							</fo:table-cell>
							<fo:table-cell column-number="5" text-align="right">
								<fo:block>
									<xsl:value-of select="PRICE" />
								</fo:block>
							</fo:table-cell>
							<fo:table-cell column-number="6" text-align="right">
								<fo:block>
									<xsl:value-of select="AMOUNT" />
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
						<xsl:if test="string(DeliveryNote) != ''">
							<fo:table-row font-size="8pt" keep-with-previous="always">
								<fo:table-cell column-number="3" number-columns-spanned="6" text-align="left">
									<fo:block-container>
										<!-- Normalize whitespace and trim leading/trailing spaces -->
										<!-- <xsl:variable name="normalizedText"><xsl:value-of select="normalize-space(DeliveryNote)"/></xsl:variable> -->
										<xsl:call-template name="wrap-texty">
											<xsl:with-param name="text" select="DeliveryNote"/>
											<!-- <xsl:with-param name="max-length" select="40"/> -->
										</xsl:call-template>
									</fo:block-container>
								</fo:table-cell>
							</fo:table-row>
						</xsl:if>
					</xsl:for-each>
				</fo:table-body>
			</fo:table>
		</fo:block>
		<!-- Sales Items -->
		<fo:block width="100%">
			<xsl:if test="Invoice/Detail/SalesItemsList">
				<fo:block text-align="left" font-weight="bold" font-size="9pt">
					<xsl:value-of select="Invoice/Detail/SalesItemsList/title"/>
				</fo:block>
				<fo:table table-layout="fixed" width="100%">
					<fo:table-header>
						<fo:table-row font-size="9pt">
							<xsl:variable name="headerCount" select="count(Invoice/Detail/SalesItemsList/headers/header)"/>
							<xsl:for-each select="Invoice/Detail/SalesItemsList/headers/header">
								<xsl:variable name="position" select="position()"/>
								<xsl:choose>
									<xsl:when test="$position = 1">
										<fo:table-cell column-number="1" font-weight="bold" text-align="center">
											<fo:block>
												<xsl:choose>
													<xsl:when test="string(.) != ''">
														<xsl:value-of select="."/>
													</xsl:when>
													<xsl:otherwise>
														<fo:inline></fo:inline>
													</xsl:otherwise>
												</xsl:choose>
											</fo:block>
										</fo:table-cell>
									</xsl:when>
									<xsl:when test="$position = 2">
										<fo:table-cell column-number="2" number-columns-spanned="3" font-weight="bold" text-align="left">
											<fo:block>
												<xsl:choose>
													<xsl:when test="string(.) != ''">
														<xsl:value-of select="."/>
													</xsl:when>
													<xsl:otherwise>
														<fo:inline></fo:inline>
													</xsl:otherwise>
												</xsl:choose>
											</fo:block>
										</fo:table-cell>
									</xsl:when>
									<xsl:when test="$position = 3">
										<fo:table-cell column-number="5" font-weight="bold" text-align="center">
											<fo:block>
												<xsl:choose>
													<xsl:when test="string(.) != ''">
														<xsl:value-of select="."/>
													</xsl:when>
													<xsl:otherwise>
														<fo:inline></fo:inline>
													</xsl:otherwise>
												</xsl:choose>
											</fo:block>
										</fo:table-cell>
									</xsl:when>
									<xsl:when test="$position = 4">
										<fo:table-cell column-number="6" font-weight="bold" text-align="right">
											<fo:block>
												<xsl:choose>
													<xsl:when test="string(.) != ''">
														<xsl:value-of select="."/>
													</xsl:when>
													<xsl:otherwise>
														<fo:inline></fo:inline>
													</xsl:otherwise>
												</xsl:choose>
											</fo:block>
										</fo:table-cell>
									</xsl:when>
									<xsl:when test="$position = 5">
										<fo:table-cell column-number="8" font-weight="bold" text-align="right">
											<fo:block>
												<xsl:choose>
													<xsl:when test="string(.) != ''">
														<xsl:value-of select="."/>
													</xsl:when>
													<xsl:otherwise>
														<fo:inline></fo:inline>
													</xsl:otherwise>
												</xsl:choose>
											</fo:block>
										</fo:table-cell>
									</xsl:when>
								</xsl:choose>
							</xsl:for-each>
						</fo:table-row>
					</fo:table-header>
					<fo:table-body>
						<xsl:for-each select="Invoice/Detail/SalesItemsList/itemList/Item">
							<fo:table-row font-size="8pt">
								<fo:table-cell column-number="1" text-align="center">
									<fo:block>
										<xsl:value-of select="ItemQuantity" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell column-number="2" number-columns-spanned="3" text-align="left">
									<fo:block>
										<xsl:value-of select="Description1" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell column-number="5" text-align="center">
									<fo:block>
										<xsl:value-of select="Unit" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell column-number="6" text-align="right">
									<fo:block>
										<xsl:value-of select="Price" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell column-number="8" text-align="right">
									<fo:block>
										<xsl:value-of select="Amount" />
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
							<fo:table-row font-size="8pt">
								<fo:table-cell column-number="2" number-columns-spanned="3" text-align="left">
									<fo:block>
										<xsl:value-of select="Description2" />
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</xsl:for-each>
					</fo:table-body>
				</fo:table>
			</xsl:if>
		</fo:block>
		<!-- Delivery instruction -->
		<fo:block width="100%">
			<xsl:if test="normalize-space(Invoice/Detail/DeliveryInstructions) != ''">
				<fo:block font-size="9pt" font-weight="bold" text-align="left" space-before="10pt">DELIVERY INSTRUCTIONS :</fo:block>
				<fo:block-container font-size="8pt" text-align="left" space-before="0pt" space-after="0pt">
					<xsl:call-template name="wrap-texty">
						<xsl:with-param name="text" select="Invoice/Detail/DeliveryInstructions"/>
						<!-- <xsl:with-param name="max-length" select="40"/> -->
					</xsl:call-template>
				</fo:block-container>
			</xsl:if>
		</fo:block>
	</xsl:template>
    <!-- Text warpper -->
	<xsl:template name="wrap-texty">
		<xsl:param name="text"/>
		<xsl:param name="max-length" select="50"/>
		<xsl:choose>
			<xsl:when test="string-length($text) > $max-length">
				<fo:block linefeed-treatment="preserve" white-space-treatment="preserve" white-space="pre" space-before="0pt" space-after="0pt">
					<xsl:value-of select="substring($text, 1, $max-length)"/>
				</fo:block>
				<xsl:call-template name="wrap-texty">
					<xsl:with-param name="text" select="substring($text, $max-length + 1)"/>
					<xsl:with-param name="max-length" select="$max-length"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<fo:block linefeed-treatment="preserve" white-space-treatment="preserve" white-space="pre" space-before="0pt" space-after="0pt">
					<xsl:value-of select="$text"/>
				</fo:block>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>