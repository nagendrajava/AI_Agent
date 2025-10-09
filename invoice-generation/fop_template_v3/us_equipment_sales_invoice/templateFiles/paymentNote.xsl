<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:template name="wrap-text">
		<xsl:param name="text"/>
		<xsl:param name="width"/>
		<xsl:choose>
			<xsl:when test="string-length($text) > $width">
				<xsl:value-of select="substring($text, 1, $width)"/>
				<xsl:text>&#xA;</xsl:text>
				<xsl:call-template name="wrap-text">
					<xsl:with-param name="text" select="substring($text, $width + 1)"/>
					<xsl:with-param name="width" select="$width"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$text"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
    
	<xsl:template name="paymentNote">
		<fo:block
			xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<fo:table width="100%" margin-left="6%" margin-right="auto">
				<fo:table-column column-width="100%" />
				<fo:table-body>
					<fo:table-row font-size="8pt">
						<fo:table-cell column-number="1">
							<fo:table table-layout="fixed" width="100%" margin="1%">
								<fo:table-column column-width="70%"  />
								<fo:table-body >
									<fo:table-row font-size="8pt">
										<fo:table-cell column-number="1" border="1pt solid black" text-align="left" margin-left="0px">
											<fo:block>
												<xsl:value-of select="Invoice/Detail/RentalAgreementInfo/PaymentNotes/Line1" />
											</fo:block>
											<fo:block>
												<xsl:value-of select="Invoice/Detail/RentalAgreementInfo/PaymentNotes/Line2" />
											</fo:block>
											<fo:block>
												<xsl:value-of select="'&#x2028;'" />
												<!--                                                <xsl:value-of select="'&#x2028;'" />-->
											</fo:block>
											<fo:block font-weight="bold">
												<xsl:value-of select="Invoice/Detail/RentalAgreementInfo/PaymentNotes/Line3" />
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</fo:table-body>
							</fo:table>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
			<fo:table width="98%" margin-left="1%" margin-right="1%">
				<fo:table-column column-width="17%" />
				<fo:table-column column-width="14%" />
				<fo:table-column column-width="14%" />
				<fo:table-column column-width="13%" />
				<fo:table-column column-width="29%" />
				<fo:table-column column-width="13%" />
				<fo:table-body>
					<fo:table-row font-size="8pt">
						<fo:table-cell column-number="1" border="1pt solid black" text-align="center">
							<fo:block>Revenue Approval #</fo:block>
						</fo:table-cell>
						<fo:table-cell column-number="2" border="1pt solid black" text-align="center">
							<fo:block>Credit Approval #</fo:block>
						</fo:table-cell>
						<fo:table-cell column-number="3" border="1pt solid black" text-align="center">
							<fo:block>Lodd Approval #</fo:block>
						</fo:table-cell>
						<fo:table-cell column-number="4" border="1pt solid black" text-align="center">
							<fo:block>Corp Approval #</fo:block>
						</fo:table-cell>
						<fo:table-cell column-number="5" border="1pt solid black" text-align="center">
							<fo:block text-align="left">&#160; Delivery on : 
								<xsl:value-of select="Invoice/Detail/OrderInfo/DeliveredOn" />
							</fo:block>
							<fo:block>Ship Via:</fo:block>
							<fo:block>[&#160;&#160;&#160;] Seller's carrier [&#160;&#160;&#160;] Buyer's carrier</fo:block>
						</fo:table-cell>
						<fo:table-cell column-number="6" border="1pt solid black" text-align="center">
							<fo:block>Revenue Type:</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
			<fo:table width="98%" margin-left="1%" margin-right="1%">
				<fo:table-column column-width="100%" />
				<!-- Adjust column width as needed -->
				<fo:table-body>
					<!-- Row for line2 -->
					<fo:table-row>
						<fo:table-cell border="1pt solid black">
							<fo:block font-size="8pt">
								<xsl:value-of select="Invoice/Detail/RentalAgreementInfo/new/line2" />
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<!-- Row for line3 (with title "ODOMETER DISCLOSURE STATEMENT") -->
					<fo:table-row>
						<fo:table-cell border="1pt solid black">
							<fo:block font-size="8pt" border-top="none" text-decoration="underline" text-align="center" font-weight="bold">
                                ODOMETER DISCLOSURE STATEMENT
                            </fo:block>
							<fo:block font-size="8pt">
								<xsl:value-of select="Invoice/Detail/RentalAgreementInfo/new/line3" />
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<!-- Row for line4 and additional line -->
					<fo:table-row>
						<fo:table-cell  border-top="none">
							<fo:block font-size="8pt" space-after="12pt" text-align="justify" white-space-treatment="preserve" linefeed-treatment="preserve" white-space-collapse="false">
								<fo:block>
									<xsl:value-of select="Invoice/Detail/RentalAgreementInfo/new/line4" />
								</fo:block>
								<fo:block>
									<xsl:value-of select="Invoice/Detail/RentalAgreementInfo/new/line5" />
								</fo:block>
								<fo:block>
									<xsl:value-of select="Invoice/Detail/RentalAgreementInfo/new/line6" />
								</fo:block>
								<fo:block>
									<xsl:value-of select="Invoice/Detail/RentalAgreementInfo/new/line7" />
								</fo:block>
								<fo:block>
									<xsl:value-of select="Invoice/Detail/RentalAgreementInfo/new/line8" />
								</fo:block>
								<fo:block>
									<xsl:value-of select="Invoice/Detail/RentalAgreementInfo/new/line9" />
								</fo:block>
								<fo:block font-size="8pt" font-weight="bold">
									<xsl:value-of select="Invoice/Detail/RentalAgreementInfo/new/lin" />
								</fo:block>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<!-- Row for SurchargeNotes Line1 -->
					<fo:table-row>
						<fo:table-cell border="1pt solid black">
							<fo:block font-size="8pt">
								<xsl:value-of select="Invoice/Detail/RentalAgreementInfo/SurchargeNotes/Line1" />
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<!-- Row for SurchargeNotes Line2 -->
					<fo:table-row>
						<fo:table-cell border="1pt solid black">
							<fo:block font-size="8pt">
								<xsl:value-of select="Invoice/Detail/RentalAgreementInfo/SurchargeNotes/Line2" />
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
			<fo:block font-size="8pt">
				<xsl:value-of select="Invoice/Detail/SurchargeNotes/Line1" />
			</fo:block>
			<fo:block font-size="8pt">
				<xsl:value-of select="Invoice/Detail/SurchargeNotes/Line2" />
			</fo:block>
			<fo:block font-family="serif" font-size="8pt" space-after="12pt" text-align="justify" white-space-treatment="preserve" linefeed-treatment="preserve" white-space-collapse="false">
				<xsl:call-template name="wrap-text">
					<xsl:with-param name="text" select="Invoice/Detail/docu/description"/>
					<xsl:with-param name="width" select="40"/>
				</xsl:call-template>
			</fo:block>
		</fo:block>
	</xsl:template>
</xsl:stylesheet>
