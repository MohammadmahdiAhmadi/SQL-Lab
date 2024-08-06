USE carwash;
GO

-- Drop the CalculateOrderPrice function
IF OBJECT_ID('CalculateOrderPrice', 'FN') IS NOT NULL
    DROP FUNCTION CalculateOrderPrice;
GO

-- Drop the GetAverageRatingForService function
IF OBJECT_ID('GetAverageRatingForService', 'FN') IS NOT NULL
    DROP FUNCTION GetAverageRatingForService;
GO

-- Drop the GetTotalSalesByService function
IF OBJECT_ID('GetTotalSalesByService', 'FN') IS NOT NULL
    DROP FUNCTION GetTotalSalesByService;
GO

-- Drop the GetServiceSummary function
IF OBJECT_ID('GetServiceSummary', 'FN') IS NOT NULL
    DROP FUNCTION GetServiceSummary;
GO


--CalculateOrderPrice function
CREATE FUNCTION CalculateOrderPrice (
    @ServicePrice NUMERIC(10, 2),
    @PricingFactor NUMERIC(5, 2)
)
RETURNS NUMERIC(10, 2)
AS
BEGIN
    DECLARE @OrderPrice NUMERIC(10, 2);
    SET @OrderPrice = @ServicePrice * @PricingFactor;
    RETURN @OrderPrice;
END;
GO


--GetAverageRatingForService function
CREATE FUNCTION GetAverageRatingForService (@ServiceID INT)
RETURNS FLOAT
AS
BEGIN
    DECLARE @AverageRating FLOAT;

    SELECT @AverageRating = AVG(Rating)
    FROM Feedbacks
    WHERE ServiceID = @ServiceID;

    RETURN ISNULL(@AverageRating, 0);
END;
GO


--GetTotalSalesByService function
CREATE FUNCTION GetTotalSalesByService
    (@ServiceID INT)
RETURNS NUMERIC(10, 2)
AS
BEGIN
    DECLARE @TotalSales NUMERIC(10, 2);

    SELECT @TotalSales = SUM(OrderPrice)
    FROM Orders
    WHERE ServiceID = @ServiceID;

    RETURN ISNULL(@TotalSales, 0);
END;
GO


--GetServiceSummary function
CREATE FUNCTION GetServiceSummary()
RETURNS TABLE
AS
RETURN (
    SELECT
        S.ServiceID,
        S.ServiceName,
        COUNT(F.ReviewID) AS NumberOfReviews,
		dbo.GetAverageRatingForService(S.ServiceID) AS AverageServiceRating,
        dbo.GetTotalSalesByService(S.ServiceID) AS TotalSales
    FROM
        Services AS S
        LEFT JOIN Feedbacks AS F ON S.ServiceID = F.ServiceID
    GROUP BY
        S.ServiceID, S.ServiceName
);
GO
