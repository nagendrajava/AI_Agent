<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:template name="shippingAndCharges">
		<fo:block
			xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<!-- <fo:block-container absolute-position="absolute" bottom="0pt"> -->
			<fo:table table-layout="fixed" width="100%">
				<fo:table-column column-width="100%" />
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell column-number="1">
							<fo:block break-before="auto" keep-together.within-page="always">
								<fo:table table-layout="fixed" width="100%">
									<fo:table-column column-width="100%" />
									<fo:table-body>
										<fo:table-row font-size="8pt" background-color="#c8c4c4" border="1pt solid black">
											<fo:table-cell column-number="1" border="1pt solid black" text-align="center" font-weight="bold">
												<fo:block>
													<xsl:value-of select="Invoice/Detail/RentalAgreementInfo/Condition" />
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
									</fo:table-body>
								</fo:table>
								<fo:table table-layout="fixed" width="100%">
									<fo:table-column column-width="50%" />
									<fo:table-column column-width="50%" />
									<fo:table-body>
										<fo:table-row font-size="8pt">
											<fo:table-cell column-number="1" text-align="left">
												<fo:block >
													<fo:table table-layout="fixed" width="100%">
														<fo:table-column column-width="50%" />
														<fo:table-column column-width="50%" />
														<fo:table-body>
															<fo:table-row font-size="8pt">
																<fo:table-cell column-number="1" text-align="left">
																	<fo:block font-size="8pt" font-family="Verdana" font-weight="bold" text-decoration="underline">
                                                                    SHIP TO:
                                                                    </fo:block>
																	<fo:block font-size="8pt" font-family="Verdana">
                                                                        Job#: 
																		<xsl:value-of select="Invoice/Detail/ShipTo/Job" />
																		<xsl:value-of select="'&#x2028;'" />
																		<xsl:value-of select="Invoice/Detail/ShipTo/Line1" />
																		<xsl:value-of select="'&#x2028;'" />
																		<xsl:call-template name="blockWithBlank">
																			<xsl:with-param name="field" select="Invoice/Detail/ShipTo/Line2"/>
																		</xsl:call-template>
																		<xsl:value-of select="concat(Invoice/Detail/ShipTo/City,',',Invoice/Detail/ShipTo/State ,' ',Invoice/Detail/ShipTo/ZipCode)" />
																		<xsl:value-of select="'&#x2028;'" />
                                                                        PH: 
																		<xsl:value-of select="Invoice/Detail/ShipTo/Phone" />
																		<xsl:value-of select="'&#x2028;'" />
																		<xsl:value-of select="'&#x2028;'" />
																	</fo:block>
																</fo:table-cell>
																<fo:table-cell column-number="2" text-align="left">
																	<fo:block font-size="8pt" font-family="Verdana" font-weight="bold" text-decoration="underline">
                                                                    RENTED FROM:
                                                                </fo:block>
																	<fo:block font-size="8pt" font-family="Verdana">
																		<xsl:value-of select="Invoice/Detail/RentedFrom/CompanyName" />
																		<xsl:value-of select="'&#x2028;'" />
																		<xsl:value-of select="Invoice/Detail/RentedFrom/Line1" />
																		<xsl:value-of select="'&#x2028;'" />
																		<xsl:call-template name="blockWithBlank">
																			<xsl:with-param name="field" select="Invoice/Detail/RentedFrom/Line2"/>
																		</xsl:call-template>
																		<xsl:value-of select="concat(Invoice/Detail/RentedFrom/City,',',Invoice/Detail/RentedFrom/State ,' ',Invoice/Detail/RentedFrom/ZipCode)" />
																		<xsl:value-of select="'&#x2028;'" />
																		<xsl:value-of select="Invoice/Detail/RentedFrom/Phone" />
																		<xsl:value-of select="'&#x2028;'" />
                                                                        Sales Rep: 
																		<xsl:value-of select="Invoice/Detail/RentedFrom/SalesRep" />
																		<xsl:value-of select="'&#x2028;'" />
																		<xsl:value-of select="'&#x2028;'" />
																	</fo:block>
																</fo:table-cell>
															</fo:table-row>
														</fo:table-body>
													</fo:table>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell column-number="2" text-align="left">
												<fo:block>
													<fo:table table-layout="fixed" width="100%">
														<fo:table-column column-width="34%" border="1pt solid black"/>
														<fo:table-column column-width="22%" border="1pt solid black"/>
														<fo:table-column column-width="22%" border="1pt solid black"/>
														<fo:table-column column-width="22%" border="1pt solid black"/>
														<fo:table-body>
															<fo:table-row font-size="8pt">
																<fo:table-cell column-number="1" text-align="center" border-bottom="1pt solid black">
																	<fo:block font-size="8pt" font-family="Verdana">TOTALS</fo:block>
																</fo:table-cell>
																<fo:table-cell column-number="2" text-align="center" border-bottom="1pt solid black">
																	<fo:block font-size="8pt" font-family="Verdana">Original</fo:block>
																</fo:table-cell>
																<fo:table-cell column-number="3" text-align="center" border-bottom="1pt solid black">
																	<fo:block font-size="8pt" font-family="Verdana">Adjustments</fo:block>
																</fo:table-cell>
																<fo:table-cell column-number="4" text-align="center" border-bottom="1pt solid black">
																	<fo:block font-size="8pt" font-family="Verdana">Total</fo:block>
																</fo:table-cell>
															</fo:table-row>
															<fo:table-row font-size="8pt">
																<fo:table-cell column-number="1" text-align="right">
																	<fo:block font-size="8pt" font-family="Verdana">SALES ITEMS</fo:block>
																</fo:table-cell>
																<fo:table-cell column-number="2" text-align="right">
																	<fo:block font-size="8pt" font-family="Verdana">
																		<xsl:value-of select="Invoice/Detail/SalesItems/Original" />
																	</fo:block>
																</fo:table-cell>
																<fo:table-cell column-number="3" text-align="right">
																	<fo:block font-size="8pt" font-family="Verdana">
																		<xsl:value-of select="Invoice/Detail/SalesItems/Adjustment" />
																	</fo:block>
																</fo:table-cell>
																<fo:table-cell column-number="4" text-align="right">
																	<fo:block font-size="8pt" font-family="Verdana">
																		<xsl:value-of select="Invoice/Detail/SalesItems/Total" />
																	</fo:block>
																</fo:table-cell>
															</fo:table-row>
															<xsl:if test="Invoice/Detail/OtherCharges">
																<fo:table-row font-size="8pt">
																	<fo:table-cell column-number="1" text-align="right">
																		<fo:block font-size="8pt" font-family="Verdana">OTHER CHARGES</fo:block>
																	</fo:table-cell>
																	<fo:table-cell column-number="2" text-align="right">
																		<fo:block font-size="8pt" font-family="Verdana">
																			<xsl:value-of select="Invoice/Detail/OtherCharges/Original" />
																		</fo:block>
																	</fo:table-cell>
																	<fo:table-cell column-number="3" text-align="right">
																		<fo:block font-size="8pt" font-family="Verdana">
																			<xsl:value-of select="Invoice/Detail/OtherCharges/Adjustment" />
																		</fo:block>
																	</fo:table-cell>
																	<fo:table-cell column-number="4" text-align="right">
																		<fo:block font-size="8pt" font-family="Verdana">
																			<xsl:value-of select="Invoice/Detail/OtherCharges/Total" />
																		</fo:block>
																	</fo:table-cell>
																</fo:table-row>
															</xsl:if>
															<xsl:if test="Invoice/Detail/RentalProtection">
																<fo:table-row font-size="8pt">
																	<fo:table-cell column-number="1" text-align="right">
																		<fo:block font-size="8pt" font-family="Verdana">RENTAL</fo:block>
																	</fo:table-cell>
																	<fo:table-cell column-number="2" text-align="right">
																		<fo:block font-size="8pt" font-family="Verdana">
																			<xsl:value-of select="Invoice/Detail/RentalProtection/Original" />
																		</fo:block>
																	</fo:table-cell>
																	<fo:table-cell column-number="3" text-align="right">
																		<fo:block font-size="8pt" font-family="Verdana">
																			<xsl:value-of select="Invoice/Detail/RentalProtection/Adjustment" />
																		</fo:block>
																	</fo:table-cell>
																	<fo:table-cell column-number="4" text-align="right">
																		<fo:block font-size="8pt" font-family="Verdana">
																			<xsl:value-of select="Invoice/Detail/RentalProtection/Total" />
																		</fo:block>
																	</fo:table-cell>
																</fo:table-row>
															</xsl:if>
															<xsl:if test="Invoice/Detail/ProtectionFuelCharges">
																<fo:table-row font-size="8pt">
																	<fo:table-cell column-number="1" text-align="right">
																		<fo:block font-size="8pt" font-family="Verdana">PROTECTION FUEL CHARGES</fo:block>
																	</fo:table-cell>
																	<fo:table-cell column-number="2" text-align="right" display-align="after">
																		<fo:block font-size="8pt" font-family="Verdana">
																			<xsl:value-of select="Invoice/Detail/ProtectionFuelCharges/Original" />
																		</fo:block>
																	</fo:table-cell>
																	<fo:table-cell column-number="3" text-align="right" display-align="after">
																		<fo:block font-size="8pt" font-family="Verdana">
																			<xsl:value-of select="Invoice/Detail/ProtectionFuelCharges/Adjustment" />
																		</fo:block>
																	</fo:table-cell>
																	<fo:table-cell column-number="4" text-align="right" display-align="after">
																		<fo:block font-size="8pt" font-family="Verdana">
																			<xsl:value-of select="Invoice/Detail/ProtectionFuelCharges/Total" />
																		</fo:block>
																	</fo:table-cell>
																</fo:table-row>
															</xsl:if>
															<xsl:if test="Invoice/Detail/DeliveryPickupCharges">
																<fo:table-row font-size="8pt">
																	<fo:table-cell column-number="1" text-align="right">
																		<fo:block font-size="8pt" font-family="Verdana">DELIVERY/PICK UP</fo:block>
																	</fo:table-cell>
																	<fo:table-cell column-number="2" text-align="right">
																		<fo:block font-size="8pt" font-family="Verdana">
																			<xsl:value-of select="Invoice/Detail/DeliveryPickupCharges/Original" />
																		</fo:block>
																	</fo:table-cell>
																	<fo:table-cell column-number="3" text-align="right">
																		<fo:block font-size="8pt" font-family="Verdana">
																			<xsl:value-of select="Invoice/Detail/DeliveryPickupCharges/Adjustment" />
																		</fo:block>
																	</fo:table-cell>
																	<fo:table-cell column-number="4" text-align="right">
																		<fo:block font-size="8pt" font-family="Verdana">
																			<fo:block font-size="8pt" font-family="Verdana">
																				<xsl:value-of select="Invoice/Detail/DeliveryPickupCharges/Total" />
																			</fo:block>
																		</fo:block>
																	</fo:table-cell>
																</fo:table-row>
															</xsl:if>
															<xsl:if test="Invoice/Detail/DeliveryCharges">
																<fo:table-row font-size="8pt">
																	<fo:table-cell column-number="1" text-align="right">
																		<fo:block font-size="8pt" font-family="Verdana">DELIVERY CHARGES</fo:block>
																	</fo:table-cell>
																	<fo:table-cell column-number="2" text-align="right">
																		<fo:block font-size="8pt" font-family="Verdana">
																			<xsl:value-of select="Invoice/Detail/DeliveryCharges/Original" />
																		</fo:block>
																	</fo:table-cell>
																	<fo:table-cell column-number="3" text-align="right">
																		<fo:block font-size="8pt" font-family="Verdana">
																			<xsl:value-of select="Invoice/Detail/DeliveryCharges/Adjustment" />
																		</fo:block>
																	</fo:table-cell>
																	<fo:table-cell column-number="4" text-align="right">
																		<fo:block font-size="8pt" font-family="Verdana">
																			<xsl:value-of select="Invoice/Detail/DeliveryCharges/Total" />
																		</fo:block>
																	</fo:table-cell>
																</fo:table-row>
															</xsl:if>
															<fo:table-row font-size="8pt">
																<fo:table-cell column-number="1" text-align="right">
																	<fo:block font-size="8pt" font-family="Verdana">TAXABLE CHARGES</fo:block>
																</fo:table-cell>
																<fo:table-cell column-number="2" text-align="right">
																	<fo:block font-size="8pt" font-family="Verdana">
																		<xsl:value-of select="Invoice/Detail/TaxableCharges/Original" />
																	</fo:block>
																</fo:table-cell>
																<fo:table-cell column-number="3" text-align="right">
																	<fo:block font-size="8pt" font-family="Verdana">
																		<xsl:value-of select="Invoice/Detail/TaxableCharges/Adjustment" />
																	</fo:block>
																</fo:table-cell>
																<fo:table-cell column-number="4" text-align="right">
																	<fo:block font-size="8pt" font-family="Verdana">
																		<xsl:value-of select="Invoice/Detail/TaxableCharges/Total" />
																	</fo:block>
																</fo:table-cell>
															</fo:table-row>
															<fo:table-row font-size="8pt">
																<fo:table-cell column-number="1" text-align="right">
																	<fo:block font-size="8pt" font-family="Verdana">TAX</fo:block>
																</fo:table-cell>
																<fo:table-cell column-number="2" text-align="right">
																	<fo:block font-size="8pt" font-family="Verdana">
																		<xsl:value-of select="Invoice/Detail/Tax/Original" />
																	</fo:block>
																</fo:table-cell>
																<fo:table-cell column-number="3" text-align="right">
																	<fo:block font-size="8pt" font-family="Verdana">
																		<xsl:value-of select="Invoice/Detail/Tax/Adjustment" />
																	</fo:block>
																</fo:table-cell>
																<fo:table-cell column-number="4" text-align="right">
																	<fo:block font-size="8pt" font-family="Verdana">
																		<xsl:value-of select="Invoice/Detail/Tax/Total" />
																	</fo:block>
																</fo:table-cell>
															</fo:table-row>
															<fo:table-row font-size="8pt">
																<fo:table-cell column-number="1" text-align="right">
																	<fo:block font-size="8pt" font-family="Verdana">TOTAL CHARGES</fo:block>
																</fo:table-cell>
																<fo:table-cell column-number="2" text-align="right">
																	<fo:block font-size="8pt" font-family="Verdana">
																		<xsl:value-of select="Invoice/Detail/TotalCharges/Original" />
																	</fo:block>
																</fo:table-cell>
																<fo:table-cell column-number="3" text-align="right">
																	<fo:block font-size="8pt" font-family="Verdana">
																		<xsl:value-of select="Invoice/Detail/TotalCharges/Adjustment" />
																	</fo:block>
																</fo:table-cell>
																<fo:table-cell column-number="4" text-align="right">
																	<fo:block font-size="8pt" font-family="Verdana">
																		<xsl:value-of select="Invoice/Detail/TotalCharges/Total" />
																	</fo:block>
																</fo:table-cell>
															</fo:table-row>
														</fo:table-body>
													</fo:table>
													<fo:table table-layout="fixed" width="100%">
														<fo:table-column column-width="100%" />
														<fo:table-body>
															<fo:table-row font-size="8pt">
																<fo:table-cell column-number="1" text-align="center">
																	<fo:block font-size="8pt" font-family="Verdana" font-style="italic" font-weight="bold">
																		<xsl:value-of select="'&#x2028;'" />
                                                                        LATE CHARGES MAY APPLY
																	</fo:block>
																</fo:table-cell>
															</fo:table-row>
														</fo:table-body>
													</fo:table>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
									</fo:table-body>
								</fo:table>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
			<!-- </fo:block-container> -->
		</fo:block>
	</xsl:template>
</xsl:stylesheet>