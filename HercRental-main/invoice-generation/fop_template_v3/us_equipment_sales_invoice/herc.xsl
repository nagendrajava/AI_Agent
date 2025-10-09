<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:include href="fop_template_v3/us_equipment_sales_invoice/templateFiles/address.xsl"/>
    <xsl:include href="fop_template_v3/us_equipment_sales_invoice/templateFiles/addressFirstPage.xsl"/>
    <xsl:include href="fop_template_v3/us_equipment_sales_invoice/templateFiles/headerNotes.xsl"/>
    <xsl:include href="fop_template_v3/us_equipment_sales_invoice/templateFiles/hyphenateSerial.xsl"/>
    <xsl:include href="fop_template_v3/us_equipment_sales_invoice/templateFiles/invoiceDetails.xsl"/>
    <xsl:include href="fop_template_v3/us_equipment_sales_invoice/templateFiles/invoiceDetailsFirstPage.xsl"/>
    <xsl:include href="fop_template_v3/us_equipment_sales_invoice/templateFiles/orderDetails.xsl"/>
    <xsl:include href="fop_template_v3/us_equipment_sales_invoice/templateFiles/orderDetailsHeader.xsl"/>
    <xsl:include href="fop_template_v3/us_equipment_sales_invoice/templateFiles/orderDetailsHeaderFirstPage.xsl"/>
    <xsl:include href="fop_template_v3/us_equipment_sales_invoice/templateFiles/footer.xsl"/>
    <xsl:include href="fop_template_v3/us_equipment_sales_invoice/templateFiles/blockWithBlank.xsl"/>
    <xsl:include href="fop_template_v3/us_equipment_sales_invoice/templateFiles/paymentNote.xsl"/>
    <xsl:include href="fop_template_v3/us_equipment_sales_invoice/templateFiles/paymentHistory.xsl"/>
    <xsl:include href="fop_template_v3/us_equipment_sales_invoice/templateFiles/shippingAndCharges.xsl"/>
    <xsl:include href="fop_template_v3/us_equipment_sales_invoice/templateFiles/newLineForBlank.xsl"/>
    <xsl:param name="imageLocation"/>
    <xsl:param name="barcodeBase64"/>
    <xsl:template match="/">
		<fo:root
			xmlns:fo="http://www.w3.org/1999/XSL/Format"
			xmlns:functx="http://www.functx.com"
			xmlns:fox="http://xmlgraphics.apache.org/fop/extensions">
			<fo:layout-master-set>
				<fo:simple-page-master master-name="contentOtherPages" page-width="210mm" page-height="297mm" margin-top="10mm" margin-bottom="8mm" margin-left="5mm" margin-right="5mm">
					<fo:region-body margin-bottom="25mm" margin-top="92mm" border="1px solid black" />
					<fo:region-before extent="20mm" region-name="other-page-header"/>
					<fo:region-after extent="20mm" region-name="xsl-region-after" />
				</fo:simple-page-master>
				<fo:simple-page-master master-name="contentFirstPage" page-width="210mm" page-height="297mm" margin-top="10mm" margin-bottom="8mm" margin-left="5mm" margin-right="5mm">
					<fo:region-body margin-bottom="25mm" margin-top="96mm" border="1px solid black" />
					<fo:region-before extent="20mm" region-name="first-page-header"/>
					<fo:region-after extent="20mm" region-name="xsl-region-after" />
				</fo:simple-page-master>
				<fo:simple-page-master master-name="contentLastPage" page-width="210mm" page-height="297mm" margin-top="10mm" margin-bottom="8mm" margin-left="5mm" margin-right="5mm">
					<fo:region-body margin-bottom="25mm" margin-top="92mm" border="1px solid black" />
					<fo:region-before extent="20mm" region-name="other-page-header"/>
					<fo:region-after extent="20mm" region-name="last-page-footer" />
				</fo:simple-page-master>
				<fo:simple-page-master master-name="contentSinglePage" page-width="210mm" page-height="297mm" margin-top="10mm" margin-bottom="8mm" margin-left="5mm" margin-right="5mm">
					<fo:region-body margin-bottom="25mm" margin-top="96mm" border="1px solid black" />
					<fo:region-before extent="20mm" region-name="first-page-header"/>
					<fo:region-after extent="20mm" region-name="last-page-footer" />
				</fo:simple-page-master>
				<fo:page-sequence-master master-name="content">
					<fo:repeatable-page-master-alternatives>
						<fo:conditional-page-master-reference master-reference="contentSinglePage" page-position="only" />
						<fo:conditional-page-master-reference master-reference="contentFirstPage" page-position="first" />
						<fo:conditional-page-master-reference master-reference="contentLastPage" page-position="last" />
						<fo:conditional-page-master-reference master-reference="contentOtherPages" page-position="rest" />
					</fo:repeatable-page-master-alternatives>
				</fo:page-sequence-master>
			</fo:layout-master-set>
			<fo:page-sequence master-reference="content">
				<fo:static-content flow-name="first-page-header">
					<fo:block font-size="12pt" space-after.optimum="10pt">
						<xsl:call-template name="orderDetailsHeaderFirstPage" />
					</fo:block>
				</fo:static-content>
				<fo:static-content flow-name="other-page-header">
					<fo:block font-size="12pt" space-after.optimum="10pt">
						<xsl:call-template name="orderDetailsHeader" />
					</fo:block>
				</fo:static-content>
				<fo:static-content flow-name="xsl-region-after">
					<xsl:call-template name="footer">
						<xsl:with-param name="is-last-page" select="false()" />
					</xsl:call-template>
				</fo:static-content>
				<fo:static-content flow-name="last-page-footer">
					<xsl:call-template name="footer">
						<xsl:with-param name="is-last-page" select="true()" />
					</xsl:call-template>
				</fo:static-content>
				<fo:flow flow-name="xsl-region-body">
					<fo:block>
						<xsl:call-template name="orderDetails" />
					</fo:block>
					<fo:block>
						<fo:block break-before="auto" keep-together.within-page="always">
							<xsl:call-template name="paymentNote" />
						</fo:block>
						<fo:block break-before="auto">
							<xsl:call-template name="paymentHistory" />
						</fo:block>
						<fo:footnote>
							<fo:inline/>
							<fo:footnote-body>
								<fo:block keep-together.within-column="always">
									<xsl:call-template name="shippingAndCharges" />
								</fo:block>
							</fo:footnote-body>
						</fo:footnote>
					</fo:block>
					<fo:block id="last-page" />
				</fo:flow>
			</fo:page-sequence>
		</fo:root>
	</xsl:template>

</xsl:stylesheet>
