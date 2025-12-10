<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:template name="paymentHistory">
		<fo:block
			xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<xsl:variable name="hasTransactions" select="count(Invoice/Detail/PaymentsHistory/Transactions/Transaction[
                    string-length(normalize-space(Date)) > 0 or
                    string-length(normalize-space(Type)) > 0 or
                    string-length(normalize-space(Amount)) > 0
                ]) > 0"/>
			<xsl:if test="$hasTransactions">
				<fo:table table-layout="fixed" font-family="Courier New, monospace" width="100%">
					<xsl:variable name="columnCount">
						<xsl:variable name="dateExists" select="count(Invoice/Detail/PaymentsHistory/Transactions/Transaction[string-length(normalize-space(Date)) > 0]) > 0"/>
						<xsl:variable name="typeExists" select="count(Invoice/Detail/PaymentsHistory/Transactions/Transaction[string-length(normalize-space(Type)) > 0]) > 0"/>
						<xsl:variable name="amountExists" select="count(Invoice/Detail/PaymentsHistory/Transactions/Transaction[string-length(normalize-space(Amount)) > 0]) > 0"/>
						<xsl:choose>
							<xsl:when test="$dateExists and $typeExists and $amountExists">3</xsl:when>
							<xsl:when test="$dateExists and $typeExists">2</xsl:when>
							<xsl:when test="$dateExists or $typeExists or $amountExists">1</xsl:when>
						</xsl:choose>
					</xsl:variable>
					<xsl:if test="$columnCount = 3">
						<fo:table-column column-width="33%" />
						<fo:table-column column-width="33%" />
						<fo:table-column column-width="33%" />
					</xsl:if>
					<xsl:if test="$columnCount = 2">
						<fo:table-column column-width="50%" />
						<fo:table-column column-width="50%" />
					</xsl:if>
					<xsl:if test="$columnCount = 1">
						<fo:table-column column-width="100%" />
					</xsl:if>
					<fo:table-header>
						<fo:table-row font-size="8pt">
							<xsl:variable name="dateExists" select="count(Invoice/Detail/PaymentsHistory/Transactions/Transaction[string-length(normalize-space(Date)) > 0]) > 0"/>
							<xsl:variable name="typeExists" select="count(Invoice/Detail/PaymentsHistory/Transactions/Transaction[string-length(normalize-space(Type)) > 0]) > 0"/>
							<xsl:variable name="amountExists" select="count(Invoice/Detail/PaymentsHistory/Transactions/Transaction[string-length(normalize-space(Amount)) > 0]) > 0"/>
							<xsl:if test="$dateExists">
								<fo:table-cell column-number="1" text-align="center">
									<fo:block font-size="8pt" font-weight="bold">
                                        DATE:
                                    </fo:block>
								</fo:table-cell>
							</xsl:if>
							<xsl:if test="$typeExists">
								<fo:table-cell text-align="left">
									<fo:block font-size="8pt" font-weight="bold">
                                        TYPE:
                                    </fo:block>
								</fo:table-cell>
							</xsl:if>
							<xsl:if test="$amountExists">
								<fo:table-cell text-align="left">
									<fo:block font-size="8pt" font-weight="bold">
                                        AMOUNT:
                                    </fo:block>
								</fo:table-cell>
							</xsl:if>
						</fo:table-row>
					</fo:table-header>
					<fo:table-body>
						<xsl:for-each select="Invoice/Detail/PaymentsHistory/Transactions/Transaction[
                            string-length(normalize-space(Date)) > 0 or
                            string-length(normalize-space(Type)) > 0 or
                            string-length(normalize-space(Amount)) > 0
                        ]">
							<fo:table-row font-size="8pt">
								<xsl:if test="string-length(normalize-space(Date)) > 0">
									<fo:table-cell text-align="center">
										<fo:block font-size="8pt">
											<xsl:value-of select="Date" />
										</fo:block>
									</fo:table-cell>
								</xsl:if>
								<xsl:if test="string-length(normalize-space(Type)) > 0">
									<fo:table-cell text-align="left">
										<fo:block font-size="8pt">
											<xsl:value-of select="Type" />
										</fo:block>
									</fo:table-cell>
								</xsl:if>
								<xsl:if test="string-length(normalize-space(Amount)) > 0">
									<fo:table-cell text-align="left">
										<fo:block font-size="8pt">
											<xsl:value-of select="Amount" />
										</fo:block>
									</fo:table-cell>
								</xsl:if>
							</fo:table-row>
						</xsl:for-each>
					</fo:table-body>
				</fo:table>
			</xsl:if>
			<fo:block font-family="Courier New, monospace" font-size="8pt">
				<xsl:if test="string-length(normalize-space(Invoice/Detail/PaymentsHistory/PaymentModes/CardDetails/CardType)) > 0">
					<xsl:value-of select="Invoice/Detail/PaymentsHistory/PaymentModes/CardDetails/CardType" />
					<xsl:text>: </xsl:text>
				</xsl:if>
				<xsl:if test="string-length(normalize-space(Invoice/Detail/PaymentsHistory/PaymentModes/CardDetails/CardNumber)) > 0">
					<xsl:value-of select="Invoice/Detail/PaymentsHistory/PaymentModes/CardDetails/CardNumber" />
					<xsl:text></xsl:text>
				</xsl:if>
				<xsl:if test="string-length(normalize-space(Invoice/Detail/PaymentsHistory/PaymentModes/CardDetails/ExpirationDate)) > 0">
					<xsl:text>EXP: </xsl:text>
					<xsl:value-of select="Invoice/Detail/PaymentsHistory/PaymentModes/CardDetails/ExpirationDate" />
					<xsl:text></xsl:text>
				</xsl:if>
				<xsl:if test="string-length(normalize-space(Invoice/Detail/PaymentsHistory/PaymentModes/Payment/Amount)) > 0">
					<xsl:text>AMT: </xsl:text>
					<xsl:value-of select="Invoice/Detail/PaymentsHistory/PaymentModes/Payment/Amount" />
					<xsl:text></xsl:text>
				</xsl:if>
				<xsl:if test="string-length(normalize-space(Invoice/Detail/PaymentsHistory/PaymentModes/CardDetails/AuthorizationCode)) > 0">
					<xsl:text>AUTH: </xsl:text>
					<xsl:value-of select="Invoice/Detail/PaymentsHistory/PaymentModes/CardDetails/AuthorizationCode" />
				</xsl:if>
			</fo:block>
		</fo:block>
	</xsl:template>
</xsl:stylesheet>