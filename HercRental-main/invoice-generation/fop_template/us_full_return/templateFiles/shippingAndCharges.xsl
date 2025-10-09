<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:template name="shippingAndCharges">
        <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format">
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
                                                    <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/Condition" />
                                                </fo:block>
                                            </fo:table-cell>
                                        </fo:table-row>

                                    </fo:table-body>
                                </fo:table>
                                <fo:table table-layout="fixed" width="100%">
                                    <fo:table-column column-width="25%" />
                                    <fo:table-column column-width="25%" />
                                    <fo:table-column column-width="50%" />
                                    <fo:table-body>
                                        <fo:table-row font-size="10pt">
                                            <fo:table-cell column-number="1" text-align="left" margin="2mm">
                                                <fo:block font-size="8pt" font-family="Verdana" font-weight="bold">
                                SHIP TO:
                                                </fo:block>
                                                <fo:block font-size="8pt" font-family="Verdana">
                                                JOB#:   <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/Ship_To/JobID" />
                                                    <xsl:value-of select="'&#x2028;'" />
                                                    <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/Ship_To/Line1" />
                                                    <xsl:value-of select="'&#x2028;'" />
                                                    <xsl:call-template name="blockWithBlank">
                                                        <xsl:with-param name="field" select="Invoice/Detail/Rental_Agreement_Info/Ship_To/Line2"/>
                                                    </xsl:call-template>
                                                    <xsl:value-of select="concat(Invoice/Detail/Rental_Agreement_Info/Ship_To/City,', ',Invoice/Detail/Rental_Agreement_Info/Ship_To/State ,' ',Invoice/Detail/Rental_Agreement_Info/Ship_To/ZipCode)" />
                                                    <xsl:value-of select="'&#x2028;'" />
                                                    PH: <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/Ship_To/PhoneNumber" />
                                                </fo:block>

                                            </fo:table-cell>
                                            <fo:table-cell column-number="2" text-align="left" margin="2mm">
                                                <fo:block font-size="8pt" font-family="Verdana" font-weight="bold">
                                RENTED FROM:
                                                </fo:block>
                                                <fo:block font-size="8pt" font-family="Verdana">
                                                    <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/Rented_From/Company_Name" />
                                                    <xsl:value-of select="'&#x2028;'" />
                                                    <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/Rented_From/Line1" />
                                                    <xsl:value-of select="'&#x2028;'" />
                                                    <xsl:call-template name="blockWithBlank">
                                                        <xsl:with-param name="field" select="Invoice/Detail/Rental_Agreement_Info/Rented_From/Line2"/>
                                                    </xsl:call-template>
                                                    <xsl:value-of select="concat(Invoice/Detail/Rental_Agreement_Info/Rented_From/City,', ',Invoice/Detail/Rental_Agreement_Info/Rented_From/State ,' ',Invoice/Detail/Rental_Agreement_Info/Rented_From/ZipCode)" />
                                                    <xsl:value-of select="'&#x2028;'" />
                                                    PH: <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/Rented_From/Phone" />
                                                    <xsl:value-of select="'&#x2028;'" />
                                                    Sales Rep: <xsl:value-of select="Invoice/Detail/OrderInfo/SalesRep" />
                                                    <xsl:value-of select="'&#x2028;'" />
                                                </fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell column-number="3" text-align="left">
                                                <fo:block>
                                                    <fo:table table-layout="fixed" width="100%">
                                                        <fo:table-column column-width="31%" border="1pt solid black"/>
                                                        <fo:table-column column-width="23%" border="1pt solid black"/>
                                                        <fo:table-column column-width="23%" border="1pt solid black"/>
                                                        <fo:table-column column-width="23%" border="1pt solid black"/>
                                                        <fo:table-body>
                                                            <fo:table-row font-size="8pt">
                                                                <fo:table-cell column-number="1" text-align="center" border-bottom="1pt solid black">
                                                                    <fo:block font-size="8pt" font-family="Verdana">
                                                                    
                                                                    </fo:block>
                                                                </fo:table-cell>
                                                                <fo:table-cell column-number="2" text-align="center" border-bottom="1pt solid black">
                                                                    <fo:block font-size="8pt" font-family="Verdana">
                                                        Original
                                                                    </fo:block>
                                                                </fo:table-cell>
                                                                <fo:table-cell column-number="3" text-align="center" border-bottom="1pt solid black">
                                                                    <fo:block font-size="8pt" font-family="Verdana">
                                                        Adjustment
                                                                    </fo:block>
                                                                </fo:table-cell>
                                                                <fo:table-cell column-number="4" text-align="center" border-bottom="1pt solid black">
                                                                    <fo:block font-size="8pt" font-family="Verdana">
                                                        Total
                                                                    </fo:block>
                                                                </fo:table-cell>
                                                            </fo:table-row>
                                                            <fo:table-row font-size="8pt">
                                                                <fo:table-cell column-number="1" text-align="right">
                                                                    <fo:block font-size="8pt" font-family="Verdana">
                                                                        RENTAL CHARGES
                                                                    </fo:block>
                                                                </fo:table-cell>
                                                                <fo:table-cell column-number="2" text-align="right">
                                                                    <fo:block font-size="8pt" font-family="Verdana">
                                                                        <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/RentalCharges/Original" />
                                                                    </fo:block>
                                                                </fo:table-cell>
                                                                <fo:table-cell column-number="3" text-align="right">
                                                                    <fo:block font-size="8pt" font-family="Verdana">
                                                                        <fo:block font-size="8pt" font-family="Verdana">
                                                                            <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/RentalCharges/Adjustment" />
                                                                        </fo:block>
                                                                    </fo:block>
                                                                </fo:table-cell>
                                                                <fo:table-cell column-number="4" text-align="right">
                                                                    <fo:block font-size="8pt" font-family="Verdana">
                                                                        <fo:block font-size="8pt" font-family="Verdana">
                                                                            <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/RentalCharges/Total" />
                                                                        </fo:block>
                                                                    </fo:block>
                                                                </fo:table-cell>
                                                            </fo:table-row>
                                                            <fo:table-row font-size="8pt">
                                                                <fo:table-cell column-number="1" text-align="right">
                                                                    <fo:block font-size="8pt" font-family="Verdana">
                                                                        OTHER CHARGES
                                                                    </fo:block>
                                                                </fo:table-cell>
                                                                <fo:table-cell column-number="2" text-align="right">
                                                                    <fo:block font-size="8pt" font-family="Verdana">
                                                                        <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/OtherCharges/Original" />
                                                                    </fo:block>
                                                                </fo:table-cell>
                                                                <fo:table-cell column-number="3" text-align="right">
                                                                    <fo:block font-size="8pt" font-family="Verdana">
                                                                        <fo:block font-size="8pt" font-family="Verdana">
                                                                            <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/OtherCharges/Adjustment" />
                                                                        </fo:block>
                                                                    </fo:block>
                                                                </fo:table-cell>
                                                                <fo:table-cell column-number="4" text-align="right">
                                                                    <fo:block font-size="8pt" font-family="Verdana">
                                                                        <fo:block font-size="8pt" font-family="Verdana">
                                                                            <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/OtherCharges/Total" />
                                                                        </fo:block>
                                                                    </fo:block>
                                                                </fo:table-cell>
                                                            </fo:table-row>
                                                            <fo:table-row font-size="8pt">
                                                                <fo:table-cell column-number="1" text-align="right">
                                                                    <fo:block font-size="8pt" font-family="Verdana">
                                                                        TAXABLE CHARGES
                                                                    </fo:block>
                                                                </fo:table-cell>
                                                                <fo:table-cell column-number="2" text-align="right">
                                                                    <fo:block font-size="8pt" font-family="Verdana">
                                                                        <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/TaxableCharges/Original" />
                                                                    </fo:block>
                                                                </fo:table-cell>
                                                                <fo:table-cell column-number="3" text-align="right">
                                                                    <fo:block font-size="8pt" font-family="Verdana">
                                                                        <fo:block font-size="8pt" font-family="Verdana">
                                                                            <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/TaxableCharges/Adjustment" />
                                                                        </fo:block>
                                                                    </fo:block>
                                                                </fo:table-cell>
                                                                <fo:table-cell column-number="4" text-align="right">
                                                                    <fo:block font-size="8pt" font-family="Verdana">
                                                                        <fo:block font-size="8pt" font-family="Verdana">
                                                                            <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/TaxableCharges/Total" />
                                                                        </fo:block>
                                                                    </fo:block>
                                                                </fo:table-cell>
                                                            </fo:table-row>
                                                            <fo:table-row font-size="8pt">
                                                                <fo:table-cell column-number="1" text-align="right">
                                                                    <fo:block font-size="8pt" font-family="Verdana">
                                                                        TAX
                                                                    </fo:block>
                                                                </fo:table-cell>
                                                                <fo:table-cell column-number="2" text-align="right">
                                                                    <fo:block font-size="8pt" font-family="Verdana">
                                                                        <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/Tax/Original" />
                                                                    </fo:block>
                                                                </fo:table-cell>
                                                                <fo:table-cell column-number="3" text-align="right">
                                                                    <fo:block font-size="8pt" font-family="Verdana">
                                                                        <fo:block font-size="8pt" font-family="Verdana">
                                                                            <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/Tax/Adjustment" />
                                                                        </fo:block>
                                                                    </fo:block>
                                                                </fo:table-cell>
                                                                <fo:table-cell column-number="4" text-align="right">
                                                                    <fo:block font-size="8pt" font-family="Verdana">
                                                                        <fo:block font-size="8pt" font-family="Verdana">
                                                                            <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/Tax/Total" />
                                                                        </fo:block>
                                                                    </fo:block>
                                                                </fo:table-cell>
                                                            </fo:table-row>
                                                            <fo:table-row font-size="8pt">
                                                                <fo:table-cell column-number="1" text-align="right">
                                                                    <fo:block font-size="8pt" font-family="Verdana">
                                                                        TOTAL CHARGES
                                                                    </fo:block>
                                                                </fo:table-cell>
                                                                <fo:table-cell column-number="2" text-align="right">
                                                                    <fo:block font-size="8pt" font-family="Verdana">
                                                                        <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/TotalCharges/Original" />
                                                                    </fo:block>
                                                                </fo:table-cell>
                                                                <fo:table-cell column-number="3" text-align="right">
                                                                    <fo:block font-size="8pt" font-family="Verdana">
                                                                        <fo:block font-size="8pt" font-family="Verdana">
                                                                            <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/TotalCharges/Adjustment" />
                                                                        </fo:block>
                                                                    </fo:block>
                                                                </fo:table-cell>
                                                                <fo:table-cell column-number="4" text-align="right">
                                                                    <fo:block font-size="8pt" font-family="Verdana">
                                                                        <fo:block font-size="8pt" font-family="Verdana">
                                                                            <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/TotalCharges/Total" />
                                                                        </fo:block>
                                                                    </fo:block>
                                                                </fo:table-cell>
                                                            </fo:table-row>
                                                        </fo:table-body>
                                                    </fo:table>
                                                    <fo:table table-layout="fixed" width="100%" margin-top="2mm">
                                                        <fo:table-column column-width="100%" />
                                                
                                                        <fo:table-body>
                                                            <fo:table-row font-size="8pt">
                                                                <fo:table-cell column-number="1" text-align="center">
                                                                    <fo:block font-size="8pt" font-family="Verdana" font-style="italic" font-weight="bold">
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