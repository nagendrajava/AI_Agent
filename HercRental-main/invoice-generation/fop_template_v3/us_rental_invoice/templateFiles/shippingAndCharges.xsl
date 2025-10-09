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
								<!-- Condition Tag -->
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
                                                                <!-- ShipTo details -->
																<fo:table-cell column-number="1" text-align="left">
																	<fo:block font-size="8pt" font-family="Verdana" font-weight="bold" text-decoration="underline">
                                                                    SHIP TO:
                                                                    </fo:block>
																	<fo:block font-size="8pt" font-family="Verdana">
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
                                                                        Job#: 
																		<xsl:value-of select="Invoice/Detail/ShipTo/JobID" />
																		<xsl:value-of select="'&#x2028;'" />
																		<xsl:value-of select="'&#x2028;'" />
																	</fo:block>
																</fo:table-cell>
                                                                <!-- Rented from details -->
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
															<!-- Rental details -->
															<xsl:if test="Invoice/Detail/RentalDetails">
																<fo:table-row font-size="8pt">
																	<fo:table-cell column-number="1" number-columns-spanned="2" text-align="left">
																		<fo:block >
																			<!-- Testing if it spans to next column with in the table -->
																			<fo:table table-layout="fixed" width="80%" border="1pt solid black">
																				<fo:table-column column-width="50%" />
																				<fo:table-column column-width="25%" />
																				<fo:table-column column-width="25%" />
																				<fo:table-body>
																					<fo:table-row font-size="8pt">
																						<fo:table-cell column-number="1" text-align="left">
																							<fo:block font-size="8pt" font-family="Verdana" text-align="right">
                                                                                                RENTAL DAYS/HOURS:
                                                                                            </fo:block>
																						</fo:table-cell>
																						<fo:table-cell column-number="3" text-align="left">
																							<fo:block font-size="8pt" font-family="Verdana">
																								<xsl:value-of select="Invoice/Detail/RentalDetails/Days" />
                                                                                                /                                                                                    
																								<xsl:value-of select="Invoice/Detail/RentalDetails/Hours"/>
																							</fo:block>
																						</fo:table-cell>
																					</fo:table-row>
																					<fo:table-row font-size="8pt">
																						<fo:table-cell column-number="1" text-align="left">
																							<fo:block font-size="8pt" font-family="Verdana" text-align="right">
                                                                                                INVOICE FROM:
                                                                                            </fo:block>
																						</fo:table-cell>
																						<fo:table-cell column-number="2" text-align="center">
																							<fo:block font-size="8pt" font-family="Verdana">
																								<xsl:value-of select="Invoice/Detail/RentalDetails/InvoiceFromDate" />
																							</fo:block>
																						</fo:table-cell>
																						<fo:table-cell column-number="3" text-align="left">
																							<fo:block font-size="8pt" font-family="Verdana">
																								<xsl:value-of select="Invoice/Detail/RentalDetails/InvoiceFromTime" />
																							</fo:block>
																						</fo:table-cell>
																					</fo:table-row>
																					<fo:table-row font-size="8pt">
																						<fo:table-cell column-number="1" text-align="left">
																							<fo:block font-size="8pt" font-family="Verdana" text-align="right">
                                                                                                INVOICE TO:
                                                                                            </fo:block>
																						</fo:table-cell>
																						<fo:table-cell column-number="2" text-align="center">
																							<fo:block font-size="8pt" font-family="Verdana">
																								<xsl:value-of select="Invoice/Detail/RentalDetails/InvoiceToDate" />
																							</fo:block>
																						</fo:table-cell>
																						<fo:table-cell column-number="3" text-align="left">
																							<fo:block font-size="8pt" font-family="Verdana">
																								<xsl:value-of select="Invoice/Detail/RentalDetails/InvoiceToTime" />
																							</fo:block>
																						</fo:table-cell>
																					</fo:table-row>
																				</fo:table-body>
																			</fo:table>
																		</fo:block>
																	</fo:table-cell>
																</fo:table-row>
																<fo:table-row font-size="8pt">
																	<fo:table-cell column-number="1" number-columns-spanned="2" text-align="left">
																		<fo:block >
																			<!-- Testing if it spans to next column with in the table -->
																			<fo:table table-layout="fixed" width="80%" margin-top="5pt" margin-bottom="5pt">
																				<fo:table-column column-width="50%" />
																				<fo:table-column column-width="25%" />
																				<fo:table-column column-width="25%" />
																				<fo:table-body>
																					<fo:table-row font-size="8pt">
																						<fo:table-cell column-number="1" text-align="left">
																							<fo:block font-size="8pt" font-family="Verdana" text-align="right">
                                                                                                RENTAL START DATE:
                                                                                            </fo:block>
																						</fo:table-cell>
																						<fo:table-cell column-number="2" text-align="center">
																							<fo:block font-size="8pt" font-family="Verdana">
																								<xsl:value-of select="Invoice/Detail/RentalDetails/RentalStartDate" />
																							</fo:block>
																						</fo:table-cell>
																						<fo:table-cell column-number="3" text-align="left">
																							<fo:block font-size="8pt" font-family="Verdana">
																								<xsl:value-of select="Invoice/Detail/RentalDetails/RentalStartTime" />
																							</fo:block>
																						</fo:table-cell>
																					</fo:table-row>
																				</fo:table-body>
																			</fo:table>
																		</fo:block>
																	</fo:table-cell>
																</fo:table-row>
															</xsl:if>
														</fo:table-body>
													</fo:table>
												</fo:block>
											</fo:table-cell>
                                            
											<fo:table-cell column-number="2" text-align="left">
												<fo:block>
                                                    <!-- Charges amount details -->
													<fo:table table-layout="fixed" width="100%">
														<fo:table-column column-width="34%" border="1pt solid black"/>
														<fo:table-column column-width="22%" border="1pt solid black"/>
														<fo:table-column column-width="22%" border="1pt solid black"/>
														<fo:table-column column-width="22%" border="1pt solid black"/>
														<fo:table-body>
                                                            <!-- Heading -->
															<fo:table-row font-size="8pt">
																<fo:table-cell column-number="1" text-align="left" border-bottom="1pt solid black">
																	<fo:block font-size="8pt" font-family="Verdana"></fo:block>
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
                                                            <!-- RENTAL CHARGES -->
															<fo:table-row font-size="8pt">
																<fo:table-cell column-number="1" text-align="right">
																	<fo:block font-size="8pt" font-family="Verdana">RENTAL CHARGES</fo:block>
																</fo:table-cell>
																<fo:table-cell column-number="2" text-align="right">
																	<fo:block font-size="8pt" font-family="Verdana">
																		<xsl:value-of select="Invoice/Detail/RentalCharges/Original" />
																	</fo:block>
																</fo:table-cell>
																<fo:table-cell column-number="3" text-align="right">
																	<fo:block font-size="8pt" font-family="Verdana">
																		<xsl:value-of select="Invoice/Detail/RentalCharges/Adjustment" />
																	</fo:block>
																</fo:table-cell>
																<fo:table-cell column-number="4" text-align="right">
																	<fo:block font-size="8pt" font-family="Verdana">
																		<xsl:value-of select="Invoice/Detail/RentalCharges/Total" />
																	</fo:block>
																</fo:table-cell>
															</fo:table-row>
                                                            <!-- OTHER CHARGES -->
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
                                                            <!-- RENTAL - Optional -->
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
                                                            <!-- PROTECTION FUEL CHARGES - Optional -->
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
                                                            <!-- DELIVERY/PICK UP - Optional -->
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
															<!-- DELIVERY CHARGES - Optional -->
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
                                                            <!-- TAXABLE CHARGES -->
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
                                                            <!-- TAX -->
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
                                                            <!-- COUPON APPLIED - Optional -->
															<xsl:if test="Invoice/Detail/CouponApplied">
																<fo:table-row font-size="8pt">
																	<fo:table-cell column-number="1" text-align="right">
																		<fo:block font-size="8pt" font-family="Verdana">COUPON APPLIED</fo:block>
																	</fo:table-cell>
																	<fo:table-cell column-number="2" text-align="right">
																		<fo:block font-size="8pt" font-family="Verdana">
																			<xsl:value-of select="Invoice/Detail/CouponApplied/Original" />
																		</fo:block>
																	</fo:table-cell>
																	<fo:table-cell column-number="3" text-align="right">
																		<fo:block font-size="8pt" font-family="Verdana">
																			<xsl:value-of select="Invoice/Detail/CouponApplied/Adjustment" />
																		</fo:block>
																	</fo:table-cell>
																	<fo:table-cell column-number="4" text-align="right">
																		<fo:block font-size="8pt" font-family="Verdana">
																			<xsl:value-of select="Invoice/Detail/CouponApplied/Total" />
																		</fo:block>
																	</fo:table-cell>
																</fo:table-row>
															</xsl:if>
                                                            <!-- TOTAL CHARGES -->
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
                                                            <!-- PAYMENTS - Optional -->
															<xsl:if test="Invoice/Detail/Payments">
																<fo:table-row font-size="8pt">
																	<fo:table-cell column-number="1" text-align="right">
																		<fo:block font-size="8pt" font-family="Verdana">PAYMENTS</fo:block>
																	</fo:table-cell>
																	<fo:table-cell column-number="2" text-align="right">
																		<fo:block font-size="8pt" font-family="Verdana">
																			<xsl:value-of select="Invoice/Detail/Payments/Original" />
																		</fo:block>
																	</fo:table-cell>
																	<fo:table-cell column-number="3" text-align="right">
																		<fo:block font-size="8pt" font-family="Verdana">
																			<xsl:value-of select="Invoice/Detail/Payments/Adjustment" />
																		</fo:block>
																	</fo:table-cell>
																	<fo:table-cell column-number="4" text-align="right">
																		<fo:block font-size="8pt" font-family="Verdana">
																			<xsl:value-of select="Invoice/Detail/Payments/Total" />
																		</fo:block>
																	</fo:table-cell>
																</fo:table-row>
															</xsl:if>
														</fo:table-body>
													</fo:table>
                                                    <!-- Charges apply text -->
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