CREATE PROCEDURE [dbo].[GetPMFMaster]
    @Contract    NVARCHAR(20)    = NULL,
    @Active      NVARCHAR(1)     = NULL,
    @FromDate    SMALLDATETIME   = NULL,
    @ToDate      SMALLDATETIME   = NULL,
    @Top         INT             = NULL
AS
BEGIN
    SET NOCOUNT ON;

    ;WITH Base AS
    (
        SELECT
            *,
            ROW_NUMBER() OVER (ORDER BY [DATE] DESC, [CONTRACT]) AS rn
        FROM
            [dbo].[PMF_MASTER_VIEW]
        WHERE
            (@Contract IS NULL OR [CONTRACT] = @Contract)
            AND (@Active IS NULL OR [ACTIVE] = @Active)
            AND (@FromDate IS NULL OR [DATE] >= @FromDate)
            AND (@ToDate IS NULL OR [DATE] <= @ToDate)
    )
    SELECT
        -- return all view columns; keep ordering stable
        [CONTRACT],
        [REF_CTR],
        [REF_CTR2],
        [DATE],
        [SQ],
        [ACCODE],
        [PT],
        [PACKSIZE],
        [BRAND],
        [QTY],
        [UNIT],
        [DELI_QTY],
        [BAL_QTY],
        [PRICE],
        [TOTAL],
        [CURRENCY],
        [RATE],
        [PERIOD1],
        [PERIOD2],
        [BASIS],
        [BDES],
        [ACTIVE],
        [FCL],
        [CLOSE],
        [CLOSEDATE],
        [CTR_TYPE],
        [BROKER],
        [BCOMM],
        [DEST],
        [MILL],
        [AGENT],
        [SURVEYOR],
        [KPWX],
        [KQTY],
        [KDATE],
        [PARTY_UTZ],
        [ETA],
        [PORT],
        [PAYMENT],
        [REMARKS_OTHERS],
        [COST],
        [ENQUIRY],
        [EDATE],
        [CREDIT_DAY],
        [NEED_SURVEYOR],
        [QTY_PER_CONTAINER],
        [SHELF_LIFE],
        [CTRSERIAL],
        [CNTTYPE],
        [PRODUCT_ENQ],
        [VERIFYUSER],
        [VERIFYTIME],
        [APPUSER],
        [APPTIME],
        [SENTMAILCOUNT],
        [BULKOIL],
        [EMAILSENT],
        [EMAILSENT_DATE],
        [IS_CANCEL],
        [CANCEL_REASON],
        [CONT_TYPE],
        [VERIFYUSER2],
        [VERIFYTIME2],
        [REVISION],
        [REC_STATUS],
        [NEWUSER],
        [NEWTIME],
        [MODIFYUSER],
        [MODIFYTIME],
        [Print Counter],
        [PRIMARY],
        [TEST]
    FROM
        Base
    WHERE
        (@Top IS NULL OR rn <= @Top)
    ORDER BY
        rn;
END;