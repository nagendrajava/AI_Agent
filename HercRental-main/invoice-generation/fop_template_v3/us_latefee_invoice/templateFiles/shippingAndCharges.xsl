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
                                    <fo:table-column column-width="50%" />
                                    <fo:table-column column-width="50%" />
                                    <fo:table-body>
                                        <fo:table-row font-size="8pt">
                                            <fo:table-cell column-number="1" text-align="left">
                                                <fo:block >
                                                    <fo:table table-layout="fixed" width="100%">
                                                        <fo:table-column column-width="4%" />
                                                        <fo:table-column column-width="95%" />
                                                        <fo:table-column column-width="1%" />
                                                        <fo:table-body>
                                                            <fo:table-row font-size="8pt">
                                                                <fo:table-cell column-number="2" text-align="left">
                                                                    <fo:block font-size="8pt" font-weight="bold" font-family="Verdana">
                                                                        <fo:block>
                                                                            <xsl:value-of select="'&#x2028;'" />
                                                                        </fo:block>
                                                                        <fo:block>
                                                                            <xsl:value-of select="Invoice/Detail/ShipTo/Line1" />
                                                                        </fo:block>
                                                                        <fo:block>
                                                                            <xsl:value-of select="Invoice/Detail/ShipTo/Line2" />
                                                                        </fo:block>
                                                                        <fo:block>
                                                                            <xsl:value-of select="Invoice/Detail/ShipTo/Line3" />
                                                                        </fo:block>
                                                                    </fo:block>
                                                                </fo:table-cell>
                                                            </fo:table-row>
                                                            <!--                                                        <fo:table-row font-size="8pt">-->
                                                            <!--                                                            <fo:table-cell column-number="1" number-columns-spanned="2" text-align="left">-->
                                                            <!--                                                                <fo:block >-->
                                                            <!--                                                                    &lt;!&ndash; Testing if it spans to next column with in the table &ndash;&gt;-->
                                                            <!--                                                                    <fo:table table-layout="fixed" width="80%" border="1pt solid black">-->
                                                            <!--                                                                        <fo:table-column column-width="50%" />-->
                                                            <!--                                                                        <fo:table-column column-width="25%" />-->
                                                            <!--                                                                        <fo:table-column column-width="25%" />-->
                                                            <!--                                                                        <fo:table-body>-->
                                                            <!--                                                                            <fo:table-row font-size="8pt">-->
                                                            <!--                                                                                <fo:table-cell column-number="1" text-align="left">-->
                                                            <!--                                                                                    <fo:block font-size="8pt" font-family="Verdana" text-align="right">-->
                                                            <!--                                                                                        RENTAL DAYS:-->
                                                            <!--                                                                                    </fo:block>-->
                                                            <!--                                                                                </fo:table-cell>-->
                                                            <!--                                                                                <fo:table-cell column-number="3" text-align="left">-->
                                                            <!--                                                                                    <fo:block font-size="8pt" font-family="Verdana">-->
                                                            <!--                                                                                        <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/Rental_Details/Days" />-->
                                                            <!--                                                                                    </fo:block>-->
                                                            <!--                                                                                </fo:table-cell>-->
                                                            <!--                                                                            </fo:table-row>-->
                                                            <!--                                                                            <fo:table-row font-size="8pt">-->
                                                            <!--                                                                                <fo:table-cell column-number="1" text-align="left">-->
                                                            <!--                                                                                    <fo:block font-size="8pt" font-family="Verdana" text-align="right">-->
                                                            <!--                                                                                        INVOICE FROM:-->
                                                            <!--                                                                                    </fo:block>-->
                                                            <!--                                                                                </fo:table-cell>-->
                                                            <!--                                                                                <fo:table-cell column-number="2" text-align="center">-->
                                                            <!--                                                                                    <fo:block font-size="8pt" font-family="Verdana">-->
                                                            <!--                                                                                        <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/Rental_Details/InvoiceFromDate" />-->
                                                            <!--                                                                                    </fo:block>-->
                                                            <!--                                                                                </fo:table-cell>-->
                                                            <!--                                                                            </fo:table-row>-->
                                                            <!--                                                                            <fo:table-row font-size="8pt">-->
                                                            <!--                                                                                <fo:table-cell column-number="1" text-align="left">-->
                                                            <!--                                                                                    <fo:block font-size="8pt" font-family="Verdana" text-align="right">-->
                                                            <!--                                                                                        INVOICE TO:-->
                                                            <!--                                                                                    </fo:block>-->
                                                            <!--                                                                                </fo:table-cell>-->
                                                            <!--                                                                                <fo:table-cell column-number="2" text-align="center">-->
                                                            <!--                                                                                    <fo:block font-size="8pt" font-family="Verdana">-->
                                                            <!--                                                                                        <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/Rental_Details/InvoiceToDate" />-->
                                                            <!--                                                                                    </fo:block>-->
                                                            <!--                                                                                </fo:table-cell>-->
                                                            <!--                                                                            </fo:table-row>-->
                                                            <!--                                                                        </fo:table-body>-->
                                                            <!--                                                                    </fo:table>-->
                                                            <!--                                                                </fo:block>-->
                                                            <!--                                                            </fo:table-cell>-->
                                                            <!--                                                        </fo:table-row>-->
                                                            <!--                                                        <fo:table-row font-size="8pt">-->
                                                            <!--                                                            <fo:table-cell column-number="1" number-columns-spanned="2" text-align="left">-->
                                                            <!--                                                                <fo:block >-->
                                                            <!--                                                                    &lt;!&ndash; Testing if it spans to next column with in the table &ndash;&gt;-->
                                                            <!--                                                                    <fo:table table-layout="fixed" width="80%" margin-top="5pt" margin-bottom="5pt">-->
                                                            <!--                                                                        <fo:table-column column-width="50%" />-->
                                                            <!--                                                                        <fo:table-column column-width="25%" />-->
                                                            <!--                                                                        <fo:table-column column-width="25%" />-->
                                                            <!--                                                                        <fo:table-body>-->
                                                            <!--                                                                            <fo:table-row font-size="8pt">-->
                                                            <!--                                                                                <fo:table-cell column-number="1" text-align="left">-->
                                                            <!--                                                                                    <fo:block font-size="8pt" font-family="Verdana" text-align="right">-->
                                                            <!--                                                                                        RENTAL START DATE:-->
                                                            <!--                                                                                    </fo:block>-->
                                                            <!--                                                                                </fo:table-cell>-->
                                                            <!--                                                                                <fo:table-cell column-number="2" text-align="center">-->
                                                            <!--                                                                                    <fo:block font-size="8pt" font-family="Verdana">-->
                                                            <!--                                                                                        <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/Rental_Details/RentalStartDate" />-->
                                                            <!--                                                                                    </fo:block>-->
                                                            <!--                                                                                </fo:table-cell>-->
                                                            <!--                                                                                <fo:table-cell column-number="3" text-align="left">-->
                                                            <!--                                                                                    <fo:block font-size="8pt" font-family="Verdana">-->
                                                            <!--                                                                                        <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/Rental_Details/RentalStartTime" />-->
                                                            <!--                                                                                    </fo:block>-->
                                                            <!--                                                                                </fo:table-cell>-->
                                                            <!--                                                                            </fo:table-row>-->
                                                            <!--                                                                        </fo:table-body>-->
                                                            <!--                                                                    </fo:table>-->
                                                            <!--                                                                </fo:block>-->
                                                            <!--                                                            </fo:table-cell>-->
                                                            <!--                                                        </fo:table-row>-->
                                                        </fo:table-body>
                                                    </fo:table>
                                                </fo:block>
                                            </fo:table-cell>

                                            <fo:table-cell column-number="2"  text-align="left">
                                                <fo:block>
                                                    <fo:table table-layout="fixed"  width="100%">
                                                        <fo:table-column column-width="50%" border="1pt solid black"/>
                                                        <fo:table-column column-width="50%" border="1pt solid black"/>
                                                        <fo:table-body>
                                                            <!--                                                        <fo:table-row font-size="8pt">-->
                                                            <!--                                                            <fo:table-cell column-number="1" text-align="left" border-bottom="1pt solid black">-->
                                                            <!--                                                                <fo:block font-size="8pt" font-family="Verdana">-->
                                                            <!--                                                                     Sub-total:-->
                                                            <!--                                                                </fo:block>-->
                                                            <!--                                                            </fo:table-cell>-->
                                                            <!--&lt;!&ndash;                                                            <fo:table-cell column-number="2" text-align="center" border-bottom="1pt solid black">&ndash;&gt;-->
                                                            <!--&lt;!&ndash;                                                                <fo:block font-size="8pt" font-family="Verdana">&ndash;&gt;-->
                                                            <!--&lt;!&ndash;                                                       &ndash;&gt;-->
                                                            <!--&lt;!&ndash;                                                                </fo:block>&ndash;&gt;-->
                                                            <!--&lt;!&ndash;                                                            </fo:table-cell>&ndash;&gt;-->
                                                            <!--&lt;!&ndash;                                                            <fo:table-cell column-number="3" text-align="center" border-bottom="1pt solid black">&ndash;&gt;-->
                                                            <!--&lt;!&ndash;                                                                <fo:block font-size="8pt" font-family="Verdana">&ndash;&gt;-->
                                                            <!--&lt;!&ndash;                                                       Adjustments&ndash;&gt;-->
                                                            <!--&lt;!&ndash;                                                                </fo:block>&ndash;&gt;-->
                                                            <!--&lt;!&ndash;                                                            </fo:table-cell>&ndash;&gt;-->
                                                            <!--&lt;!&ndash;                                                            <fo:table-cell column-number="4" text-align="center" border-bottom="1pt solid black">&ndash;&gt;-->
                                                            <!--&lt;!&ndash;                                                                <fo:block font-size="8pt" font-family="Verdana">&ndash;&gt;-->
                                                            <!--&lt;!&ndash;                                                       Total&ndash;&gt;-->
                                                            <!--&lt;!&ndash;                                                                </fo:block>&ndash;&gt;-->
                                                            <!--&lt;!&ndash;                                                            </fo:table-cell>&ndash;&gt;-->
                                                            <!--                                                        </fo:table-row>-->
                                                            <fo:table-row border="1pt solid black" font-size="8pt">
                                                                <fo:table-cell column-number="1" text-align="right">
                                                                    <fo:block font-size="8pt" font-family="Verdana">
                                                                        Sub-total:
                                                                    </fo:block>
                                                                </fo:table-cell>
                                                                <fo:table-cell column-number="2" text-align="right">
                                                                    <fo:block font-size="8pt" font-family="Verdana">
                                                                        <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/RentalCharges/Original" />
                                                                    </fo:block>
                                                                </fo:table-cell>
                                                                <!--                                                            <fo:table-cell column-number="3" text-align="right">-->
                                                                <!--                                                                <fo:block font-size="8pt" font-family="Verdana">-->
                                                                <!--                                                                    <fo:block font-size="8pt" font-family="Verdana">-->
                                                                <!--                                                                        <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/RentalCharges/Adjustment" />-->
                                                                <!--                                                                    </fo:block>-->
                                                                <!--                                                                </fo:block>-->
                                                                <!--                                                            </fo:table-cell>-->
                                                                <!--                                                            <fo:table-cell column-number="4" text-align="right">-->
                                                                <!--                                                                <fo:block font-size="8pt" font-family="Verdana">-->
                                                                <!--                                                                    <fo:block font-size="8pt" font-family="Verdana">-->
                                                                <!--                                                                        <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/RentalCharges/Total" />-->
                                                                <!--                                                                    </fo:block>-->
                                                                <!--                                                                </fo:block>-->
                                                                <!--                                                            </fo:table-cell>-->
                                                            </fo:table-row>
                                                            <fo:table-row border="1pt solid black" font-size="8pt">
                                                                <fo:table-cell column-number="1" text-align="right">
                                                                    <fo:block font-size="8pt" font-family="Verdana">
                                                                        <!--                                                        OTHER CHARGES-->
                                                                    </fo:block>
                                                                </fo:table-cell>
                                                                <fo:table-cell column-number="2" text-align="right">
                                                                    <fo:block font-size="8pt" font-family="Verdana">
                                                                        <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/OtherCharges/Original" />
                                                                    </fo:block>
                                                                </fo:table-cell>
                                                                <!--                                                            <fo:table-cell column-number="3" text-align="right">-->
                                                                <!--                                                                <fo:block font-size="8pt" font-family="Verdana">-->
                                                                <!--                                                                    <fo:block font-size="8pt" font-family="Verdana">-->
                                                                <!--                                                                        <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/OtherCharges/Adjustment" />-->
                                                                <!--                                                                    </fo:block>-->
                                                                <!--                                                                </fo:block>-->
                                                                <!--                                                            </fo:table-cell>-->
                                                                <!--                                                            <fo:table-cell column-number="4" text-align="right">-->
                                                                <!--                                                                <fo:block font-size="8pt" font-family="Verdana">-->
                                                                <!--                                                                    <fo:block font-size="8pt" font-family="Verdana">-->
                                                                <!--                                                                        <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/OtherCharges/Total" />-->
                                                                <!--                                                                    </fo:block>-->
                                                                <!--                                                                </fo:block>-->
                                                                <!--                                                            </fo:table-cell>-->
                                                            </fo:table-row>
                                                            <fo:table-row border="1pt solid black" font-size="8pt">
                                                                <fo:table-cell column-number="1" text-align="right">
                                                                    <fo:block font-size="8pt" font-family="Verdana">
                                                                        Total:
                                                                    </fo:block>
                                                                </fo:table-cell>
                                                                <fo:table-cell column-number="2" text-align="right">
                                                                    <fo:block font-size="8pt" font-family="Verdana">
                                                                        <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/RentalProtection/Original" />
                                                                    </fo:block>
                                                                </fo:table-cell>
                                                                <!--                                                            <fo:table-cell column-number="3" text-align="right">-->
                                                                <!--                                                                <fo:block font-size="8pt" font-family="Verdana">-->
                                                                <!--                                                                    <fo:block font-size="8pt" font-family="Verdana">-->
                                                                <!--                                                                        <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/RentalProtection/Adjustment" />-->
                                                                <!--                                                                    </fo:block>-->
                                                                <!--                                                                </fo:block>-->
                                                                <!--                                                            </fo:table-cell>-->
                                                                <!--                                                            <fo:table-cell column-number="4" text-align="right">-->
                                                                <!--                                                                <fo:block font-size="8pt" font-family="Verdana">-->
                                                                <!--                                                                    <fo:block font-size="8pt" font-family="Verdana">-->
                                                                <!--                                                                        <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/RentalProtection/Total" />-->
                                                                <!--                                                                    </fo:block>-->
                                                                <!--                                                                </fo:block>-->
                                                                <!--                                                            </fo:table-cell>-->
                                                            </fo:table-row>
                                                            <fo:table-row  border="1pt solid black" font-size="8pt">
                                                                <fo:table-cell column-number="1" text-align="right">
                                                                    <fo:block font-size="8pt" font-family="Verdana">
                                                                        <!--                                                                    PROTECTION FUEL CHARGES-->
                                                                    </fo:block>
                                                                </fo:table-cell>
                                                                <fo:table-cell column-number="2" text-align="right">
                                                                    <fo:block font-size="8pt" font-family="Verdana">
                                                                        <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/ProtectionFuelCharges/Original" />
                                                                    </fo:block>
                                                                </fo:table-cell>
                                                                <!--                                                            <fo:table-cell column-number="3" text-align="right">-->
                                                                <!--                                                                <fo:block font-size="8pt" font-family="Verdana">-->
                                                                <!--                                                                    <fo:block font-size="8pt" font-family="Verdana">-->
                                                                <!--                                                                        <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/ProtectionFuelCharges/Adjustment" />-->
                                                                <!--                                                                    </fo:block>-->
                                                                <!--                                                                </fo:block>-->
                                                                <!--                                                            </fo:table-cell>-->
                                                                <!--                                                            <fo:table-cell column-number="4" text-align="right">-->
                                                                <!--                                                                <fo:block font-size="8pt" font-family="Verdana">-->
                                                                <!--                                                                    <fo:block font-size="8pt" font-family="Verdana">-->
                                                                <!--                                                                        <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/ProtectionFuelCharges/Total" />-->
                                                                <!--                                                                    </fo:block>-->
                                                                <!--                                                                </fo:block>-->
                                                                <!--                                                            </fo:table-cell>-->
                                                            </fo:table-row>
                                                            <fo:table-row border="1pt solid black" font-size="8pt">
                                                                <fo:table-cell column-number="1" text-align="right">
                                                                    <fo:block font-size="8pt" font-family="Verdana">
                                                                        <!--                                                                    DELIVERY PICKUP CHARGES-->
                                                                    </fo:block>
                                                                </fo:table-cell>
                                                                <fo:table-cell column-number="2" text-align="right">
                                                                    <fo:block font-size="8pt" font-family="Verdana">
                                                                        <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/DeliveryPickupCharges/Original" />
                                                                    </fo:block>
                                                                </fo:table-cell>
                                                                <!--                                                            <fo:table-cell column-number="3" text-align="right">-->
                                                                <!--                                                                <fo:block font-size="8pt" font-family="Verdana">-->
                                                                <!--                                                                    <fo:block font-size="8pt" font-family="Verdana">-->
                                                                <!--                                                                        <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/DeliveryPickupCharges/Adjustment" />-->
                                                                <!--                                                                    </fo:block>-->
                                                                <!--                                                                </fo:block>-->
                                                                <!--                                                            </fo:table-cell>-->
                                                                <!--                                                            <fo:table-cell column-number="4" text-align="right">-->
                                                                <!--                                                                <fo:block font-size="8pt" font-family="Verdana">-->
                                                                <!--                                                                    <fo:block font-size="8pt" font-family="Verdana">-->
                                                                <!--                                                                        <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/DeliveryPickupCharges/Total" />-->
                                                                <!--                                                                    </fo:block>-->
                                                                <!--                                                                </fo:block>-->
                                                                <!--                                                            </fo:table-cell>-->
                                                            </fo:table-row>
                                                            <!--                                                        <fo:table-row border="1pt solid black" font-size="8pt">-->
                                                            <!--                                                            <fo:table-cell column-number="1" text-align="right">-->
                                                            <!--                                                                <fo:block font-size="8pt" font-family="Verdana">-->
                                                            <!--                                                                    DELIVERY CHARGES-->
                                                            <!--                                                                </fo:block>-->
                                                            <!--                                                            </fo:table-cell>-->
                                                            <!--                                                            <fo:table-cell column-number="2" text-align="right">-->
                                                            <!--                                                                <fo:block font-size="8pt" font-family="Verdana">-->
                                                            <!--                                                                    <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/DeliveryCharges/Original" />-->
                                                            <!--                                                                </fo:block>-->
                                                            <!--                                                            </fo:table-cell>-->
                                                            <!--                                                            <fo:table-cell column-number="3" text-align="right">-->
                                                            <!--                                                                <fo:block font-size="8pt" font-family="Verdana">-->
                                                            <!--                                                                    <fo:block font-size="8pt" font-family="Verdana">-->
                                                            <!--                                                                        <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/DeliveryCharges/Adjustment" />-->
                                                            <!--                                                                    </fo:block>-->
                                                            <!--                                                                </fo:block>-->
                                                            <!--                                                            </fo:table-cell>-->
                                                            <!--                                                            <fo:table-cell column-number="4" text-align="right">-->
                                                            <!--                                                                <fo:block font-size="8pt" font-family="Verdana">-->
                                                            <!--                                                                    <fo:block font-size="8pt" font-family="Verdana">-->
                                                            <!--                                                                        <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/DeliveryCharges/Total" />-->
                                                            <!--                                                                    </fo:block>-->
                                                            <!--                                                                </fo:block>-->
                                                            <!--                                                            </fo:table-cell>-->
                                                            <!--                                                        </fo:table-row>-->




                                                            <!--                                                        <fo:table-row border="1pt solid black" font-size="8pt">-->
                                                            <!--                                                            <fo:table-cell column-number="1" text-align="right">-->
                                                            <!--                                                                <fo:block font-size="8pt" font-family="Verdana">-->
                                                            <!--                                                        TAXABLE CHARGES-->
                                                            <!--                                                                </fo:block>-->
                                                            <!--                                                            </fo:table-cell>-->
                                                            <!--                                                            <fo:table-cell column-number="2" text-align="right">-->
                                                            <!--                                                                <fo:block font-size="8pt" font-family="Verdana">-->
                                                            <!--                                                                    <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/TaxableCharges/Original" />-->
                                                            <!--                                                                </fo:block>-->
                                                            <!--                                                            </fo:table-cell>-->
                                                            <!--                                                            <fo:table-cell column-number="3" text-align="right">-->
                                                            <!--                                                                <fo:block font-size="8pt" font-family="Verdana">-->
                                                            <!--                                                                    <fo:block font-size="8pt" font-family="Verdana">-->
                                                            <!--                                                                        <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/TaxableCharges/Adjustment" />-->
                                                            <!--                                                                    </fo:block>-->
                                                            <!--                                                                </fo:block>-->
                                                            <!--                                                            </fo:table-cell>-->
                                                            <!--                                                            <fo:table-cell column-number="4" text-align="right">-->
                                                            <!--                                                                <fo:block font-size="8pt" font-family="Verdana">-->
                                                            <!--                                                                    <fo:block font-size="8pt" font-family="Verdana">-->
                                                            <!--                                                                        <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/TaxableCharges/Total" />-->
                                                            <!--                                                                    </fo:block>-->
                                                            <!--                                                                </fo:block>-->
                                                            <!--                                                            </fo:table-cell>-->
                                                            <!--                                                        </fo:table-row>-->
                                                            <!--                                                        <fo:table-row border="1pt solid black" font-size="8pt">-->
                                                            <!--                                                            <fo:table-cell column-number="1" text-align="right">-->
                                                            <!--                                                                <fo:block font-size="8pt" font-family="Verdana">-->
                                                            <!--                                                        TAX-->
                                                            <!--                                                                </fo:block>-->
                                                            <!--                                                            </fo:table-cell>-->
                                                            <!--                                                            <fo:table-cell column-number="2" text-align="right">-->
                                                            <!--                                                                <fo:block font-size="8pt" font-family="Verdana">-->
                                                            <!--                                                                    <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/Tax/Original" />-->
                                                            <!--                                                                </fo:block>-->
                                                            <!--                                                            </fo:table-cell>-->
                                                            <!--                                                            <fo:table-cell column-number="3" text-align="right">-->
                                                            <!--                                                                <fo:block font-size="8pt" font-family="Verdana">-->
                                                            <!--                                                                    <fo:block font-size="8pt" font-family="Verdana">-->
                                                            <!--                                                                        <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/Tax/Adjustment" />-->
                                                            <!--                                                                    </fo:block>-->
                                                            <!--                                                                </fo:block>-->
                                                            <!--                                                            </fo:table-cell>-->
                                                            <!--                                                            <fo:table-cell column-number="4" text-align="right">-->
                                                            <!--                                                                <fo:block font-size="8pt" font-family="Verdana">-->
                                                            <!--                                                                    <fo:block font-size="8pt" font-family="Verdana">-->
                                                            <!--                                                                        <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/Tax/Total" />-->
                                                            <!--                                                                    </fo:block>-->
                                                            <!--                                                                </fo:block>-->
                                                            <!--                                                            </fo:table-cell>-->
                                                            <!--                                                        </fo:table-row>-->
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