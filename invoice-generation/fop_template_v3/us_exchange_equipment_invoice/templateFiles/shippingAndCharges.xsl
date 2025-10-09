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
                                                    <xsl:value-of select="Invoice/Detail/RentalAgreementInfo/Condition" />
                                                </fo:block>
                                            </fo:table-cell>
                                        </fo:table-row>
                                    </fo:table-body>
                                </fo:table>
                                <fo:table table-layout="fixed" width="100%">
                                    <fo:table-column column-width="70%" />
                                    <fo:table-column column-width="30%" />
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
                                                                        <xsl:value-of select="Invoice/Detail/ShipTo/Line1" />
                                                                        <xsl:value-of select="'&#x2028;'" />
                                                                        <xsl:call-template name="blockWithBlank">
                                                                            <xsl:with-param name="field" select="Invoice/Detail/ShipTo/Line2"/>
                                                                        </xsl:call-template>
                                                                        <xsl:value-of select="concat(Invoice/Detail/ShipTo/City,',',Invoice/Detail/ShipTo/State ,' ',Invoice/Detail/ShipTo/ZipCode)" />
                                                                        <xsl:value-of select="'&#x2028;'" />
                                                                        PH: <xsl:value-of select="Invoice/Detail/ShipTo/Phone" />
                                                                        <xsl:value-of select="'&#x2028;'" />
                                                                        <xsl:value-of select="'&#x2028;'" />
                                                                    </fo:block>

                                                                    <!-- REPLACED COMMENTED SECTION WITH RENTAL PERIOD TABLE -->
                                                                    <fo:table table-layout="fixed" width="100%">
                                                                        <fo:table-column column-width="100%" />
                                                                        <fo:table-column column-width="0%" />
                                                                        <fo:table-body>
                                                                            <fo:table-row font-size="8pt">
                                                                                <fo:table-cell column-number="1" text-align="left">
                                                                                    <fo:block font-family="Verdana">
                                                                                       &#160;&#160;&#160;&#160;&#160;&#160; &#160;&#160;&#160;  &#160;&#160;
                                                                                        DATE OUT:&#160; <xsl:value-of select="Invoice/ok/dateout"/> &#160; <xsl:value-of select="Invoice/ok/timeout"/>
                                                                                    </fo:block>
                                                                                    <fo:block font-family="Verdana">
                                                                                        &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;  &#160;&#160;&#160; &#160;&#160;&#160;
                                                                                        DATE IN:&#160; <xsl:value-of select="Invoice/ok/datein"/> &#160; <xsl:value-of select="Invoice/ok/timein"/>
                                                                                    </fo:block>
                                                                                    <fo:block font-family="Verdana">
                                                                                        &#160;&#160;
                                                                                        RENTAL PERIOD: Days <xsl:value-of select="Invoice/ok/days"/> | Weeks <xsl:value-of select="Invoice/ok/weeks"/> | 4Weeks <xsl:value-of select="Invoice/ok/fourweeks"/>
                                                                                    </fo:block>
                                                                                </fo:table-cell>
                                                                                <fo:table-cell column-number="2" text-align="left">
                                                                                    <fo:block>
                                                                                        <!-- This cell can be left empty or used for other information -->
                                                                                    </fo:block>
                                                                                </fo:table-cell>
                                                                            </fo:table-row>
                                                                        </fo:table-body>
                                                                    </fo:table>

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
                                                                        Sales Rep: <xsl:value-of select="Invoice/Detail/RentedFrom/SalesRep" />
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
                                                        <fo:table-column column-width="10%" />
                                                        <fo:table-column column-width="10%" />
                                                        <fo:table-column column-width="40%" border="1pt solid black" border-right="none"/>
                                                        <fo:table-column column-width="40%" border="1pt solid black" border-left="none"/>
                                                        <fo:table-body>
                                                            <fo:table-row font-size="8pt">
                                                                <fo:table-cell column-number="3" text-align="right">
                                                                    <fo:block font-size="8pt" font-family="Verdana">Fuel:</fo:block>
                                                                </fo:table-cell>
                                                                <fo:table-cell column-number="4" text-align="right">
                                                                    <fo:block font-size="8pt" font-family="Verdana">
                                                                        <xsl:value-of select="Invoice/Detail/RentalCharges/Original" />
                                                                    </fo:block>
                                                                </fo:table-cell>
                                                            </fo:table-row>
                                                            <fo:table-row font-size="8pt">
                                                                <fo:table-cell column-number="3" text-align="right">
                                                                    <fo:block font-size="8pt" font-family="Verdana">HST:</fo:block>
                                                                </fo:table-cell>
                                                                <fo:table-cell column-number="4" text-align="right">
                                                                    <fo:block font-size="8pt" font-family="Verdana">
                                                                        <xsl:value-of select="Invoice/Detail/OtherCharges/Original" />
                                                                    </fo:block>
                                                                </fo:table-cell>
                                                            </fo:table-row>
                                                            <fo:table-row font-size="8pt">
                                                                <fo:table-cell column-number="3" text-align="right">
                                                                    <fo:block font-size="8pt" font-family="Verdana">Total:</fo:block>
                                                                </fo:table-cell>
                                                                <fo:table-cell column-number="4" text-align="right">
                                                                    <fo:block font-size="8pt" font-family="Verdana">
                                                                        <xsl:value-of select="Invoice/Detail/RentalProtection/Original" />
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