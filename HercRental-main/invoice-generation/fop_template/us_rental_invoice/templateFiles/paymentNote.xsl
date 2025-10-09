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
        <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format">
            <fo:table table-layout="fixed" width="100%">
                <fo:table-column column-width="100%" />
                <fo:table-body>
                    <fo:table-row font-size="8pt">
                        <fo:table-cell column-number="1">
                            <fo:table table-layout="fixed" width="100%" margin="1%">
                                <fo:table-column column-width="98%" />
                                <fo:table-body>
                                    <fo:table-row font-size="8pt">
                                        <fo:table-cell column-number="1" border="1pt solid black" text-align="left" margin-left="0px">

                                            <fo:block>
                                                <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/PaymentNotes/Line1" />
                                            </fo:block>

                                            <fo:block>
                                                <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/PaymentNotes/Line2" />
                                            </fo:block>

                                            <fo:block>
                                                <xsl:value-of select="'&#x2028;'" />
                                                <xsl:value-of select="'&#x2028;'" />
                                            </fo:block>

                                            <fo:block font-weight="bold">
                                                <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/PaymentNotes/Line3" />
                                            </fo:block>

                                        </fo:table-cell>
                                    </fo:table-row>
                                </fo:table-body>
                            </fo:table>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
            <fo:block font-size="8pt">
                <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/SurchargeNotes/Line1" />
            </fo:block>
            <fo:block font-size="8pt">
                <xsl:value-of select="Invoice/Detail/Rental_Agreement_Info/SurchargeNotes/Line2" />
            </fo:block>
            <fo:block font-family="serif" font-size="8pt" space-after="12pt" text-align="justify"
                      white-space-treatment="preserve" linefeed-treatment="preserve" white-space-collapse="false">
                <xsl:call-template name="wrap-text">
                    <xsl:with-param name="text" select="Invoice/Detail/Rental_Agreement_Info/docu/description"/>
                    <xsl:with-param name="width" select="40"/>
                </xsl:call-template>
            </fo:block>
        </fo:block>
    </xsl:template>

</xsl:stylesheet>
