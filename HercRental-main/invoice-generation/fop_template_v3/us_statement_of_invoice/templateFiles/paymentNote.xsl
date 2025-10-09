<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:template name="paymentNote">
        <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format">
            <fo:table table-layout="fixed" width="100%">
                <fo:table-column column-width="100%" />
                <fo:table-body>
                    <fo:table-row font-size="8pt">
                        <fo:table-cell column-number="1">
                            <fo:table table-layout="fixed" width="100%" margin="1%">
                                <fo:table-column column-width="95%" />
                                <fo:table-column column-width="5%" />
                                <fo:table-body>
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
                                                <xsl:value-of select="'&#x2028;'" />
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
        </fo:block>
    </xsl:template>
</xsl:stylesheet>