/****** Object:  DatabaseRole [aspnet_WebEvent_FullAccess]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE ROLE [aspnet_WebEvent_FullAccess]
GO
/****** Object:  DatabaseRole [aspnet_Roles_ReportingAccess]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE ROLE [aspnet_Roles_ReportingAccess]
GO
/****** Object:  DatabaseRole [aspnet_Roles_FullAccess]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE ROLE [aspnet_Roles_FullAccess]
GO
/****** Object:  DatabaseRole [aspnet_Roles_BasicAccess]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE ROLE [aspnet_Roles_BasicAccess]
GO
/****** Object:  DatabaseRole [aspnet_Profile_ReportingAccess]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE ROLE [aspnet_Profile_ReportingAccess]
GO
/****** Object:  DatabaseRole [aspnet_Profile_FullAccess]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE ROLE [aspnet_Profile_FullAccess]
GO
/****** Object:  DatabaseRole [aspnet_Profile_BasicAccess]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE ROLE [aspnet_Profile_BasicAccess]
GO
/****** Object:  DatabaseRole [aspnet_Personalization_ReportingAccess]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE ROLE [aspnet_Personalization_ReportingAccess]
GO
/****** Object:  DatabaseRole [aspnet_Personalization_FullAccess]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE ROLE [aspnet_Personalization_FullAccess]
GO
/****** Object:  DatabaseRole [aspnet_Personalization_BasicAccess]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE ROLE [aspnet_Personalization_BasicAccess]
GO
/****** Object:  DatabaseRole [aspnet_Membership_ReportingAccess]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE ROLE [aspnet_Membership_ReportingAccess]
GO
/****** Object:  DatabaseRole [aspnet_Membership_FullAccess]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE ROLE [aspnet_Membership_FullAccess]
GO
/****** Object:  DatabaseRole [aspnet_Membership_BasicAccess]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE ROLE [aspnet_Membership_BasicAccess]
GO
/****** Object:  Schema [aspnet_Membership_BasicAccess]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE SCHEMA [aspnet_Membership_BasicAccess]
GO
/****** Object:  Schema [aspnet_Membership_FullAccess]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE SCHEMA [aspnet_Membership_FullAccess]
GO
/****** Object:  Schema [aspnet_Membership_ReportingAccess]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE SCHEMA [aspnet_Membership_ReportingAccess]
GO
/****** Object:  Schema [aspnet_Personalization_BasicAccess]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE SCHEMA [aspnet_Personalization_BasicAccess]
GO
/****** Object:  Schema [aspnet_Personalization_FullAccess]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE SCHEMA [aspnet_Personalization_FullAccess]
GO
/****** Object:  Schema [aspnet_Personalization_ReportingAccess]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE SCHEMA [aspnet_Personalization_ReportingAccess]
GO
/****** Object:  Schema [aspnet_Profile_BasicAccess]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE SCHEMA [aspnet_Profile_BasicAccess]
GO
/****** Object:  Schema [aspnet_Profile_FullAccess]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE SCHEMA [aspnet_Profile_FullAccess]
GO
/****** Object:  Schema [aspnet_Profile_ReportingAccess]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE SCHEMA [aspnet_Profile_ReportingAccess]
GO
/****** Object:  Schema [aspnet_Roles_BasicAccess]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE SCHEMA [aspnet_Roles_BasicAccess]
GO
/****** Object:  Schema [aspnet_Roles_FullAccess]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE SCHEMA [aspnet_Roles_FullAccess]
GO
/****** Object:  Schema [aspnet_Roles_ReportingAccess]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE SCHEMA [aspnet_Roles_ReportingAccess]
GO
/****** Object:  Schema [aspnet_WebEvent_FullAccess]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE SCHEMA [aspnet_WebEvent_FullAccess]
GO
/****** Object:  FullTextCatalog [InSiteFTCat]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE FULLTEXT CATALOG [InSiteFTCat]AS DEFAULT

GO
/****** Object:  UserDefinedTableType [dbo].[IdList]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE TYPE [dbo].[IdList] AS TABLE(
	[Id] [nvarchar](50) NOT NULL,
	PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  UserDefinedFunction [dbo].[CalcMatrixResults_Sx]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*-------------------------------------------------------------------------------
Copyright � Insite Software Solutions, Inc. 2013 - All Rights Reserved

Name: CalcMatrixResults_Sx - Calculate entire price table for a specific matrix record
Written By: Tom Frishberg
Dated: 09/03/13

Revision History
----------------
10/02/13, tjf, Trying to handle alternate units of measure properly
--------------------------------------------------------------------------------*/
CREATE FUNCTION [dbo].[CalcMatrixResults_Sx] 
(
@PriceMatrixID		as uniqueidentifier,
@UnitCost			as decimal(18,5),
@ListPrice			as decimal(18,5),
@BasePrice			as decimal(18,5),
@ProductVendorId	as uniqueidentifier,
@CustomerPriceLevel int,
@CustomerDiscountLevel int,
@SalesUM			as nvarchar(50),
@UMConversionFactor as int

)
RETURNS @PriceBreaks TABLE 
(
	Qty			decimal(18,5),
	Price	    decimal(18,5)
)
AS

BEGIN

  DECLARE
    @RecordType         nvarchar(50),
    @CustomerKeyPart    nvarchar(50),
    @ProductKeyPart     nvarchar(50),
    @CalcFlags          nvarchar(50),
	@UnitOfMeasure		nvarchar(50),	
    @BrkQty1            decimal(18,5),
    @BrkQty2            decimal(18,5),
    @BrkQty3            decimal(18,5),
    @BrkQty4            decimal(18,5),
    @BrkQty5            decimal(18,5),
    @BrkQty6            decimal(18,5),
    @BrkQty7            decimal(18,5),
    @BrkQty8            decimal(18,5),
    @BrkQty9            decimal(18,5),
    @BrkQty10           decimal(18,5),
    @BrkQty11           decimal(18,5),
    @PriceBasis1        nvarchar(50),
    @PriceBasis2        nvarchar(50),
    @PriceBasis3        nvarchar(50),
    @PriceBasis4        nvarchar(50),
    @PriceBasis5        nvarchar(50),
    @PriceBasis6        nvarchar(50),
    @PriceBasis7        nvarchar(50),
    @PriceBasis8        nvarchar(50),
    @PriceBasis9        nvarchar(50),
    @PriceBasis10       nvarchar(50),
    @PriceBasis11       nvarchar(50),
    @AdjType1           nvarchar(50),
    @AdjType2           nvarchar(50),
    @AdjType3           nvarchar(50),
    @AdjType4           nvarchar(50),
    @AdjType5           nvarchar(50),
    @AdjType6           nvarchar(50),
    @AdjType7           nvarchar(50),
    @AdjType8           nvarchar(50),
    @AdjType9           nvarchar(50),
    @AdjType10          nvarchar(50),
    @AdjType11          nvarchar(50),
    @Amount1            decimal(18,5),
    @Amount2            decimal(18,5),
    @Amount3            decimal(18,5),
    @Amount4            decimal(18,5),
    @Amount5            decimal(18,5),
    @Amount6            decimal(18,5),
    @Amount7            decimal(18,5),
    @Amount8            decimal(18,5),
    @Amount9            decimal(18,5),
    @Amount10           decimal(18,5),
    @Amount11           decimal(18,5),
    @AltAmount1         decimal(18,5),    
    @AltAmount2         decimal(18,5),    
    @AltAmount3         decimal(18,5),    
    @AltAmount4         decimal(18,5),    
    @AltAmount5         decimal(18,5),    
    @AltAmount6         decimal(18,5),    
    @AltAmount7         decimal(18,5),    
    @AltAmount8         decimal(18,5),    
    @AltAmount9         decimal(18,5),    
    @AltAmount10        decimal(18,5),    
    @AltAmount11        decimal(18,5),
	@CalculationFlags   varchar(50)

DECLARE
	@Pround				nvarchar(10) = 'n',
	@Ptarget			int = 5,
	@Loop				int,
    @Multiplier			decimal(18,5),
	@FallbackMultiplier decimal(18,5),
    @tmpAmount			decimal(18,5),
	@Discount			decimal(18,5),
	@tmpBasisValue		decimal(18,5),
	@CurPriceBasis		nvarchar(10),
	@PricingQtyFactor   int
	

    SELECT 
      @RecordType = RecordType,
	  @UnitOfMeasure = UnitOfMeasure,
      @BrkQty1 = BreakQty01,
      @BrkQty2 = BreakQty02,
      @BrkQty3 = BreakQty03,
      @BrkQty4 = BreakQty04,
      @BrkQty5 = BreakQty05,
      @BrkQty6 = BreakQty06,
      @BrkQty7 = BreakQty07,
      @BrkQty8 = BreakQty08,
      @BrkQty9 = BreakQty09,
      @BrkQty10 = BreakQty10,
      @BrkQty11 = BreakQty11,
      @PriceBasis1 = PriceBasis01,
      @PriceBasis2 = PriceBasis02,
      @PriceBasis3 = PriceBasis03,
      @PriceBasis4 = PriceBasis04,
      @PriceBasis5 = PriceBasis05,
      @PriceBasis6 = PriceBasis06,
      @PriceBasis7 = PriceBasis07,
      @PriceBasis8 = PriceBasis08,
      @PriceBasis9 = PriceBasis09,
      @PriceBasis10 = PriceBasis10,
      @PriceBasis11 = PriceBasis11,
      @AdjType1 = AdjustmentType01,
      @AdjType2 = AdjustmentType02,
      @AdjType3 = AdjustmentType03,
      @AdjType4 = AdjustmentType04,
      @AdjType5 = AdjustmentType05,
      @AdjType6 = AdjustmentType06,
      @AdjType7 = AdjustmentType07,
      @AdjType8 = AdjustmentType08,
      @AdjType9 = AdjustmentType09,
      @AdjType10 = AdjustmentType10,
      @AdjType11 = AdjustmentType11,
      @Amount1 = Amount01,
      @Amount2 = Amount02,
      @Amount3 = Amount03,
      @Amount4 = Amount04,
      @Amount5 = Amount05,
      @Amount6 = Amount06,
      @Amount7 = Amount07,
      @Amount8 = Amount08,
      @Amount9 = Amount09,
      @Amount10 = Amount10,
      @Amount11 = Amount11,
      @AltAmount1 = AltAmount01,
      @AltAmount2 = AltAmount02,
      @AltAmount3 = AltAmount03,
      @AltAmount4 = AltAmount04,
      @AltAmount5 = AltAmount05,
      @AltAmount6 = AltAmount06,
      @AltAmount7 = AltAmount07,
      @AltAmount8 = AltAmount08,
      @AltAmount9 = AltAmount09,
      @AltAmount10 = AltAmount10,
      @AltAmount11 = AltAmount11 ,
	  @CalculationFlags = isnull(CalculationFlags,'')
    FROM PriceMatrix (NOLOCK)
    WHERE PriceMatrixId = @PriceMatrixId 

	IF @BrkQty1 = 0 
	  SET @BrkQty1 = 1 -- set to a minimum

	SET @PricingQtyFactor = 1
	IF @UnitOfMeasure <> @SalesUM 
		SET @PricingQtyFactor = @UMConversionFactor

		
	if ltrim(rtrim(@CalculationFlags)) <> ''
	begin
		declare @pos int
		set @pos = patindex('%|%',@CalculationFlags)
		if @pos > 0
		begin
			set @pround = substring(@CalculationFlags,1,@pos-1)
			set @ptarget = cast(rtrim(substring(@CalculationFlags,@pos+1,50)) as int)
		end
	end
   
    /* Set customer level value at level or below until a value is hit */
    SET @Loop = 1
    SET @Multiplier = 0
    SET @FallbackMultiplier = 0
    SET @tmpAmount = 0
    
 WHILE @Loop <= @CustomerPriceLevel
    BEGIN
      IF @Loop = 1 SET @Multiplier = @Amount1
      IF @Loop = 2 SET @Multiplier = @Amount2
      IF @Loop = 3 SET @Multiplier = @Amount3
      IF @Loop = 4 SET @Multiplier = @Amount4
      IF @Loop = 5 SET @Multiplier = @Amount5
      IF @Loop = 6 SET @Multiplier = @Amount6
      IF @Loop = 7 SET @Multiplier = @Amount7
      IF @Loop = 8 SET @Multiplier = @Amount8
      IF @Loop = 9 SET @Multiplier = @Amount9
      IF @Loop = 10 SET @Multiplier = @Amount10
      IF @Loop = 11 SET @Multiplier = @Amount11
      IF @Multiplier <> 0 SET @FallbackMultiplier = @Multiplier
      SET @Loop = @Loop + 1
    END



    /* Set customer discount level at specific value */
    SELECT @Discount = 
    CASE @CustomerDiscountLevel
      WHEN 0 THEN 0
      WHEN 1 THEN @AltAmount1
      WHEN 2 THEN @AltAmount2
      WHEN 3 THEN @AltAmount3
      WHEN 4 THEN @AltAmount4
      WHEN 5 THEN @AltAmount5
      WHEN 6 THEN @AltAmount6
      WHEN 7 THEN @AltAmount7
      WHEN 8 THEN @AltAmount8
      WHEN 9 THEN @AltAmount9
      ELSE 0
    END

    IF @Discount > 100 SET @Discount = 100
    SELECT @Discount = 1 - (@Discount / 100) -- transform into a multiplier


    /* Set price basis level  - assuming all the same across the record */
    SET @tmpBasisValue = 0
	SET @CurPriceBasis = @PriceBasis1
    IF RIGHT(@CurPriceBasis,1) = 'C' SET @tmpBasisValue = @UnitCost
    IF RIGHT(@CurPriceBasis,1) = 'M' SET @tmpBasisValue = @UnitCost -- margin
    IF RIGHT(@CurPriceBasis,1) = 'L' SET @tmpBasisValue = @ListPrice
    IF RIGHT(@CurPriceBasis,1) = 'B' SET @tmpBasisValue = @BasePrice


	
	-- Capture Price Breaks
	DELETE FROM @PriceBreaks
	IF @BrkQty1 > 0 AND (@Amount1 > 0 OR @AltAmount1 > 0) 
		INSERT INTO @PriceBreaks (Qty, Price)
		VALUES((IIF(@BrkQty1 / @PricingQtyFactor < 1,1,@BrkQty1 / @PricingQtyFactor)),
			  dbo.CalcSinglePrice_SX (@CurPriceBasis,@BasePrice,@Amount1,@AltAmount1,@AdjType1,@tmpBasisValue,@UnitCost,@ProductVendorId,
			    @FallbackMultiplier,@Multiplier,@Discount,@Pround,@PTarget,IIF (@BrkQty1 / @PricingQtyFactor <= 1,1,0)))

	IF @BrkQty2 > 0 AND (@Amount2 > 0 OR @AltAmount2 > 0) INSERT INTO @PriceBreaks (Qty, Price)
		VALUES(@BrkQty2 / @PricingQtyFactor,
				dbo.CalcSinglePrice_SX (@CurPriceBasis,@BasePrice,@Amount2,@AltAmount2,@AdjType2,@tmpBasisValue,@UnitCost,@ProductVendorId,
				@FallbackMultiplier,@Multiplier,@Discount,@Pround,@PTarget,0))
	IF @BrkQty3 > 0 AND (@Amount3 > 0 OR @AltAmount3 > 0) INSERT INTO @PriceBreaks (Qty, Price)
		VALUES(@BrkQty3 / @PricingQtyFactor,
				dbo.CalcSinglePrice_SX (@CurPriceBasis,@BasePrice,@Amount3,@AltAmount3,@AdjType3,@tmpBasisValue,@UnitCost,@ProductVendorId,
				@FallbackMultiplier,@Multiplier,@Discount,@Pround,@PTarget,0))
	IF @BrkQty4 > 0 AND (@Amount4 > 0 OR @AltAmount4 > 0) INSERT INTO @PriceBreaks (Qty, Price)
		VALUES(@BrkQty4 / @PricingQtyFactor,
				dbo.CalcSinglePrice_SX (@CurPriceBasis,@BasePrice,@Amount4,@AltAmount4,@AdjType4,@tmpBasisValue,@UnitCost,@ProductVendorId,
				@FallbackMultiplier,@Multiplier,@Discount,@Pround,@PTarget,0))
	IF @BrkQty5 > 0 AND (@Amount5 > 0 OR @AltAmount5 > 0) INSERT INTO @PriceBreaks (Qty, Price)
		VALUES(@BrkQty5 / @PricingQtyFactor,
				dbo.CalcSinglePrice_SX (@CurPriceBasis,@BasePrice,@Amount5,@AltAmount5,@AdjType5,@tmpBasisValue,@UnitCost,@ProductVendorId,
				@FallbackMultiplier,@Multiplier,@Discount,@Pround,@PTarget,0))
	IF @BrkQty6 > 0 AND (@Amount6 > 0 OR @AltAmount6 > 0) INSERT INTO @PriceBreaks (Qty, Price)
		VALUES(@BrkQty6 / @PricingQtyFactor,
				dbo.CalcSinglePrice_SX (@CurPriceBasis,@BasePrice,@Amount6,@AltAmount6,@AdjType6,@tmpBasisValue,@UnitCost,@ProductVendorId,
				@FallbackMultiplier,@Multiplier,@Discount,@Pround,@PTarget,0))
	IF @BrkQty7 > 0 AND (@Amount7 > 0 OR @AltAmount7 > 0) INSERT INTO @PriceBreaks (Qty, Price)
		VALUES(@BrkQty7 / @PricingQtyFactor,
				dbo.CalcSinglePrice_SX (@CurPriceBasis,@BasePrice,@Amount7,@AltAmount7,@AdjType7,@tmpBasisValue,@UnitCost,@ProductVendorId,
				@FallbackMultiplier,@Multiplier,@Discount,@Pround,@PTarget,0))
	IF @BrkQty8 > 0 AND (@Amount8 > 0 OR @AltAmount8 > 0) INSERT INTO @PriceBreaks (Qty, Price)
		VALUES(@BrkQty8 / @PricingQtyFactor,
				dbo.CalcSinglePrice_SX (@CurPriceBasis,@BasePrice,@Amount8,@AltAmount8,@AdjType3,@tmpBasisValue,@UnitCost,@ProductVendorId,
				@FallbackMultiplier,@Multiplier,@Discount,@Pround,@PTarget,0))
	IF @BrkQty9 > 0 AND (@Amount9 > 0 OR @AltAmount9 > 0) INSERT INTO @PriceBreaks (Qty, Price)
		VALUES(@BrkQty9 / @PricingQtyFactor,
				dbo.CalcSinglePrice_SX (@CurPriceBasis,@BasePrice,@Amount9,@AltAmount9,@AdjType9,@tmpBasisValue,@UnitCost,@ProductVendorId,
				@FallbackMultiplier,@Multiplier,@Discount,@Pround,@PTarget,0))
	IF @BrkQty10 > 0 AND (@Amount10 > 0 OR @AltAmount10 > 0) INSERT INTO @PriceBreaks (Qty, Price)
	   VALUES(@BrkQty10 / @PricingQtyFactor,
			  dbo.CalcSinglePrice_SX (@CurPriceBasis,@BasePrice,@Amount10,@AltAmount10,@AdjType10,@tmpBasisValue,@UnitCost,@ProductVendorId,
			    @FallbackMultiplier,@Multiplier,@Discount,@Pround,@PTarget,0))

    -- Check for a '1' entry
	IF NOT EXISTS (SELECT * FROM @PriceBreaks WHERE Qty = 1) 
		INSERT INTO @PriceBreaks VALUES(1,@ListPrice)


  RETURN 
END


GO
/****** Object:  UserDefinedFunction [dbo].[CalcSinglePrice_Sx]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*-------------------------------------------------------------------------------
Copyright � Insite Software Solutions, Inc. 2013 - All Rights Reserved

Name: CalcSinglePrice_Sx - Calculate price for specific matrix entry
Written By: Tom Frishberg
Dated: 09/03/13

Revision History
----------------
09/03/13, tjf, Note - took out logic for 'vendor sale markup' - not an SX construct
10/04/13, tjf, Only round if passed parameter calls for it
--------------------------------------------------------------------------------*/

CREATE FUNCTION [dbo].[CalcSinglePrice_Sx] 
(
@PriceBasis			nvarchar(20),
@BasePrice			decimal(20,9),
@Amount				decimal(20,9),
@AltAmount			decimal(20,9),
@AdjType			nvarchar(20),
@BasisValue			decimal(18,5),
@UnitCost			decimal(18,5),
@ProductVendorId	uniqueidentifier,
@FallbackMultiplier	decimal(20,9),
@Multiplier			decimal(20,9),
@Discount			decimal(20,9),
@Pround			    nvarchar(10),
@Ptarget			int,
@PerformRounding    tinyint
)
RETURNS decimal(20,9)
AS

BEGIN
	DECLARE
		@tmpAdjustValue		decimal(20,9),
		@OkToRound			tinyint = 1,
		@RoundToNearest		decimal(18,6),
        @Offset				decimal (18,6),
		@Price				decimal(20,9)

			
    /* Vendor Markup */
    IF @PriceBasis = 'VMU' AND @ProductVendorId IS NOT NULL
    BEGIN
      SET @tmpAdjustValue = 0  -- if the customer needs a default markup, set here
      SELECT  @tmpAdjustValue = RegularMarkup            
      FROM Vendor (NOLOCK)
      WHERE VendorId = @ProductVendorId    
	  IF IsNull(@tmpAdjustValue,0) > 0 and @UnitCost > 0
	  BEGIN
		SET @Price = @UnitCost * (1 + (@tmpAdjustValue / 100))
	  END
	END	


    /* Calculate actual price based on current break */
    /* Group 1 - No Qty Break types */
    IF @PriceBasis IN ('CLB','CLL','CLC','CLM','CLO')
    BEGIN
      IF @PriceBasis = 'CLO'
	  begin
        SET @Price = @FallbackMultiplier * @Discount -- override price 
		if @Discount = 1
		begin
			set @OkToRound = 0
		end		         
	  end	
      ELSE
        IF @AdjType = 'P'
        BEGIN
		  IF @PriceBasis = 'CLM'
            SET @Price = (@BasisValue / (1 - (@FallbackMultiplier / 100))) * @Discount

		  IF @FallbackMultiplier = 0 SET @FallbackMultiplier = 100          
          SET @Price = @BasisValue * (@FallbackMultiplier / 100) * @Discount -- Basis * Customer level multiplier less disct1
		END
    END -- no qty breaks

    /* Group 2 - Qty Break on Price */
    IF @PriceBasis IN ('B','L','C','M','O')
    BEGIN
      IF @Amount = 0
        SET @Price = @BasePrice * @Discount -- technically this is not correct but we don't have the data
      ELSE BEGIN
        IF @PriceBasis = 'O'
		begin
          SET @Price = @Amount * @Discount
		  if @Discount = 1        
		  begin	
		    set @OkToRound = 0
          end
		end

        IF @PriceBasis IN ('L','B','C')
          SET @Price = @BasisValue * (@Amount / 100) *  @Discount -- multiplier by qty brk - disct1
        IF @PriceBasis = 'M'   
          SET @Price = (@UnitCost / (1 - @Amount / 100)) * @Discount
      END
    END

	
    /* Group 3 - Qty Break on Disct */
    IF @PriceBasis IN ('CLDB','CLDL','CLDC','CLDM','CLD')
    BEGIN
      IF @PriceBasis IN ('CLDB','CLDL','CLDC')
	  BEGIN
		IF @FallBackMultiplier = 0
			SET @FallbackMultiplier = 100		
        SET @Price = (@BasisValue * @FallbackMultiplier / 100) * (1 - @AltAmount / 100)
	  END
      IF @PriceBasis = 'CLDM'
        SET @Price = @UnitCost / (1 - (@FallbackMultiplier / 100) * (1 - @AltAmount / 100))
      IF @PriceBasis = 'CLD'
	  BEGIN
	    IF @FallbackMultiplier = 0 SET @FallbackMultiplier = 1
        SET @Price = @FallbackMultiplier * (1 - (@AltAmount / 100))
      END
	END

	-- Round the price next
	IF @Price > 0 and @OkToRound = 1 and @PerformRounding = 1
	begin
		Declare @tmpPrice Decimal (18,6)
		Declare @DecimalPlace real
		
		set @tmpPrice = @Price
		set @DecimalPlace = (@ptarget -3)

		-- Round up
		if lower(rtrim(@Pround)) = 'u'
		begin		
			set @roundToNearest = round(@tmpPrice,@DecimalPlace)
			set @offset = @tmpPrice - @RoundToNearest

			if @tmpPrice = @roundToNearest
			begin
				-- no rounding occured	
				set @Price = @tmpPrice
			end
			else if @Offset > 0	-- test number was larger - round up
			begin
				-- add the offest to the rounded down number
				set @Price = @roundToNearest + power(10.000000,-@DecimalPlace)
			end
			else
				-- naturally rounded up
				set @Price = @roundToNearest		
		end
		else if lower(rtrim(@Pround)) = 'd'
		begin
			set @Price = round(@tmpPrice,@DecimalPlace,1)
		end 
		else if lower(rtrim(@Pround)) = 'n'
		begin
			set @Price = round(@tmpPrice,@DecimalPlace)
		end
		
	end 
    
	return @Price
END
  

GO
/****** Object:  UserDefinedFunction [dbo].[GetListPrice_Epicor]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetListPrice_Epicor]
(
	@ProductId uniqueidentifier,
	@CurrencyCode nvarchar(50),
	@Warehouse	nvarchar(50),
	@UnitOfMeasure nvarchar(50),
	@PricingDate datetime
)

RETURNS Decimal(18,5)
AS
BEGIN
	declare @ListPrice decimal(18,5)

	SELECT @ListPrice = Amount01
	FROM PriceMatrix (NOLOCK)
	WHERE
		RecordType = 'Product' AND
		CurrencyCode = @CurrencyCode AND
		Warehouse = @Warehouse AND
		UnitOfMeasure = @UnitOfMeasure AND
		CustomerKeyPart = '' AND
		ProductKeyPart = @ProductId AND
		dateadd(dd,0,datediff(dd,0,Active)) <= @PricingDate and 
		(Deactivate IS NULL OR Deactivate > @PricingDate)

	-- Return the result of the function
	RETURN @ListPrice

END

GO
/****** Object:  UserDefinedFunction [dbo].[GetListPrice_Syteline]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetListPrice_Syteline]
(
	@ProductId uniqueidentifier,
	@CurrencyCode nvarchar(50),
	@Warehouse	nvarchar(50),
	@UnitOfMeasure nvarchar(50),
	@PricingDate datetime
)
RETURNS @ReturnTable table 
(	
	ListPrice	decimal(18,5),
	PriceCode	nvarchar(50),
	PriceLevel1 decimal(18,5),
	PriceLevel2 decimal(18,5),
	PriceLevel3 decimal(18,5),
	PriceLevel4 decimal(18,5),
	PriceLevel5 decimal(18,5),
	PriceLevel6 decimal(18,5)
)
AS
BEGIN
	declare @ListPrice decimal(18,5),
		@PriceCode nvarchar(50),
		@PriceLevel1 decimal(18,5),
		@PriceLevel2 decimal(18,5),
		@PriceLevel3 decimal(18,5),
		@PriceLevel4 decimal(18,5),
		@PriceLevel5 decimal(18,5),
		@PriceLevel6 decimal(18,5)
	
	set @ListPrice = 0
	set @PriceLevel1 = 0
	set	@PriceLevel2 = 0
	set	@PriceLevel3 = 0
	set	@PriceLevel4 = 0
	set	@PriceLevel5 = 0
	set	@PriceLevel6 = 0
	
	set @PriceCode = ''
	
	SELECT @ListPrice = AltAmount01,
		@PriceCode = CalculationFlags,
		@PriceLevel1 = AltAmount01,
		@PriceLevel2 = AltAmount02,
		@PriceLevel3 = AltAmount03,
		@PriceLevel4 = AltAmount04,
		@PriceLevel5 = AltAmount05,
		@PriceLevel6 = AltAmount06

	FROM PriceMatrix (NOLOCK)
	WHERE
		RecordType = 'Product' AND
		CurrencyCode = @CurrencyCode AND
		Warehouse = @Warehouse AND
		UnitOfMeasure = @UnitOfMeasure AND
		CustomerKeyPart = '' AND
		ProductKeyPart = @ProductId AND
		Active <= @PricingDate AND
		(Deactivate IS NULL OR Deactivate > @PricingDate)

	if @ListPrice = 0
	begin	
		SELECT @ListPrice = BasicListPrice
			FROM Product (NOLOCK)
		WHERE Productid = @ProductId
	end
	
	insert into @ReturnTable
	(
		ListPrice,
		PriceCode,
		PriceLevel1,
		PriceLevel2,
		PriceLevel3,
		PriceLevel4,
		PriceLevel5,
		PriceLevel6
	)
	values 
	(
		@ListPrice,
		@PriceCode,
		@PriceLevel1,
		@PriceLevel2,
		@PriceLevel3,
		@PriceLevel4,
		@PriceLevel5,
		@PriceLevel6
	)

	-- Return the result of the function
	RETURN

END

GO
/****** Object:  UserDefinedFunction [dbo].[GetPriceMatrixId_Epicor]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Bill Behning
-- Create date: 12-2-2010
-- Description:	Returns the proper price matrix record 
-- =============================================
CREATE FUNCTION [dbo].[GetPriceMatrixId_Epicor]
(
	@CustomerId uniqueidentifier,
	@ProductId uniqueidentifier,
	@CurrencyCode nvarchar(50),
	@Warehouse	nvarchar(50),
	@UnitOfMeasure nvarchar(50),
	@PricingDate datetime
)

RETURNS uniqueidentifier
AS
BEGIN
	-- Declare the return variable here
	Declare @PriceMatrixId uniqueidentifier,
		@ParentCustomerId   uniqueidentifier,
		@ProductPriceCode   nvarchar(50),
		@CustomerPriceCode  nvarchar(50)
	
	-- Get Product Info
	SELECT @ProductPriceCode = PriceCode
		FROM Product (NOLOCK)
		WHERE ProductId = @ProductId

	IF @CustomerId is not null
	BEGIN
		SELECT
			@CustomerPriceCode = customertype,
			@ParentCustomerId = ParentId
		FROM Customer (NOLOCK)
		WHERE CustomerId = @CustomerId
	END

	/* Customer/Product */
	IF @PriceMatrixId IS NULL AND @CustomerId is not null
	BEGIN
		SELECT @PriceMatrixID = PriceMatrixID
		FROM PriceMatrix (NOLOCK) 
		WHERE
			RecordType = 'Customer/Product' AND
			CurrencyCode = @CurrencyCode AND
			Warehouse = @Warehouse AND
			UnitOfMeasure = @UnitOfMeasure AND
			CustomerKeyPart = @CustomerId AND
			ProductKeyPart = @ProductId AND
			Active <= @PricingDate AND
			(Deactivate IS NULL OR Deactivate >= @PricingDate)
	END

	/* Customer/Product Price Code */
	IF @PriceMatrixId IS NULL AND @CustomerId  is not null
	BEGIN
		SELECT @PriceMatrixID = PriceMatrixID
		FROM PriceMatrix (NOLOCK) 
		WHERE
			RecordType = 'Customer/Product Price Code' AND
			CurrencyCode = @CurrencyCode AND
			Warehouse = @Warehouse AND
			CustomerKeyPart = @CustomerId AND
			ProductKeyPart =  @ProductPriceCode AND
			Active <= @PricingDate AND
			(Deactivate IS NULL OR Deactivate >= @PricingDate)

			-- UnitOfMeasure = @UnitOfMeasure AND
	END

	/* Parent Customer/Product */
	IF @PriceMatrixId IS NULL AND @ParentCustomerId  is not null
	BEGIN
		SELECT @PriceMatrixID = PriceMatrixID
		FROM PriceMatrix (NOLOCK) 
		WHERE
			RecordType = 'Customer/Product' AND
			CurrencyCode = @CurrencyCode AND
			Warehouse = @Warehouse AND
			UnitOfMeasure = @UnitOfMeasure AND
			CustomerKeyPart = @ParentCustomerId AND
			ProductKeyPart = @ProductId AND
			Active <= @PricingDate AND
			(Deactivate IS NULL OR Deactivate >= @PricingDate)
	END

	/* Parent Customer/Product Price Code */
	IF @PriceMatrixId IS NULL AND @ParentCustomerId is not null
	BEGIN
		SELECT @PriceMatrixID = PriceMatrixID
		FROM PriceMatrix (NOLOCK) 
		WHERE
			RecordType = 'Customer/Product Price Code' AND
			CurrencyCode = @CurrencyCode AND
			Warehouse = @Warehouse AND
			CustomerKeyPart = @ParentCustomerId AND
			ProductKeyPart =  @ProductPriceCode AND
			Active <= @PricingDate AND
			(Deactivate IS NULL OR Deactivate >= @PricingDate)

			--UnitOfMeasure = @UnitOfMeasure AND
	END

	/* Customer Price Code/Product - don't see this type in SL but no harm in looking for it */
	IF @PriceMatrixId IS NULL AND @CustomerId  is not null AND @CustomerPriceCode <> ''
	BEGIN
		SELECT @PriceMatrixID = PriceMatrixID
		FROM PriceMatrix (NOLOCK) 
		WHERE
			RecordType = 'Customer Price Code/Product' AND
			CurrencyCode = @CurrencyCode AND
			Warehouse = @Warehouse AND
			UnitOfMeasure = @UnitOfMeasure AND
			CustomerKeyPart = @CustomerPriceCode AND
			ProductKeyPart = @ProductId AND
			Active <= @PricingDate AND
			(Deactivate IS NULL OR Deactivate >= @PricingDate)
	END        

	/* Customer Price Code/Product Price Code */
	IF @PriceMatrixId IS NULL AND @CustomerId  is not null 
			AND @CustomerPriceCode <> ''
			AND @ProductPriceCode <> ''
	BEGIN
		SELECT @PriceMatrixID = PriceMatrixID
		FROM PriceMatrix (NOLOCK) 
		WHERE
			RecordType = 'Customer Price Code/Product Price Code' AND
			CurrencyCode = @CurrencyCode AND
			Warehouse = @Warehouse AND
			CustomerKeyPart = @CustomerPriceCode AND
			ProductKeyPart = @ProductPriceCode AND
			Active <= @PricingDate AND
			(Deactivate IS NULL OR Deactivate >= @PricingDate)

			-- UnitOfMeasure = @UnitOfMeasure AND
	END       

	/* Product Base Record - grabbing this record if nothing else grabbed */
	IF @PriceMatrixId IS NULL
	BEGIN
		SELECT @PriceMatrixID = PriceMatrixID
		FROM PriceMatrix (NOLOCK) 
		WHERE
			RecordType = 'Product' AND
			CurrencyCode = @CurrencyCode AND
			Warehouse = @Warehouse AND
			UnitOfMeasure = @UnitOfMeasure AND
			CustomerKeyPart IS NULL AND
			ProductKeyPart = @ProductId AND
			Active <= @PricingDate AND
			(Deactivate IS NULL OR Deactivate >= @PricingDate)
	END    

	RETURN @PriceMatrixId

END

GO
/****** Object:  UserDefinedFunction [dbo].[GetPriceMatrixId_Syteline]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Bill Behning
-- Create date: 12-2-2010
-- Description:	Returns the proper price matrix record 
-- =============================================
CREATE FUNCTION [dbo].[GetPriceMatrixId_Syteline]
(
	@CustomerId uniqueidentifier,
	@ProductId uniqueidentifier,
	@CurrencyCode nvarchar(50),
	@Warehouse	nvarchar(50),
	@UnitOfMeasure nvarchar(50),
	@PricingDate datetime,
	@ProductPriceCode  nvarchar(50)
)

RETURNS uniqueidentifier
AS
BEGIN
	-- Declare the return variable here
	Declare @PriceMatrixId uniqueidentifier,
		@ParentCustomerId   uniqueidentifier,
		@CustomerPriceCode  nvarchar(50)
	
	IF @CustomerId is not null
	BEGIN
		SELECT
			@CustomerPriceCode = pricecode,
			@ParentCustomerId = ParentId
		FROM Customer (NOLOCK)
		WHERE CustomerId = @CustomerId
	END

	/* Customer/Product */
	IF @PriceMatrixId IS NULL AND @CustomerId is not null
	BEGIN
		SELECT @PriceMatrixID = PriceMatrixID
		FROM PriceMatrix (NOLOCK) 
		WHERE
			RecordType = 'Customer/Product' AND
			CurrencyCode = @CurrencyCode AND
			Warehouse = @Warehouse AND
			UnitOfMeasure = @UnitOfMeasure AND
			CustomerKeyPart = @CustomerId AND
			ProductKeyPart = @ProductId AND
			Active <= @PricingDate AND
			(Deactivate IS NULL OR Deactivate >= @PricingDate)
	END

	/* Customer Price Code/Product Price Code */
	IF @PriceMatrixId IS NULL AND @CustomerId  is not null 
			AND @CustomerPriceCode <> ''
			AND @ProductPriceCode <> ''
	BEGIN
		SELECT @PriceMatrixID = PriceMatrixID
		FROM PriceMatrix (NOLOCK) 
		WHERE
			RecordType = 'Customer Price Code/Product Price Code' AND
			CurrencyCode = @CurrencyCode AND
			Warehouse = @Warehouse AND
			CustomerKeyPart = @CustomerPriceCode AND
			ProductKeyPart = @ProductPriceCode AND
			Active <= @PricingDate AND
			(Deactivate IS NULL OR Deactivate >= @PricingDate)

			-- UnitOfMeasure = @UnitOfMeasure AND
	END       

	/* Product Base Record - grabbing this record if nothing else grabbed */
	IF @PriceMatrixId IS NULL
	BEGIN
		SELECT @PriceMatrixID = PriceMatrixID
		FROM PriceMatrix (NOLOCK) 
		WHERE
			RecordType = 'Product' AND
			CurrencyCode = @CurrencyCode AND
			Warehouse = @Warehouse AND
			UnitOfMeasure = @UnitOfMeasure AND
			CustomerKeyPart IS NULL AND
			ProductKeyPart = @ProductId AND
			Active <= @PricingDate AND
			(Deactivate IS NULL OR Deactivate >= @PricingDate)
	END    

	RETURN @PriceMatrixId

END

GO
/****** Object:  UserDefinedFunction [dbo].[GetPricingBaisis_Epicor]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Bill Behning
-- Create date: 2010-12-01
-- Description:	Function to return price basis info
-- =============================================
CREATE FUNCTION [dbo].[GetPricingBaisis_Epicor] 
(
		@PriceMatrixId     uniqueidentifier,
		@QtyOrdered	int
)

RETURNS @ReturnTable table 
(	
	recordtype			nvarchar(50),
	CurAmount			decimal(18,5),
    CurBrkQty			int,
    CurPriceBasis		nvarchar(50),
    CurAdjType			nvarchar(50),
	CurBasisValue		decimal(18,5)
)
AS
BEGIN
	DECLARE
		@RecordType         nvarchar(50),
		@BrkQty1            decimal(18,5),
		@BrkQty2            decimal(18,5),
		@BrkQty3            decimal(18,5),
		@BrkQty4            decimal(18,5),
		@BrkQty5            decimal(18,5),
		@BrkQty6            decimal(18,5),
		@BrkQty7            decimal(18,5),
		@BrkQty8            decimal(18,5),
		@BrkQty9            decimal(18,5),
		@BrkQty10           decimal(18,5),
		@BrkQty11           decimal(18,5),
		@PriceBasis1        nvarchar(50),
		@PriceBasis2        nvarchar(50),
		@PriceBasis3        nvarchar(50),
		@PriceBasis4        nvarchar(50),
		@PriceBasis5        nvarchar(50),
		@PriceBasis6        nvarchar(50),
		@PriceBasis7        nvarchar(50),
		@PriceBasis8        nvarchar(50),
		@PriceBasis9        nvarchar(50),
		@PriceBasis10       nvarchar(50),
		@PriceBasis11       nvarchar(50),
		@AdjType1           nvarchar(50),
		@AdjType2           nvarchar(50),
		@AdjType3           nvarchar(50),
		@AdjType4           nvarchar(50),
		@AdjType5           nvarchar(50),
		@AdjType6           nvarchar(50),
		@AdjType7           nvarchar(50),
		@AdjType8           nvarchar(50),
		@AdjType9           nvarchar(50),
		@AdjType10          nvarchar(50),
		@AdjType11          nvarchar(50),
		@Amount1            decimal(18,5),
		@Amount2            decimal(18,5),
		@Amount3            decimal(18,5),
		@Amount4            decimal(18,5),
		@Amount5            decimal(18,5),
		@Amount6            decimal(18,5),
		@Amount7            decimal(18,5),
		@Amount8            decimal(18,5),
		@Amount9            decimal(18,5),
		@Amount10           decimal(18,5),
		@Amount11           decimal(18,5),
		@AltAmount1         decimal(18,5),    
		@AltAmount2         decimal(18,5),    
		@AltAmount3         decimal(18,5),    
		@AltAmount4         decimal(18,5),    
		@AltAmount5         decimal(18,5),    
		@AltAmount6         decimal(18,5),    
		@AltAmount7         decimal(18,5),    
		@AltAmount8         decimal(18,5),    
		@AltAmount9         decimal(18,5),    
		@AltAmount10        decimal(18,5),    
		@AltAmount11        decimal(18,5)

	Declare @CurAmount decimal(18,5),
		@CurBrkQty int,
		@CurPriceBasis nvarchar(50),
		@CurAdjType nvarchar(50),
		@CurBasisValue decimal(18,5)

	SELECT 
		@RecordType = RecordType,
		@BrkQty1 = BreakQty01,
		@BrkQty2 = BreakQty02,
		@BrkQty3 = BreakQty03,
		@BrkQty4 = BreakQty04,
		@BrkQty5 = BreakQty05,
		@BrkQty6 = BreakQty06,
		@BrkQty7 = BreakQty07,
		@BrkQty8 = BreakQty08,
		@BrkQty9 = BreakQty09,
		@BrkQty10 = BreakQty10,
		@BrkQty11 = BreakQty11,
		@PriceBasis1 = PriceBasis01,
		@PriceBasis2 = PriceBasis02,
		@PriceBasis3 = PriceBasis03,
		@PriceBasis4 = PriceBasis04,
		@PriceBasis5 = PriceBasis05,
		@PriceBasis6 = PriceBasis06,
		@PriceBasis7 = PriceBasis07,
		@PriceBasis8 = PriceBasis08,
		@PriceBasis9 = PriceBasis09,
		@PriceBasis10 = PriceBasis10,
		@PriceBasis11 = PriceBasis11,
		@AdjType1 = AdjustmentType01,
		@AdjType2 = AdjustmentType02,
		@AdjType3 = AdjustmentType03,
		@AdjType4 = AdjustmentType04,
		@AdjType5 = AdjustmentType05,
		@AdjType6 = AdjustmentType06,
		@AdjType7 = AdjustmentType07,
		@AdjType8 = AdjustmentType08,
		@AdjType9 = AdjustmentType09,
		@AdjType10 = AdjustmentType10,
		@AdjType11 = AdjustmentType11,
		@Amount1 = Amount01,
		@Amount2 = Amount02,
		@Amount3 = Amount03,
		@Amount4 = Amount04,
		@Amount5 = Amount05,
		@Amount6 = Amount06,
		@Amount7 = Amount07,
		@Amount8 = Amount08,
		@Amount9 = Amount09,
		@Amount10 = Amount10,
		@Amount11 = Amount11,
		@AltAmount1 = AltAmount01,
		@AltAmount2 = AltAmount02,
		@AltAmount3 = AltAmount03,
		@AltAmount4 = AltAmount04,
		@AltAmount5 = AltAmount05,
		@AltAmount6 = AltAmount06,
		@AltAmount7 = AltAmount07,
		@AltAmount8 = AltAmount08,
		@AltAmount9 = AltAmount09,
		@AltAmount10 = AltAmount10,
		@AltAmount11 = AltAmount11,
		@CurBasisValue = AltAmount01
	FROM PriceMatrix (NOLOCK)
	WHERE PriceMatrixId = @PriceMatrixId

	/* And now the ugly stuff - traversing through the given record and figuring out price */
	
	if @AdjType1 = 'P'
	begin
		SELECT
			@CurAmount = 0,
			@CurBrkQty = 0,
			@CurPriceBasis = @PriceBasis1,
			@CurAdjType = @AdjType1
	end
	else	
	begin
		SELECT
			@CurAmount = @AltAmount1,
			@CurBrkQty = 0,
			@CurPriceBasis = @PriceBasis1,
			@CurAdjType = @AdjType1
	end

	IF @QtyOrdered >= @BrkQty1 AND @BrkQty1 > 0
	begin
		SELECT
			@CurAmount = @Amount1,
			@CurBrkQty = @BrkQty1,
			@CurPriceBasis = @PriceBasis1,
			@CurAdjType = @AdjType1
	end

	IF @QtyOrdered >= @BrkQty2 AND @BrkQty2 > 0
	begin
		SELECT
			@CurAmount = @Amount2,
			@CurBrkQty = @BrkQty2,
			@CurPriceBasis = @PriceBasis2,
			@CurAdjType = @AdjType2
	end

	IF @QtyOrdered >= @BrkQty3 AND @BrkQty3 > 0
	begin
		SELECT
			@CurAmount = @Amount3,
			@CurBrkQty = @BrkQty3,
			@CurPriceBasis = @PriceBasis3,
			@CurAdjType = @AdjType3
	end
	IF @QtyOrdered >= @BrkQty4 AND @BrkQty4 > 0
	begin
		SELECT
			@CurAmount = @Amount4,
			@CurBrkQty = @BrkQty4,
			@CurPriceBasis = @PriceBasis4,
			@CurAdjType = @AdjType4
	end
	IF @QtyOrdered >= @BrkQty5 AND @BrkQty5 > 0
	begin
		SELECT
			@CurAmount = @Amount5,
			@CurBrkQty = @BrkQty5,
			@CurPriceBasis = @PriceBasis5,
			@CurAdjType = @AdjType5
	end
	IF @QtyOrdered >= @BrkQty6 AND @BrkQty6 > 0
	begin
		SELECT
			@CurAmount = @Amount6,
			@CurBrkQty = @BrkQty6,
			@CurPriceBasis = @PriceBasis6,
			@CurAdjType = @AdjType6
	end
	IF @QtyOrdered >= @BrkQty7 AND @BrkQty7 > 0
	begin
		SELECT
			@CurAmount = @Amount7,
			@CurBrkQty = @BrkQty7,
			@CurPriceBasis = @PriceBasis7,
			@CurAdjType = @AdjType7
	end
	IF @QtyOrdered >= @BrkQty8 AND @BrkQty8 > 0
	begin
		SELECT
			@CurAmount = @Amount8,
			@CurBrkQty = @BrkQty8,
			@CurPriceBasis = @PriceBasis8,
			@CurAdjType = @AdjType8
	end
	IF @QtyOrdered >= @BrkQty9 AND @BrkQty9 > 0
	begin
		SELECT
			@CurAmount = @Amount9,
			@CurBrkQty = @BrkQty9,
			@CurPriceBasis = @PriceBasis9,
			@CurAdjType = @AdjType9
	end
	IF @QtyOrdered >= @BrkQty10 AND @BrkQty10 > 0
	begin
		SELECT
			@CurAmount = @Amount10,
			@CurBrkQty = @BrkQty10,
			@CurPriceBasis = @PriceBasis10,
			@CurAdjType = @AdjType10
	end
	IF @QtyOrdered >= @BrkQty11 AND @BrkQty11 > 0
	begin
		SELECT
			@CurAmount = @Amount11,
			@CurBrkQty = @BrkQty11,
			@CurPriceBasis = @PriceBasis11,
			@CurAdjType = @AdjType11
	end
	
	insert into @ReturnTable 
			(	
				recordtype,
				CurAmount,
				CurBrkQty,
				CurPriceBasis,
				CurAdjType,
				CurBasisValue
			)
		values
			(
				@Recordtype,
				@CurAmount,
				@CurBrkQty,
				@CurPriceBasis,
				@CurAdjType,
				@CurBasisValue
			)
	return
END

GO
/****** Object:  UserDefinedFunction [dbo].[GetPricingBasis_SyteLine]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Bill Behning
-- Create date: 2010-12-01
-- Description:	Function to return price basis info
-- =============================================
CREATE FUNCTION [dbo].[GetPricingBasis_SyteLine] 
(
		@PriceMatrixId     uniqueidentifier,
		@ProductId     nvarchar(36),
		@QtyOrdered	int
)

RETURNS @ReturnTable table 
(	
	recordtype			nvarchar(50),
	CurAmount			decimal(18,5),
    CurBrkQty			int,
    CurPriceBasis		nvarchar(50),
    CurAdjType			nvarchar(50),
	CurBasisValue		decimal(18,5)
)
AS
BEGIN
	DECLARE
		@RecordType         nvarchar(50),
		@BrkQty1            decimal(18,5),
		@BrkQty2            decimal(18,5),
		@BrkQty3            decimal(18,5),
		@BrkQty4            decimal(18,5),
		@BrkQty5            decimal(18,5),
		@BrkQty6            decimal(18,5),
		@BrkQty7            decimal(18,5),
		@BrkQty8            decimal(18,5),
		@BrkQty9            decimal(18,5),
		@BrkQty10           decimal(18,5),
		@BrkQty11           decimal(18,5),
		@PriceBasis1        nvarchar(50),
		@PriceBasis2        nvarchar(50),
		@PriceBasis3        nvarchar(50),
		@PriceBasis4        nvarchar(50),
		@PriceBasis5        nvarchar(50),
		@PriceBasis6        nvarchar(50),
		@PriceBasis7        nvarchar(50),
		@PriceBasis8        nvarchar(50),
		@PriceBasis9        nvarchar(50),
		@PriceBasis10       nvarchar(50),
		@PriceBasis11       nvarchar(50),
		@AdjType1           nvarchar(50),
		@AdjType2           nvarchar(50),
		@AdjType3           nvarchar(50),
		@AdjType4           nvarchar(50),
		@AdjType5           nvarchar(50),
		@AdjType6           nvarchar(50),
		@AdjType7           nvarchar(50),
		@AdjType8           nvarchar(50),
		@AdjType9           nvarchar(50),
		@AdjType10          nvarchar(50),
		@AdjType11          nvarchar(50),
		@Amount1            decimal(18,5),
		@Amount2            decimal(18,5),
		@Amount3            decimal(18,5),
		@Amount4            decimal(18,5),
		@Amount5            decimal(18,5),
		@Amount6            decimal(18,5),
		@Amount7            decimal(18,5),
		@Amount8            decimal(18,5),
		@Amount9            decimal(18,5),
		@Amount10           decimal(18,5),
		@Amount11           decimal(18,5),
		@AltAmount1         decimal(18,5),    
		@AltAmount2         decimal(18,5),    
		@AltAmount3         decimal(18,5),    
		@AltAmount4         decimal(18,5),    
		@AltAmount5         decimal(18,5),    
		@AltAmount6         decimal(18,5),    
		@AltAmount7         decimal(18,5),    
		@AltAmount8         decimal(18,5),    
		@AltAmount9         decimal(18,5),    
		@AltAmount10        decimal(18,5),    
		@AltAmount11        decimal(18,5)

	Declare @CurAmount decimal(18,5),
		@CurBrkQty int,
		@CurPriceBasis nvarchar(50),
		@CurAdjType nvarchar(50),
		@CurBasisValue decimal(18,5)

	SELECT 
		@RecordType = RecordType,
		@BrkQty1 = BreakQty01,
		@BrkQty2 = BreakQty02,
		@BrkQty3 = BreakQty03,
		@BrkQty4 = BreakQty04,
		@BrkQty5 = BreakQty05,
		@BrkQty6 = BreakQty06,
		@BrkQty7 = BreakQty07,
		@BrkQty8 = BreakQty08,
		@BrkQty9 = BreakQty09,
		@BrkQty10 = BreakQty10,
		@BrkQty11 = BreakQty11,
		@PriceBasis1 = PriceBasis01,
		@PriceBasis2 = PriceBasis02,
		@PriceBasis3 = PriceBasis03,
		@PriceBasis4 = PriceBasis04,
		@PriceBasis5 = PriceBasis05,
		@PriceBasis6 = PriceBasis06,
		@PriceBasis7 = PriceBasis07,
		@PriceBasis8 = PriceBasis08,
		@PriceBasis9 = PriceBasis09,
		@PriceBasis10 = PriceBasis10,
		@PriceBasis11 = PriceBasis11,
		@AdjType1 = AdjustmentType01,
		@AdjType2 = AdjustmentType02,
		@AdjType3 = AdjustmentType03,
		@AdjType4 = AdjustmentType04,
		@AdjType5 = AdjustmentType05,
		@AdjType6 = AdjustmentType06,
		@AdjType7 = AdjustmentType07,
		@AdjType8 = AdjustmentType08,
		@AdjType9 = AdjustmentType09,
		@AdjType10 = AdjustmentType10,
		@AdjType11 = AdjustmentType11,
		@Amount1 = Amount01,
		@Amount2 = Amount02,
		@Amount3 = Amount03,
		@Amount4 = Amount04,
		@Amount5 = Amount05,
		@Amount6 = Amount06,
		@Amount7 = Amount07,
		@Amount8 = Amount08,
		@Amount9 = Amount09,
		@Amount10 = Amount10,
		@Amount11 = Amount11,
		@AltAmount1 = AltAmount01,
		@AltAmount2 = AltAmount02,
		@AltAmount3 = AltAmount03,
		@AltAmount4 = AltAmount04,
		@AltAmount5 = AltAmount05,
		@AltAmount6 = AltAmount06,
		@AltAmount7 = AltAmount07,
		@AltAmount8 = AltAmount08,
		@AltAmount9 = AltAmount09,
		@AltAmount10 = AltAmount10,
		@AltAmount11 = AltAmount11,
		@CurBasisValue = AltAmount01
	FROM PriceMatrix (NOLOCK)
	WHERE PriceMatrixId = @PriceMatrixId


	SELECT
		@CurAmount = @Amount1,
		@CurBrkQty = 0,
		@CurPriceBasis = @PriceBasis1,
		@CurAdjType = @AdjType1


	/* And now the ugly stuff - traversing through the given record and figuring out price */
	IF @CurPriceBasis in ('P1','P2','P3','P4','P5')
	begin
		IF @CurPriceBasis = 'P1'
		begin
			-- get the BasisValue from the product pricematrix record
			SELECT 
				@CurBasisValue = AltAmount01
			FROM PriceMatrix (NOLOCK)
			WHERE productkeypart = @Productid and recordtype = 'Product'
		end

		IF @CurPriceBasis = 'P2'
		begin
			-- get the BasisValue from the product pricematrix record
			SELECT 
				@CurBasisValue = AltAmount02
			FROM PriceMatrix (NOLOCK)
			WHERE productkeypart = @Productid and recordtype = 'Product'
		end
		IF @CurPriceBasis = 'P3'
		begin
			-- get the BasisValue from the product pricematrix record
			SELECT 
				@CurBasisValue = AltAmount03
			FROM PriceMatrix (NOLOCK)
			WHERE productkeypart = @Productid and recordtype = 'Product'
		end
		IF @CurPriceBasis = 'P4'
		begin
			-- get the BasisValue from the product pricematrix record
			SELECT 
				@CurBasisValue = AltAmount04
			FROM PriceMatrix (NOLOCK)
			WHERE productkeypart = @Productid and recordtype = 'Product'
		end
		IF @CurPriceBasis = 'P5'
		begin
			-- get the BasisValue from the product pricematrix record
			SELECT 
				@CurBasisValue = AltAmount05
			FROM PriceMatrix (NOLOCK)
			WHERE productkeypart = @Productid and recordtype = 'Product'
		end
	end

	IF @QtyOrdered >= @BrkQty1 AND @BrkQty1 > 0
	begin
		SELECT
			@CurAmount = @Amount1,
			@CurBrkQty = @BrkQty1,
			@CurPriceBasis = @PriceBasis1,
			@CurAdjType = @AdjType1
	end

	IF @QtyOrdered >= @BrkQty2 AND @BrkQty2 > 0
	begin
		SELECT
			@CurAmount = @Amount2,
			@CurBrkQty = @BrkQty2,
			@CurPriceBasis = @PriceBasis2,
			@CurAdjType = @AdjType2
	end

	IF @QtyOrdered >= @BrkQty3 AND @BrkQty3 > 0
	begin
		SELECT
			@CurAmount = @Amount3,
			@CurBrkQty = @BrkQty3,
			@CurPriceBasis = @PriceBasis3,
			@CurAdjType = @AdjType3
	end
	IF @QtyOrdered >= @BrkQty4 AND @BrkQty4 > 0
	begin
		SELECT
			@CurAmount = @Amount4,
			@CurBrkQty = @BrkQty4,
			@CurPriceBasis = @PriceBasis4,
			@CurAdjType = @AdjType4
	end
	IF @QtyOrdered >= @BrkQty5 AND @BrkQty5 > 0
	begin
		SELECT
			@CurAmount = @Amount5,
			@CurBrkQty = @BrkQty5,
			@CurPriceBasis = @PriceBasis5,
			@CurAdjType = @AdjType5
	end
	IF @QtyOrdered >= @BrkQty6 AND @BrkQty6 > 0
	begin
		SELECT
			@CurAmount = @Amount6,
			@CurBrkQty = @BrkQty6,
			@CurPriceBasis = @PriceBasis6,
			@CurAdjType = @AdjType6
	end
	IF @QtyOrdered >= @BrkQty7 AND @BrkQty7 > 0
	begin
		SELECT
			@CurAmount = @Amount7,
			@CurBrkQty = @BrkQty7,
			@CurPriceBasis = @PriceBasis7,
			@CurAdjType = @AdjType7
	end
	IF @QtyOrdered >= @BrkQty8 AND @BrkQty8 > 0
	begin
		SELECT
			@CurAmount = @Amount8,
			@CurBrkQty = @BrkQty8,
			@CurPriceBasis = @PriceBasis8,
			@CurAdjType = @AdjType8
	end
	IF @QtyOrdered >= @BrkQty9 AND @BrkQty9 > 0
	begin
		SELECT
			@CurAmount = @Amount9,
			@CurBrkQty = @BrkQty9,
			@CurPriceBasis = @PriceBasis9,
			@CurAdjType = @AdjType9
	end
	IF @QtyOrdered >= @BrkQty10 AND @BrkQty10 > 0
	begin
		SELECT
			@CurAmount = @Amount10,
			@CurBrkQty = @BrkQty10,
			@CurPriceBasis = @PriceBasis10,
			@CurAdjType = @AdjType10
	end
	IF @QtyOrdered >= @BrkQty11 AND @BrkQty11 > 0
	begin
		SELECT
			@CurAmount = @Amount11,
			@CurBrkQty = @BrkQty11,
			@CurPriceBasis = @PriceBasis11,
			@CurAdjType = @AdjType11
	end
	
	insert into @ReturnTable 
			(	
				recordtype,
				CurAmount,
				CurBrkQty,
				CurPriceBasis,
				CurAdjType,
				CurBasisValue
			)
		values
			(
				@Recordtype,
				@CurAmount,
				@CurBrkQty,
				@CurPriceBasis,
				@CurAdjType,
				@CurBasisValue
			)
	return
END

GO
/****** Object:  UserDefinedFunction [dbo].[GetStringPart]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Bill Behning
-- Create date: 10/06/2010
-- Description:	Function to return a specific part of a delimeted string
-- =============================================

create function [dbo].[GetStringPart] 
( 
    @string nvarchar(4000),		-- String to be parsed
    @delimiter nvarchar(10),	-- delimeter value
	@sequence int,				-- position of string to be returned
	@DefaultValue nvarchar(50)	-- Default value if the desired position of the string is is null
) 

returns  nvarchar(4000) 
 
begin 
	declare @ReturnString nvarchar(4000) 
    declare @nextString nvarchar(4000) 
    declare @pos int, @nextPos int 
	declare @sequenceCount int
 

	set @ReturnString = @DefaultValue

    set @nextString = '' 
    set @string = @string + @delimiter 

	set @sequenceCount = 0
	set @pos = charindex(@delimiter, @string) 
    set @nextPos = 1 
    while (@pos <> 0) 
    begin 
        set @nextString = substring(@string, 1, @pos - 1) 
		set @sequenceCount = @sequenceCount + 1
		
		if @sequenceCount = @sequence
		begin
			set @ReturnString = @NextString
			break
		end
 
        set @string = substring(@string, @pos + 1, len(@string)) 
        set @nextPos = @pos 
        set @pos = charindex(@delimiter, @string) 
    end 
    return @ReturnString
end 

GO
/****** Object:  UserDefinedFunction [dbo].[GetVendorSalePrice_Epicor]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
create FUNCTION [dbo].[GetVendorSalePrice_Epicor]
(
	@QtyOrdered int,
	@ProductId uniqueidentifier,
	@CurrencyCode nvarchar(50),
	@Warehouse	nvarchar(50),
	@UnitOfMeasure nvarchar(50),
	@PricingDate datetime
)

RETURNS Decimal(18,5)
AS
BEGIN
	declare @SalePrice decimal(18,5),
		@PriceMatrixId uniqueidentifier,
        @BrkQty1 int,
        @BrkQty2 int,
        @BrkQty3 int,
        @BrkQty4 int,
        @BrkQty5 int,
        @BrkQty6 int,
        @BrkQty7 int,
        @BrkQty8 int,
        @BrkQty9 int,
        @BrkQty10 int,
        @BrkQty11 int,
        @Amount1 decimal(18,5),
        @Amount2 decimal(18,5),
        @Amount3 decimal(18,5),
        @Amount4 decimal(18,5),
        @Amount5 decimal(18,5),
        @Amount6 decimal(18,5),
        @Amount7 decimal(18,5),
        @Amount8 decimal(18,5),
        @Amount9 decimal(18,5),
        @Amount10 decimal(18,5),
        @Amount11 decimal(18,5)


      SET @PriceMatrixId = NULL
      SET @SalePrice = 0
      SELECT 
        @PriceMatrixId = PriceMatrixId,
        @BrkQty1 = BreakQty01,
        @BrkQty2 = BreakQty02,
        @BrkQty3 = BreakQty03,
        @BrkQty4 = BreakQty04,
        @BrkQty5 = BreakQty05,
        @BrkQty6 = BreakQty06,
        @BrkQty7 = BreakQty07,
        @BrkQty8 = BreakQty08,
        @BrkQty9 = BreakQty09,
        @BrkQty10 = BreakQty10,
        @BrkQty11 = BreakQty11,
        @Amount1 = Amount01,
        @Amount2 = Amount02,
        @Amount3 = Amount03,
        @Amount4 = Amount04,
        @Amount5 = Amount05,
        @Amount6 = Amount06,
        @Amount7 = Amount07,
        @Amount8 = Amount08,
        @Amount9 = Amount09,
        @Amount10 = Amount10,
        @Amount11 = Amount11
      FROM PriceMatrix (NOLOCK) 
      WHERE
        RecordType = 'Product Sale' AND
        CurrencyCode = @CurrencyCode AND
        Warehouse = @Warehouse AND
        UnitOfMeasure = @UnitOfMeasure AND
        CustomerKeyPart = '' AND
        ProductKeyPart = @ProductId AND
        Active <= @PricingDate AND
        (Deactivate IS NULL OR Deactivate > @PricingDate)

      IF @PriceMatrixId IS NOT NULL
      BEGIN
        IF @QtyOrdered >= @BrkQty1                    SET @SalePrice = @Amount1
        IF @QtyOrdered >= @BrkQty2  AND @BrkQty2  > 0 SET @SalePrice = @Amount2
        IF @QtyOrdered >= @BrkQty3  AND @BrkQty3  > 0 SET @SalePrice = @Amount3
        IF @QtyOrdered >= @BrkQty4  AND @BrkQty4  > 0 SET @SalePrice = @Amount4
        IF @QtyOrdered >= @BrkQty5  AND @BrkQty5  > 0 SET @SalePrice = @Amount5
        IF @QtyOrdered >= @BrkQty6  AND @BrkQty6  > 0 SET @SalePrice = @Amount6
        IF @QtyOrdered >= @BrkQty7  AND @BrkQty7  > 0 SET @SalePrice = @Amount7
        IF @QtyOrdered >= @BrkQty8  AND @BrkQty8  > 0 SET @SalePrice = @Amount8
        IF @QtyOrdered >= @BrkQty9  AND @BrkQty9  > 0 SET @SalePrice = @Amount9
        IF @QtyOrdered >= @BrkQty10 AND @BrkQty10 > 0 SET @SalePrice = @Amount10
        IF @QtyOrdered >= @BrkQty11 AND @BrkQty11 > 0 SET @SalePrice = @Amount11    
      END

	-- Return the result of the function
	RETURN @SalePrice

END

GO
/****** Object:  UserDefinedFunction [dbo].[GetVendorSalePrice_SyteLine]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
create FUNCTION [dbo].[GetVendorSalePrice_SyteLine]
(
	@QtyOrdered int,
	@ProductId uniqueidentifier,
	@CurrencyCode nvarchar(50),
	@Warehouse	nvarchar(50),
	@UnitOfMeasure nvarchar(50),
	@PricingDate datetime
)

RETURNS Decimal(18,5)
AS
BEGIN
	declare @SalePrice decimal(18,5),
		@PriceMatrixId uniqueidentifier,
        @BrkQty1 int,
        @BrkQty2 int,
        @BrkQty3 int,
        @BrkQty4 int,
        @BrkQty5 int,
        @BrkQty6 int,
        @BrkQty7 int,
        @BrkQty8 int,
        @BrkQty9 int,
        @BrkQty10 int,
        @BrkQty11 int,
        @Amount1 decimal(18,5),
        @Amount2 decimal(18,5),
        @Amount3 decimal(18,5),
        @Amount4 decimal(18,5),
        @Amount5 decimal(18,5),
        @Amount6 decimal(18,5),
        @Amount7 decimal(18,5),
        @Amount8 decimal(18,5),
        @Amount9 decimal(18,5),
        @Amount10 decimal(18,5),
        @Amount11 decimal(18,5)


      SET @PriceMatrixId = NULL
      SET @SalePrice = 0
      SELECT 
        @PriceMatrixId = PriceMatrixId,
        @BrkQty1 = BreakQty01,
        @BrkQty2 = BreakQty02,
        @BrkQty3 = BreakQty03,
        @BrkQty4 = BreakQty04,
        @BrkQty5 = BreakQty05,
        @BrkQty6 = BreakQty06,
        @BrkQty7 = BreakQty07,
        @BrkQty8 = BreakQty08,
        @BrkQty9 = BreakQty09,
        @BrkQty10 = BreakQty10,
        @BrkQty11 = BreakQty11,
        @Amount1 = Amount01,
        @Amount2 = Amount02,
        @Amount3 = Amount03,
        @Amount4 = Amount04,
        @Amount5 = Amount05,
        @Amount6 = Amount06,
        @Amount7 = Amount07,
        @Amount8 = Amount08,
        @Amount9 = Amount09,
        @Amount10 = Amount10,
        @Amount11 = Amount11
      FROM PriceMatrix (NOLOCK) 
      WHERE
        RecordType = 'Product Sale' AND
        CurrencyCode = @CurrencyCode AND
        Warehouse = @Warehouse AND
        UnitOfMeasure = @UnitOfMeasure AND
        CustomerKeyPart = '' AND
        ProductKeyPart = @ProductId AND
        Active <= @PricingDate AND
        (Deactivate IS NULL OR Deactivate > @PricingDate)

      IF @PriceMatrixId IS NOT NULL
      BEGIN
        IF @QtyOrdered >= @BrkQty1                    SET @SalePrice = @Amount1
        IF @QtyOrdered >= @BrkQty2  AND @BrkQty2  > 0 SET @SalePrice = @Amount2
        IF @QtyOrdered >= @BrkQty3  AND @BrkQty3  > 0 SET @SalePrice = @Amount3
        IF @QtyOrdered >= @BrkQty4  AND @BrkQty4  > 0 SET @SalePrice = @Amount4
        IF @QtyOrdered >= @BrkQty5  AND @BrkQty5  > 0 SET @SalePrice = @Amount5
        IF @QtyOrdered >= @BrkQty6  AND @BrkQty6  > 0 SET @SalePrice = @Amount6
        IF @QtyOrdered >= @BrkQty7  AND @BrkQty7  > 0 SET @SalePrice = @Amount7
        IF @QtyOrdered >= @BrkQty8  AND @BrkQty8  > 0 SET @SalePrice = @Amount8
        IF @QtyOrdered >= @BrkQty9  AND @BrkQty9  > 0 SET @SalePrice = @Amount9
        IF @QtyOrdered >= @BrkQty10 AND @BrkQty10 > 0 SET @SalePrice = @Amount10
        IF @QtyOrdered >= @BrkQty11 AND @BrkQty11 > 0 SET @SalePrice = @Amount11    
      END

	-- Return the result of the function
	RETURN @SalePrice

END

GO
/****** Object:  Table [dbo].[Affiliate]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Affiliate](
	[AffiliateId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
	[Image] [nvarchar](128) NOT NULL,
	[IsActive] [tinyint] NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[Url] [nvarchar](max) NOT NULL,
	[ReplaceLogoImage] [tinyint] NOT NULL,
 CONSTRAINT [PK_Affiliate] PRIMARY KEY CLUSTERED 
(
	[AffiliateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ApplicationDictionary]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ApplicationDictionary](
	[ApplicationDictionaryId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_ApplicationDictionary_ApplicationDictionaryId]  DEFAULT (newsequentialid()),
	[ObjectName] [nvarchar](100) NOT NULL CONSTRAINT [DF_ApplicationDictionary_ObjectName]  DEFAULT (''),
	[FieldName] [nvarchar](100) NOT NULL CONSTRAINT [DF_ApplicationDictionary_FieldName]  DEFAULT (''),
	[Description] [nvarchar](max) NOT NULL CONSTRAINT [DF_ApplicationDictionary_Description]  DEFAULT (''),
	[IncludeInExport] [tinyint] NOT NULL CONSTRAINT [DF_ApplicationDictionary_IncludeInExport]  DEFAULT ((0)),
	[ExportWithChildren] [tinyint] NOT NULL CONSTRAINT [DF_ApplicationDictionary_ExportWithChildren]  DEFAULT ((0)),
	[DataType] [nvarchar](255) NOT NULL CONSTRAINT [DF_ApplicationDictionary_DataType]  DEFAULT (''),
	[GridOrder] [decimal](18, 5) NOT NULL CONSTRAINT [DF_ApplicationDictionary_GridOrder]  DEFAULT ((0)),
	[FormOrder] [decimal](18, 5) NOT NULL CONSTRAINT [DF_ApplicationDictionary_FormOrder]  DEFAULT ((0)),
	[TabNumber] [int] NOT NULL CONSTRAINT [DF_ApplicationDictionary_TabNumber]  DEFAULT ((0)),
	[CanBeLocalized] [tinyint] NOT NULL CONSTRAINT [DF_ApplicationDictionary_CanBeLocalized]  DEFAULT ((0)),
 CONSTRAINT [PK_ApplicationDictionary] PRIMARY KEY CLUSTERED 
(
	[ApplicationDictionaryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ApplicationLog]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ApplicationLog](
	[ApplicationLogId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_ApplicationLog_ApplicationLogId]  DEFAULT (newsequentialid()),
	[BatchNumber] [int] NOT NULL CONSTRAINT [DF_ApplicationLog_BatchNumber]  DEFAULT ((0)),
	[Source] [nvarchar](255) NOT NULL CONSTRAINT [DF_ApplicationLog_Source]  DEFAULT (''),
	[Message] [nvarchar](max) NOT NULL,
	[LogDate] [datetime] NOT NULL CONSTRAINT [DF_ApplicationLog_LogDate]  DEFAULT (getdate()),
	[Type] [nvarchar](255) NOT NULL CONSTRAINT [DF_ApplicationLog_Type]  DEFAULT (''),
	[Sequence] [int] IDENTITY(1,1) NOT NULL,
	[ErrorCount] [int] NOT NULL CONSTRAINT [DF_ApplicationLog_ErrorCount]  DEFAULT ((0)),
 CONSTRAINT [PK_ApplicationLog] PRIMARY KEY CLUSTERED 
(
	[ApplicationLogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ApplicationMessage]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ApplicationMessage](
	[ApplicationMessageId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_ApplicationMessage_ApplicationMessageId]  DEFAULT (newsequentialid()),
	[Name] [nvarchar](250) NOT NULL CONSTRAINT [DF_Message_Name]  DEFAULT (''),
	[Message] [nvarchar](max) NOT NULL CONSTRAINT [DF_Message_Message]  DEFAULT (''),
 CONSTRAINT [PK_Message] PRIMARY KEY CLUSTERED 
(
	[ApplicationMessageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ApplicationSetting]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ApplicationSetting](
	[ApplicationSettingId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_ApplicationSetting_ApplicationSettingId]  DEFAULT (newsequentialid()),
	[Name] [nvarchar](256) NOT NULL CONSTRAINT [DF_ApplicationSetting_Name]  DEFAULT (''),
	[Value] [nvarchar](max) NOT NULL CONSTRAINT [DF_ApplicationSetting_Value]  DEFAULT (''),
	[Description] [nvarchar](max) NOT NULL CONSTRAINT [DF_ApplicationSetting_Description]  DEFAULT (''),
 CONSTRAINT [PK_ApplicationSetting] PRIMARY KEY CLUSTERED 
(
	[ApplicationSettingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[aspnet_Applications]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_Applications](
	[ApplicationName] [nvarchar](256) NOT NULL,
	[LoweredApplicationName] [nvarchar](256) NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_aspnet_Applications_ApplicationId]  DEFAULT (newid()),
	[Description] [nvarchar](256) NULL,
 CONSTRAINT [PK__aspnet_Applicati__2645B050] PRIMARY KEY NONCLUSTERED 
(
	[ApplicationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ__aspnet_Applicati__2739D489] UNIQUE NONCLUSTERED 
(
	[LoweredApplicationName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ__aspnet_Applicati__282DF8C2] UNIQUE NONCLUSTERED 
(
	[ApplicationName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [aspnet_Applications_Index]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE CLUSTERED INDEX [aspnet_Applications_Index] ON [dbo].[aspnet_Applications]
(
	[LoweredApplicationName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[aspnet_Membership]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_Membership](
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[Password] [nvarchar](128) NOT NULL,
	[PasswordFormat] [int] NOT NULL CONSTRAINT [DF_aspnet_Membership_PasswordFormat]  DEFAULT ((0)),
	[PasswordSalt] [nvarchar](128) NOT NULL,
	[MobilePIN] [nvarchar](16) NULL,
	[Email] [nvarchar](256) NULL,
	[LoweredEmail] [nvarchar](256) NULL,
	[PasswordQuestion] [nvarchar](256) NULL,
	[PasswordAnswer] [nvarchar](128) NULL,
	[IsApproved] [bit] NOT NULL,
	[IsLockedOut] [bit] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastLoginDate] [datetime] NOT NULL,
	[LastPasswordChangedDate] [datetime] NOT NULL,
	[LastLockoutDate] [datetime] NOT NULL,
	[FailedPasswordAttemptCount] [int] NOT NULL,
	[FailedPasswordAttemptWindowStart] [datetime] NOT NULL,
	[FailedPasswordAnswerAttemptCount] [int] NOT NULL,
	[FailedPasswordAnswerAttemptWindowStart] [datetime] NOT NULL,
	[Comment] [ntext] NULL,
 CONSTRAINT [PK__aspnet_Membershi__3B40CD36] PRIMARY KEY NONCLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [aspnet_Membership_index]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE CLUSTERED INDEX [aspnet_Membership_index] ON [dbo].[aspnet_Membership]
(
	[ApplicationId] ASC,
	[LoweredEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[aspnet_Paths]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_Paths](
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[PathId] [uniqueidentifier] NOT NULL,
	[Path] [nvarchar](256) NOT NULL,
	[LoweredPath] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK__aspnet_Paths__6CD828CA] PRIMARY KEY NONCLUSTERED 
(
	[PathId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [aspnet_Paths_index]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE CLUSTERED INDEX [aspnet_Paths_index] ON [dbo].[aspnet_Paths]
(
	[ApplicationId] ASC,
	[LoweredPath] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[aspnet_PersonalizationAllUsers]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_PersonalizationAllUsers](
	[PathId] [uniqueidentifier] NOT NULL,
	[PageSettings] [image] NOT NULL,
	[LastUpdatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK__aspnet_Personali__72910220] PRIMARY KEY CLUSTERED 
(
	[PathId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[aspnet_PersonalizationPerUser]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_PersonalizationPerUser](
	[Id] [uniqueidentifier] NOT NULL,
	[PathId] [uniqueidentifier] NULL,
	[UserId] [uniqueidentifier] NULL,
	[PageSettings] [image] NOT NULL,
	[LastUpdatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK__aspnet_Personali__756D6ECB] PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Index [aspnet_PersonalizationPerUser_index1]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE CLUSTERED INDEX [aspnet_PersonalizationPerUser_index1] ON [dbo].[aspnet_PersonalizationPerUser]
(
	[PathId] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[aspnet_Profile]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_Profile](
	[UserId] [uniqueidentifier] NOT NULL,
	[PropertyNames] [ntext] NOT NULL,
	[PropertyValuesString] [ntext] NOT NULL,
	[PropertyValuesBinary] [image] NOT NULL,
	[LastUpdatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK__aspnet_Profile__503BEA1C] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[aspnet_Roles]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_Roles](
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_aspnet_Roles_RoleId]  DEFAULT (newid()),
	[RoleName] [nvarchar](256) NOT NULL,
	[LoweredRoleName] [nvarchar](256) NOT NULL,
	[Description] [nvarchar](256) NULL,
 CONSTRAINT [PK__aspnet_Roles__59C55456] PRIMARY KEY NONCLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [aspnet_Roles_index1]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE CLUSTERED INDEX [aspnet_Roles_index1] ON [dbo].[aspnet_Roles]
(
	[ApplicationId] ASC,
	[LoweredRoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[aspnet_SchemaVersions]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_SchemaVersions](
	[Feature] [nvarchar](128) NOT NULL,
	[CompatibleSchemaVersion] [nvarchar](128) NOT NULL,
	[IsCurrentVersion] [bit] NOT NULL,
 CONSTRAINT [PK__aspnet_SchemaVer__30C33EC3] PRIMARY KEY CLUSTERED 
(
	[Feature] ASC,
	[CompatibleSchemaVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[aspnet_Users]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_Users](
	[ApplicationId] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_aspnet_Users_UserId]  DEFAULT (newid()),
	[UserName] [nvarchar](256) NOT NULL,
	[LoweredUserName] [nvarchar](256) NOT NULL,
	[MobileAlias] [nvarchar](16) NULL CONSTRAINT [DF_aspnet_Users_MobileAlias]  DEFAULT (NULL),
	[IsAnonymous] [bit] NOT NULL CONSTRAINT [DF_aspnet_Users_IsAnonymous]  DEFAULT ((0)),
	[LastActivityDate] [datetime] NOT NULL,
 CONSTRAINT [PK__aspnet_Users__2B0A656D] PRIMARY KEY NONCLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [aspnet_Users_Index]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE CLUSTERED INDEX [aspnet_Users_Index] ON [dbo].[aspnet_Users]
(
	[ApplicationId] ASC,
	[LoweredUserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[aspnet_UsersInRoles]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aspnet_UsersInRoles](
	[UserId] [uniqueidentifier] NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK__aspnet_UsersInRo__5D95E53A] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[aspnet_WebEvent_Events]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[aspnet_WebEvent_Events](
	[EventId] [char](32) NOT NULL,
	[EventTimeUtc] [datetime] NOT NULL,
	[EventTime] [datetime] NOT NULL,
	[EventType] [nvarchar](256) NOT NULL,
	[EventSequence] [decimal](19, 0) NOT NULL,
	[EventOccurrence] [decimal](19, 0) NOT NULL,
	[EventCode] [int] NOT NULL,
	[EventDetailCode] [int] NOT NULL,
	[Message] [nvarchar](1024) NULL,
	[ApplicationPath] [nvarchar](256) NULL,
	[ApplicationVirtualPath] [nvarchar](256) NULL,
	[MachineName] [nvarchar](256) NOT NULL,
	[RequestUrl] [nvarchar](1024) NULL,
	[ExceptionType] [nvarchar](256) NULL,
	[Details] [ntext] NULL,
 CONSTRAINT [PK__aspnet_WebEvent___078C1F06] PRIMARY KEY CLUSTERED 
(
	[EventId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Audit]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Audit](
	[AuditId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Audit_AuditId]  DEFAULT (newsequentialid()),
	[AuditDate] [datetime] NOT NULL,
	[UserName] [nvarchar](255) NOT NULL CONSTRAINT [DF_Audit_UserName]  DEFAULT (''),
	[IPAddress] [varchar](255) NOT NULL CONSTRAINT [DF_Audit_IPAddress]  DEFAULT (''),
	[Action] [varchar](255) NOT NULL CONSTRAINT [DF_Audit_Action]  DEFAULT (''),
	[Description] [varchar](max) NOT NULL CONSTRAINT [DF_Audit_Description]  DEFAULT (''),
 CONSTRAINT [PK_Audit] PRIMARY KEY CLUSTERED 
(
	[AuditId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BudgetCalendar]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BudgetCalendar](
	[BudgetCalendarId] [uniqueidentifier] NOT NULL,
	[CustomerId] [uniqueidentifier] NOT NULL,
	[FiscalYear] [int] NOT NULL,
	[Period1StartDate] [datetime] NULL,
	[Period2StartDate] [datetime] NULL,
	[Period3StartDate] [datetime] NULL,
	[Period4StartDate] [datetime] NULL,
	[Period5StartDate] [datetime] NULL,
	[Period6StartDate] [datetime] NULL,
	[Period7StartDate] [datetime] NULL,
	[Period8StartDate] [datetime] NULL,
	[Period9StartDate] [datetime] NULL,
	[Period10StartDate] [datetime] NULL,
	[Period11StartDate] [datetime] NULL,
	[Period12StartDate] [datetime] NULL,
	[Period13StartDate] [datetime] NULL,
 CONSTRAINT [PK_BudgetCalendar] PRIMARY KEY CLUSTERED 
(
	[BudgetCalendarId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CacheKeySuffix]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CacheKeySuffix](
	[Name] [nvarchar](50) NOT NULL CONSTRAINT [DF_CacheKeySuffix_Name]  DEFAULT (''),
	[Suffix] [nvarchar](50) NOT NULL CONSTRAINT [DF_CacheKeySuffix_KeySuffix]  DEFAULT (''),
 CONSTRAINT [PK_CacheKeySuffix] PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Carrier]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Carrier](
	[CarrierId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Carrier_CarrierId]  DEFAULT (newsequentialid()),
	[Name] [nvarchar](100) NOT NULL CONSTRAINT [DF_Carrier_Name]  DEFAULT (''),
	[Description] [nvarchar](max) NOT NULL CONSTRAINT [DF_Carrier_Description]  DEFAULT (''),
	[Image] [nvarchar](100) NOT NULL CONSTRAINT [DF_Carrier_Image]  DEFAULT (''),
	[UserName] [nvarchar](100) NOT NULL CONSTRAINT [DF_Carrier_UserName]  DEFAULT (''),
	[Password] [nvarchar](100) NOT NULL CONSTRAINT [DF_Carrier_Password]  DEFAULT (''),
	[AccountNumber] [nvarchar](100) NOT NULL CONSTRAINT [DF_Carrier_AccountNumber]  DEFAULT (''),
	[AccessKey] [nvarchar](100) NOT NULL CONSTRAINT [DF_Carrier_AccessKey]  DEFAULT (''),
	[Enable] [tinyint] NOT NULL CONSTRAINT [DF_Carrier_Enable]  DEFAULT ((0)),
	[IsLive] [tinyint] NOT NULL CONSTRAINT [DF_Carrier_IsLive]  DEFAULT ((0)),
	[LiveUrl] [nvarchar](max) NOT NULL CONSTRAINT [DF_Carrier_LiveUrl]  DEFAULT (''),
	[TestUrl] [nvarchar](max) NOT NULL CONSTRAINT [DF_Carrier_TestUrl]  DEFAULT (''),
	[ShippingCalculation] [nvarchar](50) NOT NULL CONSTRAINT [DF_Carrier_ShippingCalculation]  DEFAULT ('None'),
	[IsPrimaryCarrier] [tinyint] NOT NULL CONSTRAINT [DF_Carrier_IsPrimaryCarrier]  DEFAULT ((0)),
	[RatingService] [nvarchar](500) NOT NULL CONSTRAINT [DF_Carrier_RatingService]  DEFAULT ('None'),
	[ContactName] [nvarchar](100) NOT NULL CONSTRAINT [DF_Carrier_ContactName]  DEFAULT (''),
	[ContactPhone] [nvarchar](50) NOT NULL CONSTRAINT [DF_Carrier_ContactPhone]  DEFAULT (''),
	[ContactEmail] [nvarchar](100) NOT NULL CONSTRAINT [DF_Carrier_ContactEmail]  DEFAULT (''),
	[BackUpCarrierId] [uniqueidentifier] NULL,
	[CurrencyId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Carrier] PRIMARY KEY CLUSTERED 
(
	[CarrierId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CarrierPackage]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CarrierPackage](
	[CarrierPackageId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_CarrierPackage_CarrierPackageId]  DEFAULT (newsequentialid()),
	[CarrierId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](50) NOT NULL CONSTRAINT [DF_CarrierPackage_Name]  DEFAULT (''),
	[Length] [decimal](18, 5) NOT NULL CONSTRAINT [DF_CarrierPackage_Length]  DEFAULT ((0)),
	[Width] [decimal](18, 5) NOT NULL CONSTRAINT [DF_CarrierPackage_Width]  DEFAULT ((0)),
	[Height] [decimal](18, 5) NOT NULL CONSTRAINT [DF_CarrierPackage_Height]  DEFAULT ((0)),
	[Weight] [decimal](18, 5) NOT NULL CONSTRAINT [DF_CarrierPackage_Weight]  DEFAULT ((0)),
	[IsActive] [tinyint] NOT NULL CONSTRAINT [DF_CarrierPackage_IsActive]  DEFAULT ((1)),
 CONSTRAINT [PK_CarrierPackage] PRIMARY KEY CLUSTERED 
(
	[CarrierPackageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CarrierZone]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CarrierZone](
	[CarrierZoneId] [uniqueidentifier] NOT NULL,
	[CarrierId] [uniqueidentifier] NOT NULL,
	[Zone] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_CarrierZone] PRIMARY KEY CLUSTERED 
(
	[CarrierZoneId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CarrierZoneRate]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CarrierZoneRate](
	[CarrierZoneRateId] [uniqueidentifier] NOT NULL,
	[CarrierZoneId] [uniqueidentifier] NOT NULL,
	[Weight] [decimal](18, 5) NOT NULL,
	[Rate] [decimal](18, 5) NOT NULL,
 CONSTRAINT [PK_CarrierZoneRate] PRIMARY KEY CLUSTERED 
(
	[CarrierZoneRateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CarrierZoneZipCodeRange]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CarrierZoneZipCodeRange](
	[CarrierZoneZipCodeRangeId] [uniqueidentifier] NOT NULL,
	[CarrierZoneId] [uniqueidentifier] NOT NULL,
	[ZipStartRange] [nvarchar](50) NOT NULL,
	[ZipEndRange] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_CarrierZoneZipCodeRange] PRIMARY KEY CLUSTERED 
(
	[CarrierZoneZipCodeRangeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Category]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Category_CategoryId]  DEFAULT (newsequentialid()),
	[ParentId] [uniqueidentifier] NULL,
	[WebSiteId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[ShortDescription] [nvarchar](255) NOT NULL CONSTRAINT [DF_Category_ShortDescription]  DEFAULT (''),
	[Description] [nvarchar](max) NOT NULL CONSTRAINT [DF_Category_Description]  DEFAULT (''),
	[SmallImagePath] [nvarchar](255) NOT NULL CONSTRAINT [DF_Category_SmallImagePath]  DEFAULT (''),
	[LargeImagePath] [nvarchar](255) NOT NULL CONSTRAINT [DF_Category_LargeImagePath]  DEFAULT (''),
	[Active] [datetime] NOT NULL CONSTRAINT [DF_Category_Active]  DEFAULT (getdate()),
	[Deactivate] [datetime] NULL,
	[StyleSheet] [nvarchar](255) NOT NULL CONSTRAINT [DF_Category_StyleSheet]  DEFAULT (''),
	[MetaTags] [nvarchar](max) NOT NULL CONSTRAINT [DF_Category_MetaTags]  DEFAULT (''),
	[MetaDescription] [nvarchar](max) NOT NULL CONSTRAINT [DF_Category_MetaDescription]  DEFAULT (''),
	[SortOrder] [int] NOT NULL CONSTRAINT [DF_Category_SortOrder]  DEFAULT ((0)),
	[ShowDetail] [bit] NOT NULL CONSTRAINT [DF_Category_ShowDetail]  DEFAULT ((1)),
	[PageTitle] [nvarchar](max) NOT NULL CONSTRAINT [DF_Category_PageTitle]  DEFAULT (''),
	[ContentManagerId] [uniqueidentifier] NULL,
	[DocumentManagerId] [uniqueidentifier] NULL,
	[ERPProductValues] [nvarchar](max) NOT NULL CONSTRAINT [DF_Category_ERPValue]  DEFAULT (''),
	[IsFeatured] [tinyint] NOT NULL CONSTRAINT [DF_Category_IsFeatured]  DEFAULT ((0)),
	[IsDynamic] [tinyint] NOT NULL CONSTRAINT [DF_Category_IsDynamic]  DEFAULT ((0)),
	[RuleManagerId] [uniqueidentifier] NULL CONSTRAINT [DF_Category_RuleManager]  DEFAULT (NULL),
	[AltText] [nvarchar](max) NOT NULL CONSTRAINT [DF_Category_AltText]  DEFAULT (''),
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CategoryFilterSection]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoryFilterSection](
	[CategoryFilterSectionId] [uniqueidentifier] NOT NULL,
	[CategoryId] [uniqueidentifier] NOT NULL,
	[FilterSectionId] [uniqueidentifier] NOT NULL,
	[SortOrder] [int] NOT NULL,
	[IsActive] [tinyint] NOT NULL,
	[DetailDisplaySequence] [int] NULL,
 CONSTRAINT [PK_CategoryFilterSection_1] PRIMARY KEY CLUSTERED 
(
	[CategoryFilterSectionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CategoryFilterValue]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoryFilterValue](
	[CategoryId] [uniqueidentifier] NOT NULL,
	[FilterValueId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_CategoryFilterValue] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC,
	[FilterValueId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CategoryProduct]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoryProduct](
	[CategoryId] [uniqueidentifier] NOT NULL,
	[ProductId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_CategoryProduct] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC,
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CategoryProductCrossSell]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoryProductCrossSell](
	[CategoryId] [uniqueidentifier] NOT NULL,
	[ProductId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_CategoryProductCrossSell] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC,
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CategoryProperty]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoryProperty](
	[CategoryPropertyId] [uniqueidentifier] NOT NULL,
	[CategoryId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Value] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_CategoryProperty_1] PRIMARY KEY CLUSTERED 
(
	[CategoryPropertyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CategorySpecification]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategorySpecification](
	[CategoryId] [uniqueidentifier] NOT NULL,
	[SpecificationId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_CategorySpecification] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC,
	[SpecificationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CategoryTaxExemption]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoryTaxExemption](
	[CategoryId] [uniqueidentifier] NOT NULL,
	[TaxExemptionId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_CategoryTaxExemption] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC,
	[TaxExemptionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[City]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[City](
	[CityId] [uniqueidentifier] NOT NULL,
	[CountyId] [uniqueidentifier] NOT NULL,
	[CityName] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_City] PRIMARY KEY CLUSTERED 
(
	[CityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Company]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Company](
	[CompanyId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Company_CompanyId]  DEFAULT (newsequentialid()),
	[Name] [nvarchar](100) NOT NULL CONSTRAINT [DF_Company_Name]  DEFAULT (''),
	[Address] [nvarchar](100) NOT NULL CONSTRAINT [DF_Company_Address]  DEFAULT (''),
	[City] [nvarchar](100) NOT NULL CONSTRAINT [DF_Company_City]  DEFAULT (''),
	[State] [nvarchar](50) NOT NULL CONSTRAINT [DF_Company_State]  DEFAULT (''),
	[Zip] [nvarchar](50) NOT NULL CONSTRAINT [DF_Company_Zip]  DEFAULT (''),
	[Country] [nvarchar](128) NOT NULL CONSTRAINT [DF_Company_Country]  DEFAULT (''),
	[Image] [nvarchar](128) NOT NULL CONSTRAINT [DF_Company_Image]  DEFAULT (''),
	[Phone] [nvarchar](50) NOT NULL CONSTRAINT [DF_Company_Telephone]  DEFAULT (''),
	[Fax] [nvarchar](50) NOT NULL CONSTRAINT [DF_Company_Fax]  DEFAULT (''),
	[TollFreePhone] [nvarchar](50) NOT NULL CONSTRAINT [DF_Company_TollFreeTelephone]  DEFAULT (''),
	[LeftNavigation] [nvarchar](50) NOT NULL CONSTRAINT [DF_Company_LeftNavigation]  DEFAULT (''),
	[BottomNavigation] [nvarchar](50) NOT NULL CONSTRAINT [DF_Company_BottomNavigation]  DEFAULT (''),
	[RightNavigation] [nvarchar](50) NOT NULL CONSTRAINT [DF_Company_RightNavigation]  DEFAULT (''),
	[TopNavigation] [nvarchar](50) NOT NULL CONSTRAINT [DF_Company_TopNavigation]  DEFAULT (''),
	[ReplaceLogoImage] [tinyint] NOT NULL CONSTRAINT [DF_Company_ReplaceImage]  DEFAULT ((0)),
	[WebSiteId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Company] PRIMARY KEY CLUSTERED 
(
	[CompanyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Configuration]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Configuration](
	[ConfigurationId] [uniqueidentifier] NOT NULL,
	[Revision] [nvarchar](50) NOT NULL,
	[HasSmartPart] [tinyint] NOT NULL,
	[SmartPartSeparator] [nvarchar](10) NOT NULL,
	[SmartPartPrefix] [nvarchar](50) NOT NULL,
	[ScriptOnInitialize] [nvarchar](max) NOT NULL,
	[ScriptOnFinalize] [nvarchar](max) NOT NULL,
	[OverrideOnRefresh] [tinyint] NOT NULL,
	[DisplaySummary] [tinyint] NOT NULL,
	[ScriptOnPricingRequest] [nvarchar](max) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_Configuration] PRIMARY KEY CLUSTERED 
(
	[ConfigurationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ConfigurationConditionFilter]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConfigurationConditionFilter](
	[ConfigurationConditionFilterId] [uniqueidentifier] NOT NULL,
	[ConfigurationOptionConditionId] [uniqueidentifier] NOT NULL,
	[Sequence] [int] NOT NULL,
	[ColumnName] [nvarchar](255) NOT NULL,
	[Condition] [nvarchar](50) NOT NULL,
	[ValueFrom] [nvarchar](50) NOT NULL,
	[FilterValue] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ConfigurationConditionFilter] PRIMARY KEY CLUSTERED 
(
	[ConfigurationConditionFilterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ConfigurationOption]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConfigurationOption](
	[ConfigurationOptionId] [uniqueidentifier] NOT NULL,
	[ParentId] [uniqueidentifier] NULL,
	[ConfigurationPageId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](255) NOT NULL,
	[Sequence] [int] NOT NULL,
	[Type] [nvarchar](100) NOT NULL,
	[IsVisible] [tinyint] NOT NULL,
	[IsRequired] [tinyint] NOT NULL,
	[SetAsFutureDefault] [tinyint] NOT NULL,
	[XPosition] [int] NOT NULL,
	[YPosition] [int] NOT NULL,
	[Height] [int] NOT NULL,
	[Width] [int] NOT NULL,
	[LabelValue] [nvarchar](255) NOT NULL,
	[IncludeInLineDescription] [tinyint] NOT NULL,
	[ToolTip] [nvarchar](255) NOT NULL,
	[DefaultValue] [nvarchar](255) NOT NULL,
	[TextMinLength] [int] NOT NULL,
	[TextMaxLength] [int] NOT NULL,
	[TextCharacterType] [nvarchar](100) NOT NULL,
	[TextIsMultiline] [tinyint] NOT NULL,
	[TextValidEntryList] [nvarchar](max) NOT NULL,
	[NumberMinValue] [decimal](19, 5) NOT NULL,
	[NumberMaxValue] [decimal](19, 5) NOT NULL,
	[NumberDecimals] [decimal](19, 5) NOT NULL,
	[DateCheckRange] [tinyint] NOT NULL,
	[DateMaxDaysBack] [tinyint] NOT NULL,
	[DateMaxDaysForward] [tinyint] NOT NULL,
	[ContainerFileType] [nvarchar](100) NOT NULL,
	[ContainerFileLocation] [nvarchar](1000) NOT NULL,
	[RadioButtonOrientation] [nvarchar](100) NOT NULL,
	[ComboConditionalList] [tinyint] NOT NULL,
	[ComboMultiSelect] [tinyint] NOT NULL,
	[ComboIsProduct] [tinyint] NOT NULL,
	[ComboProductSeparateLine] [tinyint] NOT NULL,
	[ComboProductDescription] [nvarchar](100) NOT NULL,
	[ComboProductPriceSeparately] [tinyint] NOT NULL,
	[SelectionListDisplays] [nvarchar](max) NOT NULL,
	[SelectionListValues] [nvarchar](max) NOT NULL,
	[SelectionListPriceAdjustment] [nvarchar](max) NOT NULL,
	[SubconfigurationPartNumber] [nvarchar](100) NOT NULL,
	[SmartPartSegment] [nvarchar](255) NOT NULL,
	[SmartPartLength] [int] NOT NULL,
	[ScriptPromptWhen] [nvarchar](max) NOT NULL,
	[ScriptOnEntry] [nvarchar](max) NOT NULL,
	[ScriptOnLeave] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_ConfigurationOption] PRIMARY KEY CLUSTERED 
(
	[ConfigurationOptionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ConfigurationOptionCondition]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConfigurationOptionCondition](
	[ConfigurationOptionConditionId] [uniqueidentifier] NOT NULL,
	[ConfigurationOptionId] [uniqueidentifier] NOT NULL,
	[Sequence] [int] NOT NULL,
	[ScriptConditionOriginal] [nvarchar](max) NOT NULL,
	[ScriptCondition] [nvarchar](max) NOT NULL,
	[QueryName] [nvarchar](50) NOT NULL,
	[QueryDisplayField] [nvarchar](50) NOT NULL,
	[QueryInputField] [nvarchar](50) NOT NULL,
	[SelectionListValues] [nvarchar](max) NOT NULL,
	[SelectionListDisplays] [nvarchar](max) NOT NULL,
	[SelectionListPriceAdjustment] [nvarchar](max) NOT NULL,
	[DefaultValue] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ConfigurationOptionCondition] PRIMARY KEY CLUSTERED 
(
	[ConfigurationOptionConditionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ConfigurationPage]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConfigurationPage](
	[ConfigurationPageId] [uniqueidentifier] NOT NULL,
	[ConfigurationId] [uniqueidentifier] NOT NULL,
	[PageNumber] [int] NOT NULL,
	[PageTitle] [nvarchar](255) NOT NULL,
	[SkipIfNoInputs] [tinyint] NOT NULL,
	[SkipScriptsIfNoInputs] [tinyint] NOT NULL,
	[ScriptPromptWhen] [nvarchar](max) NOT NULL,
	[ScriptOnEntry] [nvarchar](max) NOT NULL,
	[ScriptPassFail] [nvarchar](max) NOT NULL,
	[ScriptOnLeave] [nvarchar](max) NOT NULL,
	[HtmlOutput] [nvarchar](max) NOT NULL,
	[OverrideHtmlOutput] [tinyint] NOT NULL,
	[CssOutput] [nvarchar](max) NOT NULL,
	[OverrideCssOutput] [tinyint] NOT NULL,
	[JavaScriptOutput] [nvarchar](max) NOT NULL,
	[OverrideJavaScriptOutput] [tinyint] NOT NULL,
 CONSTRAINT [PK_ConfigurationPage] PRIMARY KEY CLUSTERED 
(
	[ConfigurationPageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ConfigurationQueryResult]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConfigurationQueryResult](
	[ConfigurationQueryResultId] [uniqueidentifier] NOT NULL,
	[QueryName] [nvarchar](255) NOT NULL,
	[ResultDataset] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_ConfigurationQueryResults] PRIMARY KEY CLUSTERED 
(
	[ConfigurationQueryResultId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ConfigurationQueryResultField]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConfigurationQueryResultField](
	[ConfigurationQueryResultFieldId] [uniqueidentifier] NOT NULL,
	[ConfigurationQueryResultId] [uniqueidentifier] NOT NULL,
	[DisplayField] [nvarchar](100) NULL,
	[FieldLabel] [nvarchar](100) NULL,
 CONSTRAINT [PK_ConfigurationQueryResultField] PRIMARY KEY CLUSTERED 
(
	[ConfigurationQueryResultFieldId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ConfigurationQueryResultValue]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConfigurationQueryResultValue](
	[ConfigurationQueryResultValueId] [uniqueidentifier] NOT NULL,
	[ConfigurationQueryResultId] [uniqueidentifier] NOT NULL,
	[ResultXml] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_ConfigurationQueryResultValue] PRIMARY KEY CLUSTERED 
(
	[ConfigurationQueryResultValueId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Content]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Content](
	[ContentId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Content_ContentId]  DEFAULT (newsequentialid()),
	[ContentManagerId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](100) NOT NULL CONSTRAINT [DF_Content_Name]  DEFAULT (''),
	[Type] [nvarchar](50) NOT NULL CONSTRAINT [DF_Content_Type]  DEFAULT (''),
	[Html] [nvarchar](max) NOT NULL CONSTRAINT [DF_Content_HTML]  DEFAULT (''),
	[SubmittedForApproval] [datetime] NULL,
	[Approved] [datetime] NULL,
	[PublishToProduction] [datetime] NULL,
	[Created] [datetime] NOT NULL CONSTRAINT [DF_Content_Created]  DEFAULT (getdate()),
	[CreatedById] [uniqueidentifier] NULL,
	[ApprovedById] [uniqueidentifier] NULL,
	[Revision] [int] NOT NULL CONSTRAINT [DF_Content_Revision]  DEFAULT ((0)),
	[LanguageCode] [nvarchar](50) NOT NULL CONSTRAINT [DF_Content_LanguageCode]  DEFAULT (''),
	[DeviceType] [nvarchar](50) NOT NULL CONSTRAINT [DF_Content_DeviceType]  DEFAULT (''),
	[PersonaId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Content] PRIMARY KEY CLUSTERED 
(
	[ContentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ContentItem]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContentItem](
	[ContentItemId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_ContentItem_ContentItemId]  DEFAULT (newsequentialid()),
	[Class] [nvarchar](50) NOT NULL CONSTRAINT [DF_ContentItem_Type]  DEFAULT (''),
	[ContentKey] [int] NOT NULL,
	[ParentContentKey] [int] NULL,
	[PageContentKey] [int] NOT NULL,
	[Path] [nvarchar](500) NOT NULL CONSTRAINT [DF_ContentItem_Path]  DEFAULT (''),
	[Depth] [int] NOT NULL CONSTRAINT [DF_ContentItem_Depth]  DEFAULT ((0)),
	[Zone] [nvarchar](100) NOT NULL CONSTRAINT [DF_ContentItem_Zone]  DEFAULT (''),
	[IsPage] [tinyint] NOT NULL CONSTRAINT [DF_ContentItem_IsPage]  DEFAULT ((0)),
	[SortOrder] [int] NOT NULL CONSTRAINT [DF_ContentItem_SortOrder]  DEFAULT ((0)),
	[PublishOn] [datetime] NULL,
	[WebSiteId] [uniqueidentifier] NULL,
	[ApprovedOn] [datetime] NULL,
	[SubmittedForApprovalOn] [datetime] NULL,
	[CreatedOn] [datetime] NOT NULL CONSTRAINT [DF_ContentItem_CreatedOn]  DEFAULT (getdate()),
	[CreatedById] [uniqueidentifier] NOT NULL,
	[ApprovedById] [uniqueidentifier] NULL,
	[IsRetracted] [bit] NOT NULL CONSTRAINT [DF_ContentItem_IsRetracted]  DEFAULT ((0)),
	[Name] [nvarchar](50) NOT NULL CONSTRAINT [DF_ContentItem_Name]  DEFAULT (''),
	[LinkedToContentKey] [int] NULL,
	[SyncLinkedToChildren] [bit] NOT NULL CONSTRAINT [DF_ContentItem_LinkChildren]  DEFAULT ((0)),
	[IsTemplate] [bit] NOT NULL CONSTRAINT [DF_ContentItem_IsTemplate]  DEFAULT ((0)),
	[TemplateContentKey] [int] NULL,
	[TemplateView] [nvarchar](100) NOT NULL CONSTRAINT [DF_ContentItem_TemplateView]  DEFAULT (''),
 CONSTRAINT [PK_ContentItem] PRIMARY KEY CLUSTERED 
(
	[ContentItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ContentItemField]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ContentItemField](
	[ContentItemFieldId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_ContentItemField_ContentItemFieldId]  DEFAULT (newsequentialid()),
	[ContentKey] [int] NOT NULL,
	[LanguageId] [uniqueidentifier] NULL,
	[PersonaId] [uniqueidentifier] NULL,
	[DeviceType] [nvarchar](50) NOT NULL CONSTRAINT [DF_ContentItemField_DeviceType]  DEFAULT (''),
	[FieldType] [nvarchar](50) NOT NULL CONSTRAINT [DF_ContentItemField_FieldType]  DEFAULT (''),
	[FieldName] [nvarchar](100) NOT NULL CONSTRAINT [DF_ContentItemField_FieldName]  DEFAULT (''),
	[DateTimeValue] [datetime] NULL,
	[DecimalValue] [decimal](18, 6) NULL,
	[IntValue] [int] NULL,
	[StringValue] [nvarchar](max) NULL,
	[BooleanValue] [bit] NULL,
	[ObjectValue] [varbinary](max) NULL,
	[PublishOn] [datetime] NULL,
	[ApprovedOn] [datetime] NULL,
	[SubmittedForApprovalOn] [datetime] NULL,
	[CreatedOn] [datetime] NOT NULL CONSTRAINT [DF_ContentItemField_CreatedOn]  DEFAULT (getdate()),
	[CreatedById] [uniqueidentifier] NOT NULL,
	[ApprovedById] [uniqueidentifier] NULL,
	[IsRetracted] [bit] NOT NULL CONSTRAINT [DF_ContentItemField_IsRetracted]  DEFAULT ((0)),
 CONSTRAINT [PK_ContentItemField] PRIMARY KEY CLUSTERED 
(
	[ContentItemFieldId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ContentManager]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContentManager](
	[ContentManagerId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_ContentManager_ContentManagerId]  DEFAULT (newsequentialid()),
	[Name] [nvarchar](100) NOT NULL CONSTRAINT [DF_ContentManager_Name]  DEFAULT (''),
 CONSTRAINT [PK_ContentManager] PRIMARY KEY CLUSTERED 
(
	[ContentManagerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ContentPageState]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContentPageState](
	[ContentPageStateId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_ContentPageState_ContentPageStateId]  DEFAULT (newsequentialid()),
	[WebsiteId] [uniqueidentifier] NOT NULL,
	[ContentKey] [int] NOT NULL,
	[ParentContentKey] [int] NULL,
	[LinkedToContentKey] [int] NULL,
	[Name] [nvarchar](50) NOT NULL CONSTRAINT [DF_ContentPageState_Name]  DEFAULT (''),
	[Path] [nvarchar](500) NOT NULL CONSTRAINT [DF_ContentPageState_Path]  DEFAULT (''),
	[SortOrder] [int] NOT NULL CONSTRAINT [DF_ContentPageState_SortOrder]  DEFAULT ((0)),
	[LanguageId] [uniqueidentifier] NULL,
	[PersonaId] [uniqueidentifier] NULL,
	[DeviceType] [nvarchar](50) NULL,
	[PublishOn] [datetime] NULL,
	[FuturePublishOn] [datetime] NULL,
	[IsUnpublished] [bit] NOT NULL CONSTRAINT [DF_ContentPageState_IsUnpublished]  DEFAULT ((0)),
	[IsWaitingForApproval] [bit] NOT NULL CONSTRAINT [DF_ContentPageState_IsWaitingForApproval]  DEFAULT ((0)),
	[IsRetracted] [bit] NOT NULL CONSTRAINT [DF_ContentPageState_IsRetracted]  DEFAULT ((0)),
 CONSTRAINT [PK_ContentPageState] PRIMARY KEY CLUSTERED 
(
	[ContentPageStateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Country]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Country](
	[CountryId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Country_CountryId]  DEFAULT (newsequentialid()),
	[Name] [nvarchar](100) NOT NULL CONSTRAINT [DF_Country_Name]  DEFAULT (''),
	[Abbreviation] [nvarchar](32) NOT NULL CONSTRAINT [DF_Country_Abbreviation]  DEFAULT (''),
	[IsActive] [tinyint] NOT NULL CONSTRAINT [DF_Country_IsActive]  DEFAULT ((0)),
	[ISOCode2] [nvarchar](50) NOT NULL CONSTRAINT [DF_Country_ISOCode2]  DEFAULT (''),
	[ISOCode3] [nvarchar](50) NOT NULL CONSTRAINT [DF_Country_ISOCode3]  DEFAULT (''),
	[ISONumber] [nvarchar](50) NOT NULL CONSTRAINT [DF_Country_ISONumber]  DEFAULT (''),
	[DistanceUnitOfMeasure] [nvarchar](50) NOT NULL CONSTRAINT [DF_Country_DistanceUnitOfMeasure]  DEFAULT ('Imperial'),
 CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED 
(
	[CountryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[County]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[County](
	[CountyId] [uniqueidentifier] NOT NULL,
	[StateId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Abbreviation] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_County] PRIMARY KEY CLUSTERED 
(
	[CountyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CreditCardTransaction]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CreditCardTransaction](
	[CreditCardTransactionId] [uniqueidentifier] NOT NULL,
	[CustomerOrderId] [uniqueidentifier] NULL,
	[TransactionType] [nvarchar](50) NOT NULL,
	[TransactionDate] [datetime] NOT NULL,
	[Result] [nvarchar](50) NOT NULL,
	[AuthCode] [nvarchar](200) NOT NULL,
	[PNRef] [nvarchar](100) NOT NULL,
	[RespMsg] [nvarchar](1024) NOT NULL,
	[RespText] [nvarchar](1024) NOT NULL,
	[AVSAddr] [nvarchar](250) NOT NULL,
	[AVSZip] [nvarchar](50) NOT NULL,
	[CVV2Match] [nvarchar](50) NOT NULL,
	[RequestId] [nvarchar](50) NOT NULL,
	[RequestString] [nvarchar](max) NOT NULL,
	[ResponseString] [nvarchar](max) NOT NULL,
	[Amount] [decimal](19, 5) NOT NULL,
	[Status] [nvarchar](50) NOT NULL,
	[CreditCardNumber] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[ExpirationDate] [nvarchar](50) NOT NULL,
	[OrderNumber] [nvarchar](50) NOT NULL,
	[ShipmentNumber] [nvarchar](50) NOT NULL,
	[CustomerNumber] [nvarchar](50) NOT NULL,
	[Site] [nvarchar](50) NOT NULL,
	[OrigId] [nvarchar](100) NOT NULL,
	[BankCode] [nvarchar](50) NOT NULL,
	[Token1] [nvarchar](200) NULL,
	[Token2] [nvarchar](200) NULL,
	[CardType] [nvarchar](200) NOT NULL,
	[PostedToERP] [tinyint] NOT NULL,
	[InvoiceNumber] [nvarchar](50) NOT NULL,
	[CurrencyId] [uniqueidentifier] NULL,
	[CurrencyAmount] [decimal](18, 5) NULL,
 CONSTRAINT [PK_CreditCardTransaction] PRIMARY KEY CLUSTERED 
(
	[CreditCardTransactionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Currency]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Currency](
	[CurrencyId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Currency_CurrencyId]  DEFAULT (newsequentialid()),
	[CurrencyCode] [nvarchar](50) NOT NULL CONSTRAINT [DF_Currency_CurrencyCode]  DEFAULT (''),
	[Description] [nvarchar](255) NOT NULL CONSTRAINT [DF_Currency_Description]  DEFAULT (''),
	[CurrencySymbol] [nvarchar](50) NOT NULL CONSTRAINT [DF_Currency_CurrencySymbol]  DEFAULT (''),
	[IsDefault] [tinyint] NOT NULL CONSTRAINT [DF_Currency_IsDefault]  DEFAULT ((0)),
 CONSTRAINT [PK_Currency] PRIMARY KEY CLUSTERED 
(
	[CurrencyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CurrencyRate]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CurrencyRate](
	[CurrencyRateId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_CurrencyRate_CurrencyRateId]  DEFAULT (newsequentialid()),
	[CurrencyId] [uniqueidentifier] NOT NULL,
	[EffectiveDate] [datetime] NOT NULL CONSTRAINT [DF_CurrencyRate_EffectiveDate]  DEFAULT (getdate()),
	[ConversionRate] [decimal](18, 5) NOT NULL CONSTRAINT [DF_CurrencyRate_ConversionRate]  DEFAULT ((0)),
 CONSTRAINT [PK_CurrencyRate] PRIMARY KEY CLUSTERED 
(
	[CurrencyRateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Customer]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[CustomerId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Customer_CustomerId]  DEFAULT (newsequentialid()),
	[ParentId] [uniqueidentifier] NULL,
	[CustomerNumber] [nvarchar](50) NOT NULL CONSTRAINT [DF_Customer_CustomerNumber]  DEFAULT (''),
	[CustomerSequence] [nvarchar](50) NOT NULL CONSTRAINT [DF_Customer_CustomerSequence]  DEFAULT (''),
	[CustomerType] [nvarchar](50) NOT NULL CONSTRAINT [DF_Customer_CustomerType]  DEFAULT (''),
	[Company] [nvarchar](100) NOT NULL CONSTRAINT [DF_Customer_Company]  DEFAULT (''),
	[Contact1] [nvarchar](100) NOT NULL CONSTRAINT [DF_Customer_Contact]  DEFAULT (''),
	[Contact2] [nvarchar](100) NOT NULL CONSTRAINT [DF_Customer_Contact2]  DEFAULT (''),
	[Contact3] [nvarchar](100) NOT NULL CONSTRAINT [DF_Customer_Contact3]  DEFAULT (''),
	[FirstName] [nvarchar](100) NOT NULL CONSTRAINT [DF_Customer_FirstName]  DEFAULT (''),
	[MiddleName] [nvarchar](100) NOT NULL CONSTRAINT [DF_Customer_MiddleName]  DEFAULT (''),
	[LastName] [nvarchar](100) NOT NULL CONSTRAINT [DF_Customer_LastName]  DEFAULT (''),
	[Phone1] [nvarchar](50) NOT NULL CONSTRAINT [DF_Customer_Phone1]  DEFAULT (''),
	[Phone2] [nvarchar](50) NOT NULL CONSTRAINT [DF_Customer_Phone2]  DEFAULT (''),
	[Phone3] [nvarchar](50) NOT NULL CONSTRAINT [DF_Customer_Phone3]  DEFAULT (''),
	[Fax] [nvarchar](50) NOT NULL CONSTRAINT [DF_Customer_Fax]  DEFAULT (''),
	[TermsCode] [nvarchar](50) NOT NULL CONSTRAINT [DF_Customer_TermsCode]  DEFAULT (''),
	[ShipCode] [nvarchar](50) NOT NULL CONSTRAINT [DF_Customer_ShipCode]  DEFAULT (''),
	[BankCode] [nvarchar](50) NOT NULL CONSTRAINT [DF_Customer_BankCode]  DEFAULT (''),
	[TaxCode1] [nvarchar](50) NOT NULL CONSTRAINT [DF_Customer_TaxCode1]  DEFAULT (''),
	[TaxCode2] [nvarchar](50) NOT NULL CONSTRAINT [DF_Customer_TaxCode2]  DEFAULT (''),
	[PriceCode] [nvarchar](50) NOT NULL CONSTRAINT [DF_Customer_PriceCode]  DEFAULT (''),
	[CurrencyCode] [nvarchar](50) NOT NULL CONSTRAINT [DF_Customer_CurrencyCode]  DEFAULT (''),
	[EndUserType] [nvarchar](50) NOT NULL CONSTRAINT [DF_Customer_EndUserType]  DEFAULT (''),
	[ShipSite] [nvarchar](50) NOT NULL CONSTRAINT [DF_Customer_ShipSite]  DEFAULT (''),
	[Warehouse] [nvarchar](50) NOT NULL CONSTRAINT [DF_Customer_Warehouse]  DEFAULT (''),
	[Salesman] [nvarchar](50) NOT NULL CONSTRAINT [DF_Customer_Salesman]  DEFAULT (''),
	[InvoiceFrequency] [nvarchar](50) NOT NULL CONSTRAINT [DF_Customer_InvoiceFrequency]  DEFAULT (''),
	[ShipEarly] [tinyint] NOT NULL CONSTRAINT [DF_Customer_ShipEarly]  DEFAULT ((1)),
	[ShipPartial] [tinyint] NOT NULL CONSTRAINT [DF_Customer_ShipPartial]  DEFAULT ((1)),
	[Address1] [nvarchar](100) NOT NULL CONSTRAINT [DF_Customer_Address1]  DEFAULT (''),
	[Address2] [nvarchar](100) NOT NULL CONSTRAINT [DF_Customer_Address2]  DEFAULT (''),
	[Address3] [nvarchar](100) NOT NULL CONSTRAINT [DF_Customer_Address3]  DEFAULT (''),
	[Address4] [nvarchar](100) NOT NULL CONSTRAINT [DF_Customer_Address4]  DEFAULT (''),
	[City] [nvarchar](100) NOT NULL CONSTRAINT [DF_Customer_City]  DEFAULT (''),
	[State] [nvarchar](50) NOT NULL CONSTRAINT [DF_Customer_State]  DEFAULT (''),
	[Zip] [nvarchar](50) NOT NULL CONSTRAINT [DF_Customer_Zip]  DEFAULT (''),
	[County] [nvarchar](100) NOT NULL CONSTRAINT [DF_Customer_County]  DEFAULT (''),
	[Country] [nvarchar](100) NOT NULL CONSTRAINT [DF_Customer_Country]  DEFAULT (''),
	[CreditHold] [tinyint] NOT NULL CONSTRAINT [DF_Customer_CreditHold]  DEFAULT ((0)),
	[CreditLimit] [money] NOT NULL CONSTRAINT [DF_Customer_CreditLimit]  DEFAULT ((0)),
	[Email] [nvarchar](256) NOT NULL CONSTRAINT [DF_Customer_ShipToEmail]  DEFAULT (''),
	[TermsOfUse] [nvarchar](max) NOT NULL CONSTRAINT [DF_Customer_TermsOfUse]  DEFAULT (''),
	[CustomerReferenceLabel1] [nvarchar](50) NOT NULL CONSTRAINT [DF_Customer_CustomerReferenceLabel1]  DEFAULT (''),
	[CustomerReferenceLabel2] [nvarchar](50) NOT NULL CONSTRAINT [DF_Customer_CustomerReferenceLabel2]  DEFAULT (''),
	[Distance] [decimal](18, 5) NOT NULL CONSTRAINT [DF_Customer_Distance]  DEFAULT ((0.00)),
	[Discount] [decimal](18, 5) NOT NULL CONSTRAINT [DF_Customer_Discount]  DEFAULT ((0)),
	[SendEmail] [tinyint] NOT NULL CONSTRAINT [DF_Customer_SendEmail]  DEFAULT ((0)),
	[SendFax] [tinyint] NOT NULL CONSTRAINT [DF_Customer_SendFax]  DEFAULT ((0)),
	[CompanyId] [uniqueidentifier] NULL,
	[Image] [nvarchar](100) NOT NULL CONSTRAINT [DF_Customer_Image]  DEFAULT (''),
	[IsActive] [tinyint] NOT NULL CONSTRAINT [DF_Customer_Active]  DEFAULT ((1)),
	[Directory] [nvarchar](max) NOT NULL CONSTRAINT [DF_Customer_Directory]  DEFAULT (''),
	[OpenInvoiceAmount] [decimal](18, 5) NOT NULL CONSTRAINT [DF_Customer_OpenInvoiceAmount]  DEFAULT ((0)),
	[OpenOrderAmount] [decimal](18, 5) NOT NULL CONSTRAINT [DF_Customer_OpenOrderAmount]  DEFAULT ((0)),
	[AllowDropShip] [tinyint] NOT NULL CONSTRAINT [DF_Customer_AllowDropShip]  DEFAULT ((0)),
	[DropShipFeeRequired] [tinyint] NOT NULL CONSTRAINT [DF_Customer_DropShipFeeRequired]  DEFAULT ((0)),
	[AgingBucket1] [decimal](18, 5) NOT NULL CONSTRAINT [DF_Customer_AgingBucket1]  DEFAULT ((0)),
	[AgingBucket2] [decimal](18, 5) NOT NULL CONSTRAINT [DF_Customer_AgingBucket2]  DEFAULT ((0)),
	[AgingBucket3] [decimal](18, 5) NOT NULL CONSTRAINT [DF_Customer_AgingBucket3]  DEFAULT ((0)),
	[AgingBucket4] [decimal](18, 5) NOT NULL CONSTRAINT [DF_Customer_AgingBucket4]  DEFAULT ((0)),
	[AgingBucket5] [decimal](18, 5) NOT NULL CONSTRAINT [DF_Customer_AgingBucket5]  DEFAULT ((0)),
	[IsDropShip] [tinyint] NOT NULL CONSTRAINT [DF_Customer_IsDropShip]  DEFAULT ((0)),
	[StateId] [uniqueidentifier] NULL,
	[CountryId] [uniqueidentifier] NULL,
	[IsGuest] [tinyint] NOT NULL CONSTRAINT [DF_Customer_IsGuest]  DEFAULT ((0)),
	[ERPNumber] [nvarchar](50) NOT NULL CONSTRAINT [DF_Customer_ERPNumber]  DEFAULT (''),
	[Territory] [nvarchar](100) NOT NULL CONSTRAINT [DF_Customer_Territory]  DEFAULT (''),
	[BudgetEnforcementLevel] [nvarchar](50) NOT NULL CONSTRAINT [DF_Customer_BudgetEnforcementLevel]  DEFAULT ('None'),
	[CostCodeDescription] [nvarchar](100) NOT NULL CONSTRAINT [DF_Customer_CostCodeDescription]  DEFAULT (''),
	[DefaultCostCode] [nvarchar](100) NOT NULL CONSTRAINT [DF_Customer_DefaultCostCode]  DEFAULT (''),
	[IgnoreProductRestrictions] [tinyint] NOT NULL CONSTRAINT [DF_CustomerUserProfile_IgnoreProductRestrictions]  DEFAULT ((0)),
	[ERPSequence] [nvarchar](50) NOT NULL CONSTRAINT [DF_Customer_ERPSequence]  DEFAULT (''),
	[PricingCustomerId] [uniqueidentifier] NULL,
	[ModifyDate] [datetime] NOT NULL CONSTRAINT [DF_Customer_ModifyDate]  DEFAULT (getdate()),
	[CurrencyId] [uniqueidentifier] NULL,
	[CustomLandingPage] [nvarchar](max) NULL CONSTRAINT [DF_Customer_CustomLandingPage]  DEFAULT (''),
	[PrimarySalesmanId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CustomerBudget]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerBudget](
	[CustomerBudgetId] [uniqueidentifier] NOT NULL,
	[CustomerId] [uniqueidentifier] NOT NULL,
	[ShipToCustomerId] [uniqueidentifier] NULL,
	[UserProfileId] [uniqueidentifier] NULL,
	[FiscalYear] [int] NOT NULL,
	[Period1Budget] [decimal](18, 0) NULL,
	[Period2Budget] [decimal](18, 0) NULL,
	[Period3Budget] [decimal](18, 0) NULL,
	[Period4Budget] [decimal](18, 0) NULL,
	[Period5Budget] [decimal](18, 0) NULL,
	[Period6Budget] [decimal](18, 0) NULL,
	[Period7Budget] [decimal](18, 0) NULL,
	[Period8Budget] [decimal](18, 0) NULL,
	[Period9Budget] [decimal](18, 0) NULL,
	[Period10Budget] [decimal](18, 0) NULL,
	[Period11Budget] [decimal](18, 0) NULL,
	[Period12Budget] [decimal](18, 0) NULL,
	[Period13Budget] [decimal](18, 0) NULL,
	[Period1Actual] [decimal](18, 0) NULL,
	[Period2Actual] [decimal](18, 0) NULL,
	[Period3Actual] [decimal](18, 0) NULL,
	[Period4Actual] [decimal](18, 0) NULL,
	[Period5Actual] [decimal](18, 0) NULL,
	[Period6Actual] [decimal](18, 0) NULL,
	[Period7Actual] [decimal](18, 0) NULL,
	[Period8Actual] [decimal](18, 0) NULL,
	[Period9Actual] [decimal](18, 0) NULL,
	[Period10Actual] [decimal](18, 0) NULL,
	[Period11Actual] [decimal](18, 0) NULL,
	[Period12Actual] [decimal](18, 0) NULL,
	[Period13Actual] [decimal](18, 0) NULL,
 CONSTRAINT [PK_CustomerBudget] PRIMARY KEY CLUSTERED 
(
	[CustomerBudgetId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CustomerCarrier]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerCarrier](
	[CustomerId] [uniqueidentifier] NOT NULL,
	[CarrierId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_CustomerCarrier] PRIMARY KEY CLUSTERED 
(
	[CustomerId] ASC,
	[CarrierId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CustomerCostCode]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerCostCode](
	[CustomerCostCodeId] [uniqueidentifier] NOT NULL,
	[CustomerId] [uniqueidentifier] NOT NULL,
	[CostCode] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](255) NOT NULL,
	[IsActive] [tinyint] NOT NULL,
 CONSTRAINT [PK_CustomerCostCode] PRIMARY KEY CLUSTERED 
(
	[CustomerCostCodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CustomerDiscount]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerDiscount](
	[CustomerDiscountId] [uniqueidentifier] NOT NULL,
	[CustomerId] [uniqueidentifier] NOT NULL,
	[WebSiteId] [uniqueidentifier] NOT NULL,
	[Discount] [decimal](18, 5) NOT NULL,
	[ApplyDiscount] [tinyint] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_CustomerDiscount] PRIMARY KEY CLUSTERED 
(
	[CustomerDiscountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CustomerOrder]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerOrder](
	[CustomerOrderId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_CustomerOrder_CustomerOrderId]  DEFAULT (newsequentialid()),
	[CustomerId] [uniqueidentifier] NOT NULL,
	[ShipToId] [uniqueidentifier] NOT NULL,
	[WebSiteId] [uniqueidentifier] NOT NULL,
	[Type] [nvarchar](50) NOT NULL CONSTRAINT [DF_CustomerOrder_Type]  DEFAULT ('Order'),
	[Status] [nvarchar](50) NOT NULL CONSTRAINT [DF_CustomerOrder_Status]  DEFAULT (''),
	[OrderNumber] [nvarchar](50) NOT NULL CONSTRAINT [DF_CustomerOrder_OrderNumber]  DEFAULT (''),
	[OrderDate] [datetime] NOT NULL CONSTRAINT [DF_Order_OrderDate]  DEFAULT (getdate()),
	[CustomerPO] [nvarchar](50) NOT NULL CONSTRAINT [DF_CustomerOrder_CustomerPO]  DEFAULT (''),
	[CustomerPOTypeCode] [nvarchar](50) NOT NULL CONSTRAINT [DF_CustomerOrder_CustomerPOTypeCode]  DEFAULT (''),
	[PriceCode] [nvarchar](50) NOT NULL CONSTRAINT [DF_CustomerOrder_PriceCode]  DEFAULT (''),
	[CurrencyCode] [nvarchar](50) NOT NULL CONSTRAINT [DF_CustomerOrder_CurrencyCode]  DEFAULT (''),
	[LanguageCode] [nvarchar](50) NOT NULL CONSTRAINT [DF_CustomerOrder_LanguageCode]  DEFAULT (''),
	[TermsCode] [nvarchar](50) NOT NULL CONSTRAINT [DF_CustomerOrder_TermsCode]  DEFAULT (''),
	[ShipCode] [nvarchar](50) NOT NULL CONSTRAINT [DF_CustomerOrder_ShipCode]  DEFAULT (''),
	[TaxCode1] [nvarchar](50) NOT NULL CONSTRAINT [DF_CustomerOrder_TaxCode1]  DEFAULT (''),
	[TaxCode2] [nvarchar](50) NOT NULL CONSTRAINT [DF_CustomerOrder_TaxCode2]  DEFAULT (''),
	[EndUserType] [nvarchar](50) NOT NULL CONSTRAINT [DF_CustomerOrder_EndUserType]  DEFAULT (''),
	[Warehouse] [nvarchar](50) NOT NULL CONSTRAINT [DF_CustomerOrder_Warehouse]  DEFAULT (''),
	[Salesman] [nvarchar](50) NOT NULL CONSTRAINT [DF_CustomerOrder_Salesman]  DEFAULT (''),
	[InvoiceFrequency] [nvarchar](50) NOT NULL CONSTRAINT [DF_CustomerOrder_InvoiceFrequency]  DEFAULT (''),
	[ShipEarly] [tinyint] NOT NULL CONSTRAINT [DF_CustomerOrder_ShipEarly]  DEFAULT ((1)),
	[ShipPartial] [tinyint] NOT NULL CONSTRAINT [DF_CustomerOrder_ShipPartial]  DEFAULT ((1)),
	[Notes] [nvarchar](max) NOT NULL CONSTRAINT [DF_CustomerOrder_Notes]  DEFAULT (''),
	[Shipping] [decimal](18, 5) NOT NULL CONSTRAINT [DF_CustomerOrder_Shipping]  DEFAULT ((0)),
	[Handling] [decimal](18, 5) NOT NULL CONSTRAINT [DF_CustomerOrder_Handling]  DEFAULT ((0)),
	[StateTax] [decimal](18, 5) NOT NULL CONSTRAINT [DF_CustomerOrder_StateTax]  DEFAULT ((0)),
	[LocalTax] [decimal](18, 5) NOT NULL CONSTRAINT [DF_CustomerOrder_LocalTax]  DEFAULT ((0)),
	[CustomerNumber] [nvarchar](50) NOT NULL,
	[CustomerSequence] [nvarchar](50) NOT NULL,
	[BTCompany] [nvarchar](100) NOT NULL CONSTRAINT [DF_CustomerOrder_BTCompany]  DEFAULT (''),
	[BTContact1] [nvarchar](100) NOT NULL CONSTRAINT [DF_CustomerOrder_BTContact1]  DEFAULT (''),
	[BTContact2] [nvarchar](100) NOT NULL CONSTRAINT [DF_CustomerOrder_BTContact2]  DEFAULT (''),
	[BTContact3] [nvarchar](100) NOT NULL CONSTRAINT [DF_CustomerOrder_BTContact3]  DEFAULT (''),
	[BTFirstName] [nvarchar](100) NOT NULL CONSTRAINT [DF_CustomerOrder_BTFirstName]  DEFAULT (''),
	[BTMiddleName] [nvarchar](100) NOT NULL CONSTRAINT [DF_CustomerOrder_BTMiddleName]  DEFAULT (''),
	[BTLastName] [nvarchar](100) NOT NULL CONSTRAINT [DF_CustomerOrder_BTLastName]  DEFAULT (''),
	[BTPhone1] [nvarchar](50) NOT NULL CONSTRAINT [DF_CustomerOrder_BTPhone1]  DEFAULT (''),
	[BTPhone2] [nvarchar](50) NOT NULL CONSTRAINT [DF_CustomerOrder_BTPhone2]  DEFAULT (''),
	[BTPhone3] [nvarchar](50) NOT NULL CONSTRAINT [DF_CustomerOrder_BTPhone3]  DEFAULT (''),
	[BTFax] [nvarchar](50) NOT NULL CONSTRAINT [DF_CustomerOrder_BTFax]  DEFAULT (''),
	[BTAddress1] [nvarchar](100) NOT NULL CONSTRAINT [DF_CustomerOrder_BTAddress1]  DEFAULT (''),
	[BTAddress2] [nvarchar](100) NOT NULL CONSTRAINT [DF_CustomerOrder_BTAddress2]  DEFAULT (''),
	[BTAddress3] [nvarchar](100) NOT NULL CONSTRAINT [DF_CustomerOrder_BTAddress3]  DEFAULT (''),
	[BTAddress4] [nvarchar](100) NOT NULL CONSTRAINT [DF_CustomerOrder_BTAddress4]  DEFAULT (''),
	[BTCity] [nvarchar](100) NOT NULL CONSTRAINT [DF_CustomerOrder_BTCity]  DEFAULT (''),
	[BTState] [nvarchar](50) NOT NULL CONSTRAINT [DF_CustomerOrder_BTState]  DEFAULT (''),
	[BTZip] [nvarchar](50) NOT NULL CONSTRAINT [DF_CustomerOrder_BTZip]  DEFAULT (''),
	[BTCounty] [nvarchar](100) NOT NULL CONSTRAINT [DF_CustomerOrder_BTCounty]  DEFAULT (''),
	[BTCountry] [nvarchar](100) NOT NULL CONSTRAINT [DF_CustomerOrder_BTCountry]  DEFAULT (''),
	[BTEmail] [nvarchar](100) NOT NULL CONSTRAINT [DF_CustomerOrder_BTEmail]  DEFAULT (''),
	[STCompany] [nvarchar](100) NOT NULL CONSTRAINT [DF_CustomerOrder_STCompany]  DEFAULT (''),
	[STContact1] [nvarchar](100) NOT NULL CONSTRAINT [DF_CustomerOrder_STContact1]  DEFAULT (''),
	[STContact2] [nvarchar](100) NOT NULL CONSTRAINT [DF_CustomerOrder_STContact2]  DEFAULT (''),
	[STContact3] [nvarchar](100) NOT NULL CONSTRAINT [DF_CustomerOrder_STContact3]  DEFAULT (''),
	[STFirstName] [nvarchar](100) NOT NULL CONSTRAINT [DF_CustomerOrder_STFirstName]  DEFAULT (''),
	[STMiddleName] [nvarchar](100) NOT NULL CONSTRAINT [DF_CustomerOrder_STMiddleName]  DEFAULT (''),
	[STLastName] [nvarchar](100) NOT NULL CONSTRAINT [DF_CustomerOrder_STLastName]  DEFAULT (''),
	[STPhone1] [nvarchar](50) NOT NULL CONSTRAINT [DF_CustomerOrder_STPhone1]  DEFAULT (''),
	[STPhone2] [nvarchar](50) NOT NULL CONSTRAINT [DF_CustomerOrder_STPhone2]  DEFAULT (''),
	[STPhone3] [nvarchar](50) NOT NULL CONSTRAINT [DF_CustomerOrder_STPhone3]  DEFAULT (''),
	[STFax] [nvarchar](50) NOT NULL CONSTRAINT [DF_CustomerOrder_STFax]  DEFAULT (''),
	[STAddress1] [nvarchar](100) NOT NULL CONSTRAINT [DF_CustomerOrder_STAddress1]  DEFAULT (''),
	[STAddress2] [nvarchar](100) NOT NULL CONSTRAINT [DF_CustomerOrder_STAddress2]  DEFAULT (''),
	[STAddress3] [nvarchar](100) NOT NULL CONSTRAINT [DF_CustomerOrder_STAddress3]  DEFAULT (''),
	[STAddress4] [nvarchar](100) NOT NULL CONSTRAINT [DF_CustomerOrder_STAddress4]  DEFAULT (''),
	[STCity] [nvarchar](100) NOT NULL CONSTRAINT [DF_CustomerOrder_STCity]  DEFAULT (''),
	[STState] [nvarchar](50) NOT NULL CONSTRAINT [DF_CustomerOrder_STState]  DEFAULT (''),
	[STZip] [nvarchar](50) NOT NULL CONSTRAINT [DF_CustomerOrder_STZip]  DEFAULT (''),
	[STCounty] [nvarchar](100) NOT NULL CONSTRAINT [DF_CustomerOrder_STCounty]  DEFAULT (''),
	[STCountry] [nvarchar](100) NOT NULL CONSTRAINT [DF_CustomerOrder_STCountry]  DEFAULT (''),
	[STEmail] [nvarchar](100) NOT NULL CONSTRAINT [DF_CustomerOrder_STEmail]  DEFAULT (''),
	[UserName] [nvarchar](256) NOT NULL CONSTRAINT [DF_CustomerOrder_UserName]  DEFAULT (''),
	[AffiliateId] [uniqueidentifier] NULL,
	[Residential] [tinyint] NOT NULL CONSTRAINT [DF_CustomerOrder_Residential]  DEFAULT ((0)),
	[InsideDelivery] [tinyint] NOT NULL CONSTRAINT [DF_CustomerOrder_InsideDelivery]  DEFAULT ((0)),
	[LiftGateService] [tinyint] NOT NULL CONSTRAINT [DF_CustomerOrder_LiftGateService]  DEFAULT ((0)),
	[DiscountAmount] [decimal](18, 5) NOT NULL CONSTRAINT [DF_CustomerOrder_DiscountAmount]  DEFAULT ((0)),
	[DiscountPercent] [decimal](18, 5) NOT NULL CONSTRAINT [DF_CustomerOrder_DiscountPercent]  DEFAULT ((0)),
	[CollectAccountNumber] [nvarchar](50) NOT NULL CONSTRAINT [DF_CustomerOrder_CollectAccountNumber]  DEFAULT (''),
	[ShipmentQuoteNumber] [nvarchar](50) NOT NULL CONSTRAINT [DF_CustomerOrder_ShipmentId]  DEFAULT (''),
	[CustomerReference1] [nvarchar](50) NOT NULL CONSTRAINT [DF_CustomerOrder_CustomerReference1]  DEFAULT (''),
	[CustomerReference2] [nvarchar](50) NOT NULL CONSTRAINT [DF_CustomerOrder_CustomerReference2]  DEFAULT (''),
	[ShipViaId] [uniqueidentifier] NULL,
	[DropShipId] [uniqueidentifier] NULL,
	[RequestedShipDate] [datetime] NULL,
	[Buyer] [nvarchar](100) NOT NULL CONSTRAINT [DF_CustomerOrder_Buyer]  DEFAULT (''),
	[BatchNumber] [int] NOT NULL CONSTRAINT [DF_CustomerOrder_BatchNumber]  DEFAULT ((0)),
	[SubscriptionId] [uniqueidentifier] NULL,
	[VerificationSent] [datetime] NULL,
	[ERPOrderNumber] [nvarchar](50) NOT NULL CONSTRAINT [DF_CustomerOrder_ERPOrderNumber]  DEFAULT (''),
	[InitiatedByUserProfileId] [uniqueidentifier] NULL,
	[ApproverUserProfileId] [uniqueidentifier] NULL,
	[ApproverMessage] [nvarchar](255) NOT NULL CONSTRAINT [DF_CustomerOrder_ApproverMessage]  DEFAULT (''),
	[CurrencyId] [uniqueidentifier] NULL,
	[ConversionRate] [decimal](18, 5) NULL CONSTRAINT [DF_CustomerOrder_ConversionRate]  DEFAULT ((0)),
	[QuoteExpirationDate] [datetime] NULL,
	[QuotedByUserProfileId] [uniqueidentifier] NULL,
	[PrimarySalesmanId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[CustomerOrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CustomerOrderGiftCard]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerOrderGiftCard](
	[CustomerOrderId] [uniqueidentifier] NOT NULL,
	[GiftCardId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_CustomerOrderGiftCard] PRIMARY KEY CLUSTERED 
(
	[CustomerOrderId] ASC,
	[GiftCardId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CustomerOrderPromotion]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerOrderPromotion](
	[CustomerOrderId] [uniqueidentifier] NOT NULL,
	[PromotionId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_CustomerOrderPromotion] PRIMARY KEY CLUSTERED 
(
	[CustomerOrderId] ASC,
	[PromotionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CustomerOrderProperty]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerOrderProperty](
	[CustomerOrderPropertyId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_CustomerOrderProperty_CustomerOrderPropertyId]  DEFAULT (newsequentialid()),
	[CustomerOrderId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Value] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_CustomerOrderProperty] PRIMARY KEY CLUSTERED 
(
	[CustomerOrderPropertyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CustomerProduct]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerProduct](
	[CustomerProductId] [uniqueidentifier] NOT NULL,
	[CustomerId] [uniqueidentifier] NOT NULL,
	[ProductId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[UnitOfMeasure] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_CustomerProduct] PRIMARY KEY CLUSTERED 
(
	[CustomerProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CustomerProductPrice]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerProductPrice](
	[CustomerProductPriceId] [uniqueidentifier] NOT NULL,
	[CustomerId] [uniqueidentifier] NOT NULL,
	[ProductId] [uniqueidentifier] NOT NULL,
	[BreakQty] [decimal](18, 5) NOT NULL,
	[Price] [decimal](18, 5) NOT NULL,
	[Active] [datetime] NOT NULL,
	[Deactivate] [datetime] NULL,
	[PricePerPiece] [decimal](18, 5) NOT NULL,
	[IsOnSale] [tinyint] NOT NULL,
	[SalePrice] [decimal](18, 5) NOT NULL,
	[RegularMarkup] [decimal](18, 5) NOT NULL,
	[SaleMarkup] [decimal](18, 5) NOT NULL,
	[CurrencyCode] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_CustomerProductPrice] PRIMARY KEY CLUSTERED 
(
	[CustomerProductPriceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CustomerProductSet]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerProductSet](
	[CustomerProductSetId] [uniqueidentifier] NOT NULL,
	[CustomerId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](255) NOT NULL,
	[Active] [datetime] NOT NULL,
	[Deactivate] [datetime] NULL,
 CONSTRAINT [PK__CustomerProductS__3508D0F3] PRIMARY KEY CLUSTERED 
(
	[CustomerProductSetId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CustomerProductSetProduct]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerProductSetProduct](
	[CustomerProductSetProductId] [uniqueidentifier] NOT NULL,
	[CustomerProductSetId] [uniqueidentifier] NOT NULL,
	[ProductId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK__CustomerProductS__3BB5CE82] PRIMARY KEY CLUSTERED 
(
	[CustomerProductSetProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CustomerProperty]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerProperty](
	[CustomerPropertyId] [uniqueidentifier] NOT NULL,
	[CustomerId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Value] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_CustomerProperty] PRIMARY KEY CLUSTERED 
(
	[CustomerPropertyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CustomerSalesman]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerSalesman](
	[CustomerId] [uniqueidentifier] NOT NULL,
	[SalesmanId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_CustomerSalesman] PRIMARY KEY CLUSTERED 
(
	[CustomerId] ASC,
	[SalesmanId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CustomerUserProfile]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerUserProfile](
	[CustomerUserProfileId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_CustomerUserProfile_CustomerUserProfileId]  DEFAULT (newsequentialid()),
	[CustomerId] [uniqueidentifier] NOT NULL,
	[UserProfileId] [uniqueidentifier] NOT NULL,
	[DefaultCostCode] [nvarchar](100) NOT NULL CONSTRAINT [DF_CustomerUserProfile_DefaultCostCode]  DEFAULT (''),
	[IsDefault] [tinyint] NOT NULL CONSTRAINT [DF_CustomerUserProfile_IsDefault]  DEFAULT ((0)),
 CONSTRAINT [PK__CustomerUserProf__2F4FF79D] PRIMARY KEY CLUSTERED 
(
	[CustomerUserProfileId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [CustomerUserProfile_uq] UNIQUE NONCLUSTERED 
(
	[CustomerId] ASC,
	[UserProfileId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CustomProperty]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomProperty](
	[CustomPropertyId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_CustomProperty_CustomPropertyId]  DEFAULT (newsequentialid()),
	[ParentId] [uniqueidentifier] NULL,
	[Name] [nvarchar](100) NOT NULL CONSTRAINT [DF_CustomProperty_Name]  DEFAULT (''),
	[Value] [nvarchar](max) NOT NULL CONSTRAINT [DF_CustomProperty_Value]  DEFAULT (''),
 CONSTRAINT [PK_CustomProperty] PRIMARY KEY CLUSTERED 
(
	[CustomPropertyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DashboardPanelPosition]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DashboardPanelPosition](
	[DashboardPanelPositionId] [uniqueidentifier] NOT NULL,
	[UserProfileId] [uniqueidentifier] NOT NULL,
	[PanelType] [nvarchar](100) NOT NULL,
	[SortOrder] [int] NOT NULL,
 CONSTRAINT [PK_DashboardPanelPosition] PRIMARY KEY CLUSTERED 
(
	[DashboardPanelPositionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DatabaseScript]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DatabaseScript](
	[DatabaseScriptId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_DatabaseScript_DatabaseScriptId]  DEFAULT (newsequentialid()),
	[ScriptName] [nvarchar](255) NOT NULL CONSTRAINT [DF_DatabaseScript_ScriptName]  DEFAULT (''),
	[Applied] [datetime] NOT NULL CONSTRAINT [DF_DatabaseScript_Applied]  DEFAULT (getdate()),
 CONSTRAINT [PK_DatabaseScript] PRIMARY KEY CLUSTERED 
(
	[DatabaseScriptId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Dealer]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dealer](
	[DealerId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Address1] [nvarchar](100) NOT NULL,
	[Address2] [nvarchar](100) NOT NULL,
	[City] [nvarchar](100) NOT NULL,
	[State] [nvarchar](50) NOT NULL,
	[Zip] [nvarchar](50) NOT NULL,
	[Phone1] [nvarchar](50) NOT NULL,
	[Fax1] [nvarchar](50) NOT NULL,
	[Manager] [nvarchar](100) NOT NULL,
	[CountryId] [uniqueidentifier] NULL,
	[WebSiteId] [uniqueidentifier] NULL,
	[Latitude] [decimal](18, 6) NOT NULL,
	[Longitude] [decimal](18, 6) NOT NULL,
	[WebSiteUrl] [nvarchar](1024) NOT NULL,
	[ContentManagerId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Dealers] PRIMARY KEY CLUSTERED 
(
	[DealerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DealerCategory]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DealerCategory](
	[DealerId] [uniqueidentifier] NOT NULL,
	[CategoryId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_DealerCategory] PRIMARY KEY CLUSTERED 
(
	[DealerId] ASC,
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DealerProduct]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DealerProduct](
	[DealerId] [uniqueidentifier] NOT NULL,
	[ProductId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_DealerProduct] PRIMARY KEY CLUSTERED 
(
	[DealerId] ASC,
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DealerProperty]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DealerProperty](
	[DealerPropertyId] [uniqueidentifier] NOT NULL,
	[DealerId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Value] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_DealerProperty] PRIMARY KEY CLUSTERED 
(
	[DealerPropertyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DictionaryAttribute]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DictionaryAttribute](
	[DictionaryAttributeId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_DictionaryAttribute_DictionaryAttributeId]  DEFAULT (newsequentialid()),
	[ApplicationDictionaryId] [uniqueidentifier] NOT NULL,
	[RoleName] [nvarchar](100) NOT NULL CONSTRAINT [DF_DictionaryAttribute_RoleName]  DEFAULT (''),
	[RequiredField] [tinyint] NOT NULL CONSTRAINT [DF_DictionaryAttribute_RequiredField]  DEFAULT ((0)),
	[DisplayType] [int] NOT NULL CONSTRAINT [DF_DictionaryAttribute_DisplayType]  DEFAULT ((2)),
	[IncludeInGrid] [tinyint] NOT NULL CONSTRAINT [DF_DictionaryAttribute_IncludeInGrid]  DEFAULT ((0)),
	[MinimumValue] [nvarchar](100) NOT NULL CONSTRAINT [DF_DictionaryAttribute_MinimumValue]  DEFAULT (''),
	[MaximumValue] [nvarchar](100) NOT NULL CONSTRAINT [DF_DictionaryAttribute_MaximumValue]  DEFAULT (''),
	[DefaultValue] [nvarchar](max) NOT NULL CONSTRAINT [DF_DictionaryAttribute_DefaultValue]  DEFAULT (''),
 CONSTRAINT [PK_DictionaryAttribute] PRIMARY KEY CLUSTERED 
(
	[DictionaryAttributeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DictionaryLabel]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DictionaryLabel](
	[DictionaryLabelId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_DictionaryLabel_DictionaryLabelId]  DEFAULT (newsequentialid()),
	[ApplicationDictionaryId] [uniqueidentifier] NOT NULL,
	[LanguageCode] [nvarchar](50) NOT NULL CONSTRAINT [DF_DictionaryLabel_LanguageCode]  DEFAULT ('en-US'),
	[SystemLabel] [nvarchar](255) NOT NULL CONSTRAINT [DF_DictionaryLabel_SystemLabel]  DEFAULT (''),
	[CustomerLabel] [nvarchar](255) NOT NULL CONSTRAINT [DF_DictionaryLabel_CustomerLabel]  DEFAULT (''),
 CONSTRAINT [PK_DictionaryLabel] PRIMARY KEY CLUSTERED 
(
	[DictionaryLabelId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Document]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Document](
	[DocumentId] [uniqueidentifier] NOT NULL,
	[DocumentManagerId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](100) NOT NULL,
	[Created] [datetime] NOT NULL,
	[FilePath] [nvarchar](100) NOT NULL,
	[FileName] [nvarchar](100) NOT NULL,
	[DocumentType] [nvarchar](100) NOT NULL,
	[LanguageCode] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Document] PRIMARY KEY CLUSTERED 
(
	[DocumentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DocumentManager]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DocumentManager](
	[DocumentManagerId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_DocumentManager_DocumentManagerId]  DEFAULT (newsequentialid()),
	[Name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_DocumentManager] PRIMARY KEY CLUSTERED 
(
	[DocumentManagerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ELMAH_Error]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ELMAH_Error](
	[ErrorId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_ELMAH_Error_ErrorId]  DEFAULT (newid()),
	[Application] [nvarchar](60) NOT NULL,
	[Host] [nvarchar](50) NOT NULL,
	[Type] [nvarchar](100) NOT NULL,
	[Source] [nvarchar](60) NOT NULL,
	[Message] [nvarchar](500) NOT NULL,
	[User] [nvarchar](50) NOT NULL,
	[StatusCode] [int] NOT NULL,
	[TimeUtc] [datetime] NOT NULL,
	[Sequence] [int] IDENTITY(1,1) NOT NULL,
	[AllXml] [ntext] NOT NULL,
 CONSTRAINT [PK_ELMAH_Error] PRIMARY KEY NONCLUSTERED 
(
	[ErrorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EmailList]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmailList](
	[EmailListId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_EmailList_EmailListId]  DEFAULT (newsequentialid()),
	[Name] [nvarchar](100) NOT NULL CONSTRAINT [DF_EmailList_Name]  DEFAULT (''),
	[Description] [nvarchar](250) NOT NULL CONSTRAINT [DF_EmailList_Description]  DEFAULT (''),
	[Subject] [nvarchar](250) NOT NULL CONSTRAINT [DF_EmailList_Subject]  DEFAULT (''),
	[FromAddress] [nvarchar](100) NOT NULL CONSTRAINT [DF_EmailList_FromAddress]  DEFAULT (''),
	[EmailTemplateId] [uniqueidentifier] NULL,
	[CanSubscribe] [tinyint] NOT NULL CONSTRAINT [DF_EmailList_CanSubscribe]  DEFAULT ((0)),
 CONSTRAINT [PK_EmailList] PRIMARY KEY CLUSTERED 
(
	[EmailListId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EmailMessage]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmailMessage](
	[EmailMessageId] [uniqueidentifier] NOT NULL,
	[Body] [nvarchar](max) NOT NULL,
	[Subject] [nvarchar](256) NOT NULL,
	[SentDate] [datetime] NOT NULL,
 CONSTRAINT [PK_EmailMessage] PRIMARY KEY CLUSTERED 
(
	[EmailMessageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EmailMessageAddress]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmailMessageAddress](
	[EmailMessageAddressId] [uniqueidentifier] NOT NULL,
	[EmailMessageId] [uniqueidentifier] NOT NULL,
	[EmailAddress] [nvarchar](254) NOT NULL,
	[Type] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_EmailMessageAddress] PRIMARY KEY CLUSTERED 
(
	[EmailMessageAddressId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EmailMessageDeliveryAttempt]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmailMessageDeliveryAttempt](
	[EmailMessageDeliveryAttemptId] [uniqueidentifier] NOT NULL,
	[EmailMessageId] [uniqueidentifier] NOT NULL,
	[AttemptedDateTime] [datetime] NOT NULL,
	[ErrorMessage] [nvarchar](max) NOT NULL,
	[DeliveredDate] [datetime] NULL,
 CONSTRAINT [PK_EmailMessageDeliveryAttempt] PRIMARY KEY CLUSTERED 
(
	[EmailMessageDeliveryAttemptId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EmailSubscriber]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmailSubscriber](
	[EmailSubscriberId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_EmailSubscriber_EmailSubscriberId]  DEFAULT (newsequentialid()),
	[CreateDate] [datetime] NOT NULL,
	[Email] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_EmailSubscriber] PRIMARY KEY CLUSTERED 
(
	[EmailSubscriberId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EmailSubscriberEmailList]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmailSubscriberEmailList](
	[EmailSubscriberId] [uniqueidentifier] NOT NULL,
	[EmailListId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_EmailSubscriberEmailList] PRIMARY KEY CLUSTERED 
(
	[EmailSubscriberId] ASC,
	[EmailListId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EmailTemplate]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmailTemplate](
	[EmailTemplateID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_EmailTemplate_EmailTemplateId]  DEFAULT (newsequentialid()),
	[Name] [nvarchar](100) NOT NULL CONSTRAINT [DF_EmailTemplate_Name]  DEFAULT (''),
	[Description] [nvarchar](250) NOT NULL CONSTRAINT [DF_EmailTemplate_Description]  DEFAULT (''),
	[ContentManagerId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_EmailTemplate] PRIMARY KEY CLUSTERED 
(
	[EmailTemplateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FilterSection]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FilterSection](
	[FilterSectionId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[IsActive] [tinyint] NOT NULL,
	[Label] [nvarchar](1024) NOT NULL,
	[IsFilter] [tinyint] NOT NULL,
	[IsComparable] [tinyint] NOT NULL,
 CONSTRAINT [PK_FilterSection] PRIMARY KEY CLUSTERED 
(
	[FilterSectionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FilterValue]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FilterValue](
	[FilterValueId] [uniqueidentifier] NOT NULL,
	[FilterSectionId] [uniqueidentifier] NOT NULL,
	[Value] [nvarchar](255) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[IsActive] [tinyint] NOT NULL,
 CONSTRAINT [PK_FilterValue] PRIMARY KEY CLUSTERED 
(
	[FilterValueId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GiftCard]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiftCard](
	[GiftCardId] [uniqueidentifier] NOT NULL,
	[OrderLineId] [uniqueidentifier] NULL,
	[GiftCardNumber] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](100) NOT NULL,
	[FirstName] [nvarchar](100) NOT NULL,
	[Email] [nvarchar](255) NOT NULL,
	[Purchased] [datetime] NOT NULL,
	[Expired] [datetime] NULL,
	[IsActive] [tinyint] NOT NULL,
	[Amount] [decimal](18, 5) NOT NULL,
	[CurrencyId] [uniqueidentifier] NULL,
	[ConversionRate] [decimal](18, 5) NULL,
	[CurrencyAmount] [decimal](18, 5) NULL,
 CONSTRAINT [PK_GiftCard] PRIMARY KEY CLUSTERED 
(
	[GiftCardId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GiftCardTransaction]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiftCardTransaction](
	[GiftCardTransactionId] [uniqueidentifier] NOT NULL,
	[GiftCardId] [uniqueidentifier] NOT NULL,
	[CustomerOrderId] [uniqueidentifier] NULL,
	[Amount] [decimal](18, 5) NOT NULL,
	[TransactionDate] [datetime] NOT NULL,
	[CurrencyAmount] [decimal](18, 5) NULL,
 CONSTRAINT [PK_GiftCardTransaction] PRIMARY KEY CLUSTERED 
(
	[GiftCardTransactionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GlobalSynonym]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GlobalSynonym](
	[GlobalSynonymId] [uniqueidentifier] NOT NULL,
	[SynonymType] [nvarchar](50) NOT NULL,
	[LookupValue] [nvarchar](50) NOT NULL,
	[MappedValue] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](100) NOT NULL,
	[ParentId] [uniqueidentifier] NULL,
	[LanguageCode] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_GlobalSynonym] PRIMARY KEY CLUSTERED 
(
	[GlobalSynonymId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HtmlRedirect]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HtmlRedirect](
	[HtmlRedirectId] [uniqueidentifier] NOT NULL,
	[OldUrl] [nvarchar](300) NOT NULL,
	[NewUrl] [nvarchar](300) NOT NULL,
 CONSTRAINT [PK_HtmlRedirect] PRIMARY KEY CLUSTERED 
(
	[HtmlRedirectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[IndexState]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IndexState](
	[IndexStateId] [uniqueidentifier] NOT NULL,
	[ServerName] [nvarchar](50) NOT NULL,
	[ServerIndexPath] [nvarchar](200) NOT NULL,
	[StartDateTime] [datetime] NOT NULL,
	[EndDateTime] [datetime] NULL,
	[Succeeded] [bit] NOT NULL,
 CONSTRAINT [PK_IndexState] PRIMARY KEY CLUSTERED 
(
	[IndexStateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[IntegrationConnection]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IntegrationConnection](
	[IntegrationConnectionId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_IntegrationConnection_IntegrationConnectionId]  DEFAULT (newsequentialid()),
	[Name] [nvarchar](255) NOT NULL CONSTRAINT [DF_IntegrationConnection_Name]  DEFAULT (''),
	[TypeName] [nvarchar](255) NOT NULL CONSTRAINT [DF_IntegrationConnection_TypeName]  DEFAULT (''),
	[DataSource] [nvarchar](255) NOT NULL CONSTRAINT [DF_IntegrationConnection_DataSource]  DEFAULT (''),
	[RunsOn] [nvarchar](255) NOT NULL CONSTRAINT [DF_IntegrationConnection_RunsOn]  DEFAULT (''),
	[DebuggingEnabled] [tinyint] NOT NULL CONSTRAINT [DF_IntegrationConnection_DebuggingEnabled]  DEFAULT ((0)),
	[Delimiter] [nvarchar](255) NOT NULL CONSTRAINT [DF_IntegrationConnection_Delimiter]  DEFAULT (''),
	[Url] [nvarchar](2048) NOT NULL CONSTRAINT [DF_IntegrationConnection_Url]  DEFAULT (''),
	[LogOn] [nvarchar](255) NOT NULL CONSTRAINT [DF_IntegrationConnection_LogOn]  DEFAULT (''),
	[Password] [nvarchar](255) NOT NULL CONSTRAINT [DF_IntegrationConnection_Password]  DEFAULT (''),
	[ConnectionString] [nvarchar](2048) NOT NULL CONSTRAINT [DF_IntegrationConnection_ConnectionString]  DEFAULT (''),
	[ArchiveFolder] [nvarchar](512) NOT NULL CONSTRAINT [DF_IntegrationConnection_ArchiveFolder]  DEFAULT (''),
	[ArchiveRetentionDays] [int] NOT NULL CONSTRAINT [DF_IntegrationConnection_ArchiveRetentionDays]  DEFAULT ((30)),
 CONSTRAINT [PK_IntegrationConnection] PRIMARY KEY CLUSTERED 
(
	[IntegrationConnectionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[IntegrationJob]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IntegrationJob](
	[IntegrationJobId] [uniqueidentifier] NOT NULL,
	[IntegrationJobDefinitionId] [uniqueidentifier] NOT NULL,
	[StartDateTime] [datetime] NULL,
	[EndDateTime] [datetime] NULL,
	[Duration] [decimal](18, 5) NOT NULL,
	[Status] [nvarchar](255) NOT NULL,
	[RecordCount] [int] NOT NULL,
	[Notes] [nvarchar](max) NOT NULL,
	[DataSize] [decimal](18, 5) NOT NULL,
	[IsRealTime] [tinyint] NOT NULL,
	[ResultData] [nvarchar](max) NOT NULL,
	[IsPreview] [tinyint] NOT NULL,
	[JobNumber] [int] IDENTITY(1,1) NOT NULL,
	[DeltaDataSetProcessed] [tinyint] NOT NULL,
	[ScheduleDateTime] [datetime] NULL,
	[PreviewStepSequence] [int] NOT NULL,
	[InitialData] [nvarchar](max) NOT NULL,
	[FileProcessed] [tinyint] NOT NULL,
	[RunStandalone] [tinyint] NOT NULL,
	[CreatedOn] [datetime2](7) NULL,
	[CreatedBy] [nvarchar](100) NOT NULL,
	[ModifiedOn] [datetime2](7) NULL,
 CONSTRAINT [PK_IntegrationJob] PRIMARY KEY CLUSTERED 
(
	[IntegrationJobId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[IntegrationJobDefinition]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IntegrationJobDefinition](
	[IntegrationJobDefinitionId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_IntegrationJobDefinition_IntegrationJobDefinitionId]  DEFAULT (newsequentialid()),
	[IntegrationConnectionId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](255) NOT NULL CONSTRAINT [DF_IntegrationJobDefinition_Name]  DEFAULT (''),
	[Description] [nvarchar](max) NOT NULL CONSTRAINT [DF_IntegrationJobDefinition_Description]  DEFAULT (''),
	[JobType] [nvarchar](255) NOT NULL CONSTRAINT [DF_IntegrationJobDefinition_JobType]  DEFAULT (''),
	[DebuggingEnabled] [tinyint] NOT NULL CONSTRAINT [DF_IntegrationJobDefinition_DebuggingEnabled]  DEFAULT ((0)),
	[PassThroughJob] [tinyint] NOT NULL CONSTRAINT [DF_IntegrationJobDefinition_PassThroughJob]  DEFAULT ((0)),
	[NotifyEmail] [nvarchar](255) NOT NULL CONSTRAINT [DF_IntegrationJobDefinition_NotifyEmail]  DEFAULT (''),
	[NotifyCondition] [nvarchar](255) NOT NULL CONSTRAINT [DF_IntegrationJobDefinition_NotifyCondition]  DEFAULT (''),
	[LinkedJobId] [uniqueidentifier] NULL,
	[PassDataSetToLinkedJob] [tinyint] NOT NULL CONSTRAINT [DF_IntegrationJobDefinition_PassDatasetToLinkedJob]  DEFAULT ((0)),
	[UseDeltaDataSet] [tinyint] NOT NULL CONSTRAINT [DF_IntegrationJobDefinition_UseDeltaDataset]  DEFAULT ((0)),
	[PreProcessor] [nvarchar](510) NOT NULL CONSTRAINT [DF_IntegrationJobDefinition_PreProcessor]  DEFAULT (''),
	[IntegrationProcessor] [nvarchar](510) NOT NULL CONSTRAINT [DF_IntegrationJobDefinition_IntegrationProcessor]  DEFAULT (''),
	[PostProcessor] [nvarchar](510) NOT NULL CONSTRAINT [DF_IntegrationJobDefinition_PostProcessor]  DEFAULT (''),
	[LastRunDateTime] [datetime] NULL,
	[LastRunJobNumber] [nvarchar](255) NOT NULL CONSTRAINT [DF_IntegrationJobDefinition_LastRunJobNumber]  DEFAULT (''),
	[LastRunStatus] [nvarchar](255) NOT NULL CONSTRAINT [DF_IntegrationJobDefinition_LastRunStatus]  DEFAULT (''),
	[RecurringJob] [tinyint] NOT NULL CONSTRAINT [DF_IntegrationJobDefinition_RecurringJob]  DEFAULT ((0)),
	[RecurringStartDateTime] [datetime] NULL,
	[RecurringEndDateTime] [datetime] NULL,
	[RecurringInterval] [int] NOT NULL CONSTRAINT [DF_IntegrationJobDefinition_RecurringMinuteInterval]  DEFAULT ((0)),
	[RecurringType] [nvarchar](50) NOT NULL CONSTRAINT [DF_IntegrationJobDefinition_RecurringType]  DEFAULT (''),
	[RecurringStartTime] [datetime] NULL,
	[RecurringStartDay] [int] NOT NULL CONSTRAINT [DF_IntegrationJobDefinition_RecurringStartDay]  DEFAULT ((0)),
	[EmailTemplateId] [uniqueidentifier] NULL,
	[RunStepsInParallel] [tinyint] NOT NULL CONSTRAINT [DF_IntegrationJobDefinition_RunStepsInParallel]  DEFAULT ((0)),
	[LinkedJobCondition] [nvarchar](255) NOT NULL CONSTRAINT [DF_IntegrationJobDefinition_LinkedJobCondition]  DEFAULT ('SuccessOnly'),
 CONSTRAINT [PK_IntegrationJobDefinition] PRIMARY KEY CLUSTERED 
(
	[IntegrationJobDefinitionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[IntegrationJobDefinitionPostprocessorParameter]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IntegrationJobDefinitionPostprocessorParameter](
	[IntegrationJobDefinitionPostprocessorParameterId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_IntegrationJobDefinitionPostprocessorParameter_IntegrationJobDefinitionPostprocessorParameterId]  DEFAULT (newsequentialid()),
	[IntegrationJobDefinitionId] [uniqueidentifier] NOT NULL,
	[Sequence] [int] NOT NULL CONSTRAINT [DF_IntegrationJobDefinitionPostprocessorParameter_Sequence]  DEFAULT ((0)),
	[ValueType] [nvarchar](255) NOT NULL CONSTRAINT [DF_IntegrationJobDefinitionPostprocessorParameter_ValueType]  DEFAULT (''),
	[DefaultValue] [nvarchar](max) NOT NULL CONSTRAINT [DF_IntegrationJobDefinitionPostprocessorParameter_DefaultValue]  DEFAULT (''),
	[Prompt] [nvarchar](max) NOT NULL CONSTRAINT [DF_IntegrationJobDefinitionPostprocessorParameter_Prompt]  DEFAULT (''),
	[Name] [nvarchar](255) NOT NULL CONSTRAINT [DF_IntegrationJobDefinitionPostprocessorParameter_Name]  DEFAULT (''),
 CONSTRAINT [PK_IntegrationJobDefinitionPostprocessorParameter] PRIMARY KEY CLUSTERED 
(
	[IntegrationJobDefinitionPostprocessorParameterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[IntegrationJobDefinitionStep]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IntegrationJobDefinitionStep](
	[IntegrationJobDefinitionStepId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_IntegrationJobDefinitionStep_IntegrationJobDefinitionStepId]  DEFAULT (newsequentialid()),
	[IntegrationJobDefinitionId] [uniqueidentifier] NOT NULL,
	[Sequence] [int] NOT NULL CONSTRAINT [DF_IntegrationJobDefinitionStep_Sequence]  DEFAULT ((0)),
	[Name] [nvarchar](255) NOT NULL CONSTRAINT [DF_IntegrationJobDefinitionStep_Name]  DEFAULT (''),
	[ObjectName] [nvarchar](255) NOT NULL CONSTRAINT [DF_IntegrationJobDefinitionStep_Object]  DEFAULT (''),
	[IntegrationConnectionOverrideId] [uniqueidentifier] NULL,
	[IntegrationProcessorOverride] [nvarchar](510) NOT NULL CONSTRAINT [DF_IntegrationJobDefinitionStep_IntegrationProcessorOverride]  DEFAULT (''),
	[SelectClause] [nvarchar](max) NOT NULL CONSTRAINT [DF_IntegrationJobDefinitionStep_SelectClause]  DEFAULT (''),
	[FromClause] [nvarchar](max) NOT NULL CONSTRAINT [DF_IntegrationJobDefinitionStep_FromClause]  DEFAULT (''),
	[WhereClause] [nvarchar](max) NOT NULL CONSTRAINT [DF_IntegrationJobDefinitionStep_WhereClause]  DEFAULT (''),
	[ParameterizedWhereClause] [nvarchar](max) NOT NULL CONSTRAINT [DF_IntegrationJobDefinitionStep_ParamaterizedWhereClause]  DEFAULT (''),
	[DeleteAction] [nvarchar](255) NOT NULL CONSTRAINT [DF_IntegrationJobDefinitionStep_DeleteAction]  DEFAULT ('Ignore'),
	[DeleteActionFieldToSet] [nvarchar](255) NOT NULL CONSTRAINT [DF_IntegrationJobDefinitionStep_DeleteActionFieldToSet]  DEFAULT (''),
	[DeleteActionValueToSet] [nvarchar](255) NOT NULL CONSTRAINT [DF_IntegrationJobDefinitionStep_DeleteActionValueToSet]  DEFAULT (''),
	[SkipHeaderRow] [tinyint] NOT NULL CONSTRAINT [DF_IntegrationJobDefinitionStep_SkipHeaderRow]  DEFAULT ((1)),
 CONSTRAINT [PK_IntegrationJobDefinitionStep] PRIMARY KEY CLUSTERED 
(
	[IntegrationJobDefinitionStepId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[IntegrationJobDefinitionStepFieldMap]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IntegrationJobDefinitionStepFieldMap](
	[IntegrationJobDefinitionStepFieldMapId] [uniqueidentifier] NOT NULL,
	[IntegrationJobDefinitionStepId] [uniqueidentifier] NOT NULL,
	[FieldType] [nvarchar](255) NOT NULL,
	[FromProperty] [nvarchar](255) NOT NULL,
	[ToProperty] [nvarchar](255) NOT NULL,
	[Overwrite] [tinyint] NOT NULL,
	[IsErpKey] [tinyint] NOT NULL,
 CONSTRAINT [PK_IntegrationJobDefinitionStepFieldMap] PRIMARY KEY CLUSTERED 
(
	[IntegrationJobDefinitionStepFieldMapId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[IntegrationJobDefinitionStepParameter]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IntegrationJobDefinitionStepParameter](
	[IntegrationJobDefinitionStepParameterId] [uniqueidentifier] NOT NULL,
	[IntegrationJobDefinitionStepId] [uniqueidentifier] NOT NULL,
	[Sequence] [int] NOT NULL,
	[ValueType] [nvarchar](255) NOT NULL,
	[DefaultValue] [nvarchar](max) NOT NULL,
	[Prompt] [nvarchar](max) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_IntegrationJobDefinitionStepParameter] PRIMARY KEY CLUSTERED 
(
	[IntegrationJobDefinitionStepParameterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[IntegrationJobLog]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IntegrationJobLog](
	[IntegrationJobLogId] [uniqueidentifier] NOT NULL,
	[IntegrationJobId] [uniqueidentifier] NOT NULL,
	[Sequence] [int] NOT NULL,
	[TypeName] [nvarchar](255) NOT NULL,
	[LogDateTime] [datetime] NOT NULL,
	[Message] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_IntegrationJobLog] PRIMARY KEY CLUSTERED 
(
	[IntegrationJobLogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[IntegrationJobParameter]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IntegrationJobParameter](
	[IntegrationJobParameterId] [uniqueidentifier] NOT NULL,
	[IntegrationJobId] [uniqueidentifier] NOT NULL,
	[IntegrationJobDefinitionStepParameterId] [uniqueidentifier] NOT NULL,
	[Value] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_IntegrationJobParameter] PRIMARY KEY CLUSTERED 
(
	[IntegrationJobParameterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[InventoryTransaction]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InventoryTransaction](
	[InventoryTransactionId] [uniqueidentifier] NOT NULL,
	[ProductId] [uniqueidentifier] NOT NULL,
	[TransactionDate] [datetime] NOT NULL,
	[Description] [nvarchar](255) NOT NULL,
	[Amount] [decimal](18, 5) NOT NULL,
 CONSTRAINT [PK_InventoryTransaction] PRIMARY KEY CLUSTERED 
(
	[InventoryTransactionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Invoice]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoice](
	[InvoiceId] [uniqueidentifier] NOT NULL,
	[CustomerId] [uniqueidentifier] NOT NULL,
	[InvoiceDate] [datetime] NOT NULL,
	[TermsCode] [nvarchar](50) NOT NULL,
	[ShipCode] [nvarchar](50) NOT NULL,
	[OrderNumber] [nvarchar](50) NOT NULL,
	[QuantityOfPackages] [int] NOT NULL,
	[ShipDate] [datetime] NOT NULL,
	[MiscellaneousCharges] [decimal](18, 5) NOT NULL,
	[PrepaidAmount] [decimal](18, 5) NOT NULL,
	[Freight] [decimal](18, 5) NOT NULL,
	[Cost] [decimal](18, 5) NOT NULL,
	[Price] [decimal](18, 5) NOT NULL,
	[BillType] [nvarchar](50) NOT NULL,
	[ExchangeRate] [decimal](18, 7) NOT NULL,
	[UseExchangeRate] [tinyint] NOT NULL,
	[TaxCode1] [nvarchar](50) NOT NULL,
	[TaxCode2] [nvarchar](50) NOT NULL,
	[TaxDate] [datetime] NOT NULL,
	[ECCode] [nvarchar](50) NOT NULL,
	[FreightTaxCode1] [nvarchar](50) NOT NULL,
	[FreightTaxCode2] [nvarchar](50) NOT NULL,
	[MiscellaneousTaxCode1] [nvarchar](50) NOT NULL,
	[MiscellaneousTaxCode2] [nvarchar](50) NOT NULL,
	[Discount] [decimal](18, 5) NOT NULL,
	[DONumber] [nvarchar](50) NOT NULL,
	[Salesman] [nvarchar](50) NOT NULL,
	[State] [nvarchar](50) NOT NULL,
	[InvoiceNumber] [nvarchar](50) NOT NULL,
	[InvoiceSequence] [int] NOT NULL,
	[CustomerPO] [nvarchar](50) NOT NULL,
	[Total] [decimal](18, 5) NOT NULL,
	[OriginalTotal] [decimal](18, 5) NOT NULL,
	[ShipToId] [uniqueidentifier] NULL,
	[InvoiceSent] [datetime] NULL,
 CONSTRAINT [PK_Invoice] PRIMARY KEY CLUSTERED 
(
	[InvoiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[InvoiceHistory]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InvoiceHistory](
	[InvoiceHistoryId] [uniqueidentifier] NOT NULL,
	[InvoiceNumber] [nvarchar](50) NOT NULL,
	[InvoiceDate] [datetime] NOT NULL,
	[DueDate] [datetime] NOT NULL,
	[InvoiceType] [nvarchar](50) NOT NULL,
	[CustomerNumber] [nvarchar](50) NOT NULL,
	[CustomerSequence] [nvarchar](50) NOT NULL,
	[CustomerPO] [nvarchar](50) NOT NULL,
	[Status] [nvarchar](50) NOT NULL,
	[IsOpen] [tinyint] NOT NULL,
	[CurrencyCode] [nvarchar](50) NOT NULL,
	[Terms] [nvarchar](50) NOT NULL,
	[ShipCode] [nvarchar](50) NOT NULL,
	[Salesperson] [nvarchar](50) NOT NULL,
	[BTCompanyName] [nvarchar](100) NOT NULL,
	[BTAddress1] [nvarchar](100) NOT NULL,
	[BTAddress2] [nvarchar](100) NOT NULL,
	[BTCity] [nvarchar](100) NOT NULL,
	[BTState] [nvarchar](50) NOT NULL,
	[BTPostalCode] [nvarchar](50) NOT NULL,
	[BTCountry] [nvarchar](100) NOT NULL,
	[STCompanyName] [nvarchar](100) NOT NULL,
	[STAddress1] [nvarchar](100) NOT NULL,
	[STAddress2] [nvarchar](100) NOT NULL,
	[STCity] [nvarchar](100) NOT NULL,
	[STState] [nvarchar](50) NOT NULL,
	[STPostalCode] [nvarchar](50) NOT NULL,
	[STCountry] [nvarchar](100) NOT NULL,
	[Notes] [nvarchar](max) NOT NULL,
	[ProductTotal] [decimal](18, 5) NOT NULL,
	[DiscountAmount] [decimal](18, 5) NOT NULL,
	[ShippingAndHandling] [decimal](18, 5) NOT NULL,
	[OtherCharges] [decimal](18, 5) NOT NULL,
	[TaxAmount] [decimal](18, 5) NOT NULL,
	[InvoiceTotal] [decimal](18, 5) NOT NULL,
	[CurrentBalance] [decimal](18, 5) NOT NULL,
 CONSTRAINT [PK_InvoiceHistory] PRIMARY KEY CLUSTERED 
(
	[InvoiceHistoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[InvoiceHistoryLine]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InvoiceHistoryLine](
	[InvoiceHistoryLineId] [uniqueidentifier] NOT NULL,
	[InvoiceHistoryId] [uniqueidentifier] NOT NULL,
	[LineType] [nvarchar](50) NOT NULL,
	[ERPOrderNumber] [nvarchar](50) NOT NULL,
	[LineNumber] [decimal](18, 5) NOT NULL,
	[ReleaseNumber] [decimal](18, 5) NOT NULL,
	[ProductERPNumber] [nvarchar](50) NOT NULL,
	[CustomerProductNumber] [nvarchar](50) NOT NULL,
	[LinePOReference] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[Warehouse] [nvarchar](50) NOT NULL,
	[Notes] [nvarchar](max) NOT NULL,
	[QtyInvoiced] [decimal](18, 5) NOT NULL,
	[UnitOfMeasure] [nvarchar](50) NOT NULL,
	[UnitPrice] [decimal](18, 5) NOT NULL,
	[DiscountPercent] [decimal](18, 5) NOT NULL,
	[DiscountAmount] [decimal](18, 5) NOT NULL,
	[LineTotal] [decimal](18, 5) NOT NULL,
	[ShipmentNumber] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_InvoiceHistoryLine] PRIMARY KEY CLUSTERED 
(
	[InvoiceHistoryLineId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[InvoiceLine]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InvoiceLine](
	[InvoiceLineId] [uniqueidentifier] NOT NULL,
	[InvoiceId] [uniqueidentifier] NOT NULL,
	[InvoiceNumber] [nvarchar](50) NOT NULL,
	[InvoiceSequence] [int] NOT NULL,
	[InvoiceLineNumber] [int] NOT NULL,
	[OrderNumber] [nvarchar](50) NOT NULL,
	[OrderLine] [int] NOT NULL,
	[OrderRelease] [int] NOT NULL,
	[ProductName] [nvarchar](100) NOT NULL,
	[QuantityInvoiced] [int] NOT NULL,
	[Discount] [decimal](18, 5) NOT NULL,
	[Cost] [decimal](18, 8) NOT NULL,
	[Price] [decimal](18, 8) NOT NULL,
	[OldPrice] [decimal](18, 8) NOT NULL,
	[NewPrice] [decimal](18, 8) NOT NULL,
	[ProcessIdentifier] [nvarchar](50) NOT NULL,
	[ConsignmentType] [int] NOT NULL,
	[TaxCode1] [nvarchar](50) NOT NULL,
	[TaxCode2] [nvarchar](50) NOT NULL,
	[TaxDate] [datetime] NOT NULL,
	[CustomerPO] [nvarchar](50) NOT NULL,
	[RestockFee] [decimal](18, 8) NOT NULL,
	[DONumber] [nvarchar](50) NOT NULL,
	[DOLine] [int] NOT NULL,
	[DOSequence] [int] NOT NULL,
	[OriginalInvoiceNumber] [nvarchar](50) NOT NULL,
	[ReasonText] [nvarchar](max) NOT NULL,
	[ProductDescription] [nvarchar](max) NOT NULL,
	[ProductCode] [nvarchar](50) NOT NULL,
	[QuantityOrdered] [int] NOT NULL,
 CONSTRAINT [PK_InvoiceLine] PRIMARY KEY CLUSTERED 
(
	[InvoiceLineId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ItemCustPrice_Batch]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ItemCustPrice_Batch](
	[item] [nvarchar](30) NOT NULL,
	[cust_num] [nvarchar](7) NULL,
	[cont_price] [decimal](18, 8) NULL,
	[effect_date] [datetime] NOT NULL,
	[brk_qty1] [decimal](18, 8) NULL,
	[brk_qty2] [decimal](18, 8) NULL,
	[brk_qty3] [decimal](18, 8) NULL,
	[brk_qty4] [decimal](18, 8) NULL,
	[brk_qty5] [decimal](18, 8) NULL,
	[brk_price1] [decimal](18, 8) NULL,
	[brk_price2] [decimal](18, 8) NULL,
	[brk_price3] [decimal](18, 8) NULL,
	[brk_price4] [decimal](18, 8) NULL,
	[brk_price5] [decimal](18, 8) NULL,
	[base_code1] [nvarchar](2) NULL,
	[base_code2] [nvarchar](2) NULL,
	[base_code3] [nvarchar](2) NULL,
	[base_code4] [nvarchar](2) NULL,
	[base_code5] [nvarchar](2) NULL,
	[dol_percent1] [nchar](1) NULL,
	[dol_percent2] [nchar](1) NULL,
	[dol_percent3] [nchar](1) NULL,
	[dol_percent4] [nchar](1) NULL,
	[dol_percent5] [nchar](1) NULL,
	[include_tax_in_price] [tinyint] NULL,
	[cust_item_seq] [int] NULL,
	[RowPointer] [nvarchar](36) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ItemPrice_Batch]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ItemPrice_Batch](
	[item] [nvarchar](30) NOT NULL,
	[effect_date] [datetime] NOT NULL,
	[curr_code] [nvarchar](3) NULL,
	[unit_price1] [decimal](18, 8) NOT NULL,
	[unit_price2] [decimal](18, 8) NOT NULL,
	[unit_price3] [decimal](18, 8) NOT NULL,
	[unit_price4] [decimal](18, 8) NOT NULL,
	[unit_price5] [decimal](18, 8) NOT NULL,
	[unit_price6] [decimal](18, 8) NOT NULL,
	[reprice] [tinyint] NOT NULL,
	[brk_qty1] [decimal](18, 8) NOT NULL,
	[brk_qty2] [decimal](18, 8) NOT NULL,
	[brk_qty3] [decimal](18, 8) NOT NULL,
	[brk_qty4] [decimal](18, 8) NOT NULL,
	[brk_qty5] [decimal](18, 8) NOT NULL,
	[brk_price1] [decimal](18, 8) NOT NULL,
	[brk_price2] [decimal](18, 8) NOT NULL,
	[brk_price3] [decimal](18, 8) NOT NULL,
	[brk_price4] [decimal](18, 8) NOT NULL,
	[brk_price5] [decimal](18, 8) NOT NULL,
	[base_code1] [nvarchar](2) NULL,
	[base_code2] [nvarchar](2) NULL,
	[base_code3] [nvarchar](2) NULL,
	[base_code4] [nvarchar](2) NULL,
	[base_code5] [nvarchar](2) NULL,
	[dol_percent1] [nchar](1) NULL,
	[dol_percent2] [nchar](1) NULL,
	[dol_percent3] [nchar](1) NULL,
	[dol_percent4] [nchar](1) NULL,
	[dol_percent5] [nchar](1) NULL,
	[pricecode] [nvarchar](3) NULL,
	[RowPointer] [nvarchar](36) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Language]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Language](
	[LanguageId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Language_LanguageId]  DEFAULT (newsequentialid()),
	[LanguageCode] [nvarchar](50) NOT NULL CONSTRAINT [DF_Language_LanguageCode]  DEFAULT (''),
	[Description] [nvarchar](255) NOT NULL CONSTRAINT [DF_Language_Description]  DEFAULT (''),
	[AlternateLanguages] [nvarchar](255) NOT NULL CONSTRAINT [DF_Language_AlternateLanguages]  DEFAULT (''),
	[HasDeviceSpecificContent] [tinyint] NOT NULL CONSTRAINT [DF_Language_HasDeviceSpecificContent]  DEFAULT ((0)),
	[HasPersonaSpecificContent] [tinyint] NOT NULL CONSTRAINT [DF_Language_HasPersonaSpecificContent]  DEFAULT ((0)),
	[ImageFilePath] [nvarchar](255) NOT NULL CONSTRAINT [DF_Language_ImageFilePath]  DEFAULT (''),
	[IsDefault] [tinyint] NOT NULL CONSTRAINT [DF_Language_IsDefault]  DEFAULT ((0)),
	[CultureCode] [nvarchar](50) NOT NULL CONSTRAINT [DF_Language_CultureCode]  DEFAULT (''),
 CONSTRAINT [PK_Language] PRIMARY KEY CLUSTERED 
(
	[LanguageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LocalTaxRate]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LocalTaxRate](
	[LocalTaxRateId] [uniqueidentifier] NOT NULL,
	[Zip] [nvarchar](50) NOT NULL,
	[TaxRate] [decimal](18, 4) NOT NULL,
	[TaxCode] [nvarchar](50) NOT NULL,
	[TaxFreight] [tinyint] NOT NULL,
 CONSTRAINT [PK_LocalTaxRate] PRIMARY KEY CLUSTERED 
(
	[LocalTaxRateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LocalTaxRateTaxExemption]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LocalTaxRateTaxExemption](
	[LocalTaxRateId] [uniqueidentifier] NOT NULL,
	[TaxExemptionId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_LocalTaxRateTaxExemption] PRIMARY KEY CLUSTERED 
(
	[LocalTaxRateId] ASC,
	[TaxExemptionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Menu]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Menu](
	[MenuId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Menu_MenuId]  DEFAULT (newsequentialid()),
	[ParentId] [uniqueidentifier] NULL,
	[Name] [nvarchar](100) NOT NULL CONSTRAINT [DF_Menu_Name]  DEFAULT (''),
	[Description] [nvarchar](max) NOT NULL CONSTRAINT [DF_Menu_Description]  DEFAULT (''),
	[Image] [nvarchar](255) NOT NULL CONSTRAINT [DF_Menu_Image]  DEFAULT (''),
	[IsActive] [tinyint] NOT NULL CONSTRAINT [DF_Menu_IsActive]  DEFAULT ((1)),
	[Target] [nvarchar](255) NOT NULL CONSTRAINT [DF_Menu_Target]  DEFAULT (''),
	[SortOrder] [int] NOT NULL CONSTRAINT [DF_Menu_SortOrder]  DEFAULT ((0)),
	[LanguageCode] [nvarchar](50) NOT NULL CONSTRAINT [DF_Menu_LanguageCode]  DEFAULT (''),
	[MenuType] [nvarchar](50) NOT NULL CONSTRAINT [DF_Menu_MenuType]  DEFAULT (''),
	[IconText] [nvarchar](50) NOT NULL CONSTRAINT [DF_Menu_IconText]  DEFAULT (''),
	[IsGlobalItem] [tinyint] NOT NULL CONSTRAINT [DF_Menu_IsGlobalItem]  DEFAULT ((0)),
	[IsSystemItem] [tinyint] NOT NULL CONSTRAINT [DF_Menu_IsSystemItem]  DEFAULT ((0)),
	[ShowInList] [tinyint] NOT NULL CONSTRAINT [DF_Menu_ShowInList]  DEFAULT ((0)),
 CONSTRAINT [PK_Menu] PRIMARY KEY CLUSTERED 
(
	[MenuId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MenuRole]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MenuRole](
	[MenuId] [uniqueidentifier] NOT NULL,
	[RoleName] [nvarchar](50) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Message]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Message](
	[MessageId] [uniqueidentifier] NOT NULL,
	[Subject] [nvarchar](250) NOT NULL,
	[Body] [nvarchar](max) NOT NULL,
	[DateToDisplay] [datetime] NOT NULL,
	[DateToHide] [datetime] NULL,
	[LanguageCode] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Message_1] PRIMARY KEY CLUSTERED 
(
	[MessageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MessageAudit]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MessageAudit](
	[MessageAuditId] [uniqueidentifier] NOT NULL,
	[MessageId] [uniqueidentifier] NOT NULL,
	[CustomerOrderId] [uniqueidentifier] NULL,
	[Process] [nvarchar](50) NOT NULL,
	[FromUserProfileId] [uniqueidentifier] NULL,
	[ToUserProfileId] [uniqueidentifier] NULL,
	[Body] [nvarchar](2000) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_MessageAudit] PRIMARY KEY CLUSTERED 
(
	[MessageAuditId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MessageStatus]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MessageStatus](
	[MessageStatusId] [uniqueidentifier] NOT NULL,
	[MessageId] [uniqueidentifier] NOT NULL,
	[UserProfileId] [uniqueidentifier] NOT NULL,
	[HasRead] [tinyint] NOT NULL,
 CONSTRAINT [PK_MessageStatus] PRIMARY KEY CLUSTERED 
(
	[MessageStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MessageTarget]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MessageTarget](
	[MessageTargetId] [uniqueidentifier] NOT NULL,
	[MessageId] [uniqueidentifier] NOT NULL,
	[TargetType] [nvarchar](100) NOT NULL,
	[TargetKey] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_MessageTarget] PRIMARY KEY CLUSTERED 
(
	[MessageTargetId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MiscellaneousCode]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MiscellaneousCode](
	[MiscellaneousCodeId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_MiscellaneousCode_MiscellaneousCodeId]  DEFAULT (newsequentialid()),
	[ParentId] [uniqueidentifier] NULL,
	[Name] [nvarchar](256) NOT NULL CONSTRAINT [DF_MiscellaneousCode_Name]  DEFAULT (''),
	[AdditionalInfo] [nvarchar](max) NOT NULL CONSTRAINT [DF_MiscellaneousCode_AdditionalInfo]  DEFAULT (''),
	[DeactivateDate] [datetime] NULL,
	[Description] [nvarchar](max) NOT NULL CONSTRAINT [DF_MiscellaneousCode_Description]  DEFAULT (''),
 CONSTRAINT [PK_MiscellaneousCode] PRIMARY KEY CLUSTERED 
(
	[MiscellaneousCodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NewsArticle]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NewsArticle](
	[NewsArticleId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_NewsArticle_NewsArticleId]  DEFAULT (newsequentialid()),
	[WebSiteId] [uniqueidentifier] NOT NULL,
	[UserProfileId] [uniqueidentifier] NULL,
	[ContentManagerId] [uniqueidentifier] NULL,
	[Title] [nvarchar](255) NOT NULL CONSTRAINT [DF_NewsArticle_Title]  DEFAULT (''),
	[Description] [nvarchar](max) NOT NULL CONSTRAINT [DF_NewsArticle_Description]  DEFAULT (''),
	[SmallImage] [nvarchar](255) NOT NULL CONSTRAINT [DF_NewsArticle_SmallImage]  DEFAULT (''),
	[LargeImage] [nvarchar](255) NOT NULL CONSTRAINT [DF_NewsArticle_LargeImage]  DEFAULT (''),
	[IsActive] [tinyint] NOT NULL CONSTRAINT [DF_NewsArticle_IsActive]  DEFAULT ((0)),
	[NewsArticleDate] [datetime] NOT NULL CONSTRAINT [DF_NewsArticle_NewsArticleDate]  DEFAULT (getdate()),
	[PublishDate] [datetime] NULL,
 CONSTRAINT [PK_NewsArticle] PRIMARY KEY CLUSTERED 
(
	[NewsArticleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderHistory]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderHistory](
	[OrderHistoryId] [uniqueidentifier] NOT NULL,
	[ERPOrderNumber] [nvarchar](50) NOT NULL,
	[WebOrderNumber] [nvarchar](50) NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[Status] [nvarchar](50) NOT NULL,
	[CustomerNumber] [nvarchar](50) NOT NULL,
	[CustomerSequence] [nvarchar](50) NOT NULL,
	[CustomerPO] [nvarchar](50) NOT NULL,
	[CurrencyCode] [nvarchar](50) NOT NULL,
	[Terms] [nvarchar](50) NOT NULL,
	[ShipCode] [nvarchar](50) NOT NULL,
	[Salesperson] [nvarchar](50) NOT NULL,
	[BTCompanyName] [nvarchar](100) NOT NULL,
	[BTAddress1] [nvarchar](100) NOT NULL,
	[BTAddress2] [nvarchar](100) NOT NULL,
	[BTCity] [nvarchar](100) NOT NULL,
	[BTState] [nvarchar](50) NOT NULL,
	[BTPostalCode] [nvarchar](50) NOT NULL,
	[BTCountry] [nvarchar](100) NOT NULL,
	[STCompanyName] [nvarchar](100) NOT NULL,
	[STAddress1] [nvarchar](100) NOT NULL,
	[STAddress2] [nvarchar](100) NOT NULL,
	[STCity] [nvarchar](100) NOT NULL,
	[STState] [nvarchar](50) NOT NULL,
	[STPostalCode] [nvarchar](50) NOT NULL,
	[STCountry] [nvarchar](100) NOT NULL,
	[Notes] [nvarchar](max) NOT NULL,
	[ProductTotal] [decimal](18, 5) NOT NULL,
	[DiscountAmount] [decimal](18, 5) NOT NULL,
	[ShippingAndHandling] [decimal](18, 5) NOT NULL,
	[OtherCharges] [decimal](18, 5) NOT NULL,
	[TaxAmount] [decimal](18, 5) NOT NULL,
	[OrderTotal] [decimal](18, 5) NOT NULL,
	[ModifyDate] [datetime] NOT NULL,
	[ConversionRate] [decimal](18, 5) NULL,
 CONSTRAINT [PK_OrderHistory] PRIMARY KEY CLUSTERED 
(
	[OrderHistoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderHistoryLine]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderHistoryLine](
	[OrderHistoryLineId] [uniqueidentifier] NOT NULL,
	[OrderHistoryId] [uniqueidentifier] NOT NULL,
	[RequiredDate] [datetime] NULL,
	[LastShipDate] [datetime] NULL,
	[CustomerNumber] [nvarchar](50) NOT NULL,
	[CustomerSequence] [nvarchar](50) NOT NULL,
	[LineType] [nvarchar](50) NOT NULL,
	[Status] [nvarchar](50) NOT NULL,
	[LineNumber] [decimal](18, 5) NOT NULL,
	[ReleaseNumber] [decimal](18, 5) NOT NULL,
	[ProductERPNumber] [nvarchar](50) NOT NULL,
	[CustomerProductNumber] [nvarchar](50) NOT NULL,
	[LinePOReference] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[Warehouse] [nvarchar](50) NOT NULL,
	[Notes] [nvarchar](max) NOT NULL,
	[QtyOrdered] [decimal](18, 5) NOT NULL,
	[QtyShipped] [decimal](18, 5) NOT NULL,
	[UnitOfMeasure] [nvarchar](50) NOT NULL,
	[InventoryQtyOrdered] [decimal](18, 5) NOT NULL,
	[InventoryQtyShipped] [decimal](18, 5) NOT NULL,
	[UnitPrice] [decimal](18, 5) NOT NULL,
	[DiscountPercent] [decimal](18, 5) NOT NULL,
	[DiscountAmount] [decimal](18, 5) NOT NULL,
	[PromotionAmountApplied] [decimal](18, 5) NOT NULL,
	[LineTotal] [decimal](18, 5) NOT NULL,
	[RMAQtyRequested] [decimal](18, 5) NOT NULL,
	[RMAQtyReceived] [decimal](18, 5) NOT NULL,
 CONSTRAINT [PK_OrderHistoryLine] PRIMARY KEY CLUSTERED 
(
	[OrderHistoryLineId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderLine]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderLine](
	[OrderLineId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_OrderLine_OrderLineId]  DEFAULT (newsequentialid()),
	[CustomerOrderId] [uniqueidentifier] NOT NULL,
	[ProductId] [uniqueidentifier] NOT NULL,
	[WebSiteId] [uniqueidentifier] NOT NULL,
	[Status] [nvarchar](50) NOT NULL CONSTRAINT [DF_OrderLine_Status]  DEFAULT (''),
	[Line] [int] NOT NULL,
	[Release] [int] NOT NULL CONSTRAINT [DF_OrderLine_Release]  DEFAULT ((0)),
	[Description] [nvarchar](2048) NOT NULL CONSTRAINT [DF_OrderLine_Description]  DEFAULT (''),
	[Notes] [nvarchar](max) NOT NULL CONSTRAINT [DF_OrderLine_Notes]  DEFAULT (''),
	[QtyOrdered] [decimal](18, 5) NOT NULL CONSTRAINT [DF_OrderLine_QtyOrdered]  DEFAULT ((0)),
	[RegularPrice] [decimal](18, 5) NOT NULL CONSTRAINT [DF_OrderLine_RegularPrice]  DEFAULT ((0)),
	[ActualPrice] [decimal](18, 5) NOT NULL CONSTRAINT [DF_OrderLine_ActualPrice]  DEFAULT ((0)),
	[UnitOfMeasure] [nvarchar](50) NOT NULL CONSTRAINT [DF_OrderLine_UnitOfMeasure]  DEFAULT (''),
	[QtyShipped] [decimal](18, 5) NOT NULL CONSTRAINT [DF_OrderLine_QtyShipped]  DEFAULT ((0)),
	[TaxCode1] [nvarchar](50) NOT NULL CONSTRAINT [DF_OrderLine_TaxCode1]  DEFAULT (''),
	[TaxCode2] [nvarchar](50) NOT NULL CONSTRAINT [DF_OrderLine_TaxCode2]  DEFAULT (''),
	[DueDate] [datetime] NULL CONSTRAINT [DF_OrderLine_DueDate]  DEFAULT (getdate()),
	[PromiseDate] [datetime] NULL,
	[ShipSite] [nvarchar](50) NOT NULL CONSTRAINT [DF_OrderLine_ShipSite]  DEFAULT (''),
	[ShipDate] [datetime] NULL,
	[DiscountAmount] [decimal](18, 5) NOT NULL CONSTRAINT [DF_OrderLine_DiscountAmount]  DEFAULT ((0)),
	[DiscountPercent] [decimal](18, 5) NOT NULL CONSTRAINT [DF_OrderLine_DiscountPercent]  DEFAULT ((0)),
	[IsPromotionItem] [tinyint] NOT NULL CONSTRAINT [DF_OrderLine_IsPromotionItem]  DEFAULT ((0)),
	[PromotionResultId] [uniqueidentifier] NULL,
	[CustomerPOLine] [nvarchar](50) NOT NULL CONSTRAINT [DF_OrderLine_CustomerPOLine]  DEFAULT (''),
	[Warehouse] [nvarchar](50) NOT NULL CONSTRAINT [DF_OrderLine_Warehouse]  DEFAULT (''),
	[CostCode] [nvarchar](100) NOT NULL CONSTRAINT [DF_OrderLine_CostCode]  DEFAULT (''),
 CONSTRAINT [PK_OrderLine] PRIMARY KEY CLUSTERED 
(
	[OrderLineId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderLineAttribute]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderLineAttribute](
	[OrderLineAttributeId] [uniqueidentifier] NOT NULL,
	[OrderLineId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Value] [nvarchar](max) NOT NULL,
	[Hidden] [bit] NULL,
 CONSTRAINT [PK_OrderLineAttribute] PRIMARY KEY CLUSTERED 
(
	[OrderLineAttributeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderLineConfigurationValue]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderLineConfigurationValue](
	[OrderLineConfigurationValueId] [uniqueidentifier] NOT NULL,
	[OrderLineId] [uniqueidentifier] NOT NULL,
	[ConfigurationOptionId] [uniqueidentifier] NOT NULL,
	[PageSequence] [int] NOT NULL,
	[OptionSequence] [int] NOT NULL,
	[OptionValue] [nvarchar](max) NOT NULL,
	[PriceImpact] [decimal](18, 5) NOT NULL,
 CONSTRAINT [PK_OrderLineConfigurationValue] PRIMARY KEY CLUSTERED 
(
	[OrderLineConfigurationValueId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderLineRequisition]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderLineRequisition](
	[OrderLineRequisitionId] [uniqueidentifier] NOT NULL,
	[OrderLineId] [uniqueidentifier] NOT NULL,
	[UserProfileId] [uniqueidentifier] NOT NULL,
	[QtyOrdered] [decimal](18, 0) NOT NULL,
	[CostCode] [nvarchar](100) NOT NULL,
	[OriginalOrderLineId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_OrderLineRequisition] PRIMARY KEY CLUSTERED 
(
	[OrderLineRequisitionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderLineRfq]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderLineRfq](
	[OrderLineRfqId] [uniqueidentifier] NOT NULL,
	[OrderLineId] [uniqueidentifier] NOT NULL,
	[BreakQty01] [decimal](18, 5) NOT NULL,
	[BreakQty02] [decimal](18, 5) NOT NULL,
	[BreakQty03] [decimal](18, 5) NOT NULL,
	[BreakQty04] [decimal](18, 5) NOT NULL,
	[BreakQty05] [decimal](18, 5) NOT NULL,
	[BreakQty06] [decimal](18, 5) NOT NULL,
	[BreakQty07] [decimal](18, 5) NOT NULL,
	[BreakQty08] [decimal](18, 5) NOT NULL,
	[BreakQty09] [decimal](18, 5) NOT NULL,
	[BreakQty10] [decimal](18, 5) NOT NULL,
	[BreakQty11] [decimal](18, 5) NOT NULL,
	[Amount01] [decimal](18, 5) NOT NULL,
	[Amount02] [decimal](18, 5) NOT NULL,
	[Amount03] [decimal](18, 5) NOT NULL,
	[Amount04] [decimal](18, 5) NOT NULL,
	[Amount05] [decimal](18, 5) NOT NULL,
	[Amount06] [decimal](18, 5) NOT NULL,
	[Amount07] [decimal](18, 5) NOT NULL,
	[Amount08] [decimal](18, 5) NOT NULL,
	[Amount09] [decimal](18, 5) NOT NULL,
	[Amount10] [decimal](18, 5) NOT NULL,
	[Amount11] [decimal](18, 5) NOT NULL,
	[MaxQty] [decimal](18, 5) NOT NULL,
 CONSTRAINT [PK_OrderLineRfq] PRIMARY KEY CLUSTERED 
(
	[OrderLineRfqId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PackageLine]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PackageLine](
	[PackageLineId] [uniqueidentifier] NOT NULL,
	[ShipmentPackageId] [uniqueidentifier] NOT NULL,
	[ProductName] [nvarchar](100) NOT NULL,
	[ProductDescription] [nvarchar](max) NOT NULL,
	[ProductCode] [nvarchar](50) NOT NULL,
	[QtyOrdered] [decimal](18, 5) NOT NULL,
	[QtyShipped] [decimal](18, 5) NOT NULL,
	[Price] [decimal](18, 5) NOT NULL,
	[OrderLineId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_PackageLine] PRIMARY KEY CLUSTERED 
(
	[PackageLineId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PaymentTerm]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentTerm](
	[PaymentTermId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_PaymentTerm_PaymentTermId]  DEFAULT (newsequentialid()),
	[TermsCode] [nvarchar](50) NOT NULL CONSTRAINT [DF_PaymentTerm_TermsCode]  DEFAULT (''),
	[Description] [nvarchar](100) NOT NULL CONSTRAINT [DF_PaymentTerm_Description]  DEFAULT (''),
	[Active] [datetime] NOT NULL CONSTRAINT [DF_PaymentTerm_Active]  DEFAULT (getdate()),
	[Deactivate] [datetime] NULL,
	[IsCreditCard] [tinyint] NOT NULL CONSTRAINT [DF_PaymentTerm_IsCreditCard]  DEFAULT ((0)),
 CONSTRAINT [PK_PaymentTerm] PRIMARY KEY CLUSTERED 
(
	[PaymentTermId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Persona]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Persona](
	[PersonaId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Persona_PersonaId]  DEFAULT (newsequentialid()),
	[Name] [nvarchar](100) NOT NULL CONSTRAINT [DF_Persona_Name]  DEFAULT (''),
	[Description] [nvarchar](max) NOT NULL CONSTRAINT [DF_Persona_Description]  DEFAULT (''),
	[Sequence] [int] NOT NULL CONSTRAINT [DF_Persona_Sequence]  DEFAULT ((0)),
	[Active] [datetime] NOT NULL CONSTRAINT [DF_Persona_Active]  DEFAULT (getdate()),
	[Deactivate] [datetime] NULL,
	[IsDefault] [tinyint] NOT NULL CONSTRAINT [DF_Persona_IsDefault]  DEFAULT ((0)),
	[RuleManagerId] [uniqueidentifier] NULL CONSTRAINT [DF_Persona_RuleManager]  DEFAULT (NULL),
 CONSTRAINT [PK_Persona] PRIMARY KEY CLUSTERED 
(
	[PersonaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Plugin]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Plugin](
	[PluginId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Plugin_PluginId]  DEFAULT (newsequentialid()),
	[Name] [nvarchar](255) NOT NULL CONSTRAINT [DF_Plugin_Name]  DEFAULT (''),
	[Description] [nvarchar](2048) NOT NULL CONSTRAINT [DF_Plugin_Description]  DEFAULT (''),
	[InterfaceName] [nvarchar](255) NOT NULL CONSTRAINT [DF_Plugin_InterfaceName]  DEFAULT (''),
	[FullName] [nvarchar](510) NOT NULL CONSTRAINT [DF_Plugin_FullName]  DEFAULT (''),
	[Version] [nvarchar](510) NOT NULL CONSTRAINT [DF_Plugin_Version]  DEFAULT (''),
	[IsActive] [tinyint] NOT NULL CONSTRAINT [DF_Plugin_IsActive]  DEFAULT ((1)),
	[ConnectionName] [nvarchar](150) NOT NULL CONSTRAINT [DF_Plugin_ConnectionName]  DEFAULT (''),
 CONSTRAINT [PK_Plugin] PRIMARY KEY CLUSTERED 
(
	[PluginId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PriceFormula_Batch]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PriceFormula_Batch](
	[cust_pricecode] [nvarchar](3) NULL,
	[item_pricecode] [nvarchar](3) NULL,
	[priceformula] [nvarchar](3) NULL,
	[effect_date] [datetime] NULL,
	[curr_code] [nvarchar](3) NULL,
	[brk_qty1] [decimal](18, 8) NULL,
	[brk_qty2] [decimal](18, 8) NULL,
	[brk_qty3] [decimal](18, 8) NULL,
	[brk_qty4] [decimal](18, 8) NULL,
	[brk_qty5] [decimal](18, 8) NULL,
	[brk_price1] [decimal](18, 8) NULL,
	[brk_price2] [decimal](18, 8) NULL,
	[brk_price3] [decimal](18, 8) NULL,
	[brk_price4] [decimal](18, 8) NULL,
	[brk_price5] [decimal](18, 8) NULL,
	[base_code1] [nvarchar](2) NULL,
	[base_code2] [nvarchar](2) NULL,
	[base_code3] [nvarchar](2) NULL,
	[base_code4] [nvarchar](2) NULL,
	[base_code5] [nvarchar](2) NULL,
	[dol_percent1] [nchar](1) NULL,
	[dol_percent2] [nchar](1) NULL,
	[dol_percent3] [nchar](1) NULL,
	[dol_percent4] [nchar](1) NULL,
	[dol_percent5] [nchar](1) NULL,
	[first_base] [nvarchar](2) NULL,
	[first_dol_percent] [nchar](1) NULL,
	[first_price] [decimal](18, 8) NULL,
	[RowPointer] [nvarchar](36) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PriceMatrix]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PriceMatrix](
	[PriceMatrixId] [uniqueidentifier] NOT NULL,
	[RecordType] [nvarchar](50) NOT NULL,
	[CurrencyCode] [nvarchar](50) NOT NULL,
	[Warehouse] [nvarchar](50) NOT NULL,
	[UnitOfMeasure] [nvarchar](50) NOT NULL,
	[CustomerKeyPart] [nvarchar](50) NOT NULL,
	[ProductKeyPart] [nvarchar](50) NOT NULL,
	[Active] [datetime] NOT NULL,
	[Deactivate] [datetime] NULL,
	[CalculationFlags] [nvarchar](50) NOT NULL,
	[PriceBasis01] [nvarchar](50) NOT NULL,
	[PriceBasis02] [nvarchar](50) NOT NULL,
	[PriceBasis03] [nvarchar](50) NOT NULL,
	[PriceBasis04] [nvarchar](50) NOT NULL,
	[PriceBasis05] [nvarchar](50) NOT NULL,
	[PriceBasis06] [nvarchar](50) NOT NULL,
	[PriceBasis07] [nvarchar](50) NOT NULL,
	[PriceBasis08] [nvarchar](50) NOT NULL,
	[PriceBasis09] [nvarchar](50) NOT NULL,
	[PriceBasis10] [nvarchar](50) NOT NULL,
	[PriceBasis11] [nvarchar](50) NOT NULL,
	[AdjustmentType01] [nvarchar](50) NOT NULL,
	[AdjustmentType02] [nvarchar](50) NOT NULL,
	[AdjustmentType03] [nvarchar](50) NOT NULL,
	[AdjustmentType04] [nvarchar](50) NOT NULL,
	[AdjustmentType05] [nvarchar](50) NOT NULL,
	[AdjustmentType06] [nvarchar](50) NOT NULL,
	[AdjustmentType07] [nvarchar](50) NOT NULL,
	[AdjustmentType08] [nvarchar](50) NOT NULL,
	[AdjustmentType09] [nvarchar](50) NOT NULL,
	[AdjustmentType10] [nvarchar](50) NOT NULL,
	[AdjustmentType11] [nvarchar](50) NOT NULL,
	[BreakQty01] [decimal](18, 5) NOT NULL,
	[BreakQty02] [decimal](18, 5) NOT NULL,
	[BreakQty03] [decimal](18, 5) NOT NULL,
	[BreakQty04] [decimal](18, 5) NOT NULL,
	[BreakQty05] [decimal](18, 5) NOT NULL,
	[BreakQty06] [decimal](18, 5) NOT NULL,
	[BreakQty07] [decimal](18, 5) NOT NULL,
	[BreakQty08] [decimal](18, 5) NOT NULL,
	[BreakQty09] [decimal](18, 5) NOT NULL,
	[BreakQty10] [decimal](18, 5) NOT NULL,
	[BreakQty11] [decimal](18, 5) NOT NULL,
	[Amount01] [decimal](18, 5) NOT NULL,
	[Amount02] [decimal](18, 5) NOT NULL,
	[Amount03] [decimal](18, 5) NOT NULL,
	[Amount04] [decimal](18, 5) NOT NULL,
	[Amount05] [decimal](18, 5) NOT NULL,
	[Amount06] [decimal](18, 5) NOT NULL,
	[Amount07] [decimal](18, 5) NOT NULL,
	[Amount08] [decimal](18, 5) NOT NULL,
	[Amount09] [decimal](18, 5) NOT NULL,
	[Amount10] [decimal](18, 5) NOT NULL,
	[Amount11] [decimal](18, 5) NOT NULL,
	[AltAmount01] [decimal](18, 5) NOT NULL,
	[AltAmount02] [decimal](18, 5) NOT NULL,
	[AltAmount03] [decimal](18, 5) NOT NULL,
	[AltAmount04] [decimal](18, 5) NOT NULL,
	[AltAmount05] [decimal](18, 5) NOT NULL,
	[AltAmount06] [decimal](18, 5) NOT NULL,
	[AltAmount07] [decimal](18, 5) NOT NULL,
	[AltAmount08] [decimal](18, 5) NOT NULL,
	[AltAmount09] [decimal](18, 5) NOT NULL,
	[AltAmount10] [decimal](18, 5) NOT NULL,
	[AltAmount11] [decimal](18, 5) NOT NULL,
 CONSTRAINT [PK_PriceMatrix] PRIMARY KEY CLUSTERED 
(
	[PriceMatrixId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PriceMatrix_Batch]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PriceMatrix_Batch](
	[PriceMatrixId] [uniqueidentifier] NOT NULL,
	[RecordType] [nvarchar](50) NOT NULL,
	[CurrencyCode] [nvarchar](50) NOT NULL,
	[Warehouse] [nvarchar](50) NOT NULL,
	[UnitOfMeasure] [nvarchar](50) NOT NULL,
	[CustomerKeyPart] [nvarchar](50) NOT NULL,
	[ProductKeyPart] [nvarchar](50) NOT NULL,
	[Active] [datetime] NOT NULL,
	[Deactivate] [datetime] NULL,
	[CalculationFlags] [nvarchar](50) NOT NULL,
	[PriceBasis01] [nvarchar](50) NOT NULL,
	[PriceBasis02] [nvarchar](50) NOT NULL,
	[PriceBasis03] [nvarchar](50) NOT NULL,
	[PriceBasis04] [nvarchar](50) NOT NULL,
	[PriceBasis05] [nvarchar](50) NOT NULL,
	[PriceBasis06] [nvarchar](50) NOT NULL,
	[PriceBasis07] [nvarchar](50) NOT NULL,
	[PriceBasis08] [nvarchar](50) NOT NULL,
	[PriceBasis09] [nvarchar](50) NOT NULL,
	[PriceBasis10] [nvarchar](50) NOT NULL,
	[PriceBasis11] [nvarchar](50) NOT NULL,
	[AdjustmentType01] [nvarchar](50) NOT NULL,
	[AdjustmentType02] [nvarchar](50) NOT NULL,
	[AdjustmentType03] [nvarchar](50) NOT NULL,
	[AdjustmentType04] [nvarchar](50) NOT NULL,
	[AdjustmentType05] [nvarchar](50) NOT NULL,
	[AdjustmentType06] [nvarchar](50) NOT NULL,
	[AdjustmentType07] [nvarchar](50) NOT NULL,
	[AdjustmentType08] [nvarchar](50) NOT NULL,
	[AdjustmentType09] [nvarchar](50) NOT NULL,
	[AdjustmentType10] [nvarchar](50) NOT NULL,
	[AdjustmentType11] [nvarchar](50) NOT NULL,
	[BreakQty01] [decimal](18, 5) NOT NULL,
	[BreakQty02] [decimal](18, 5) NOT NULL,
	[BreakQty03] [decimal](18, 5) NOT NULL,
	[BreakQty04] [decimal](18, 5) NOT NULL,
	[BreakQty05] [decimal](18, 5) NOT NULL,
	[BreakQty06] [decimal](18, 5) NOT NULL,
	[BreakQty07] [decimal](18, 5) NOT NULL,
	[BreakQty08] [decimal](18, 5) NOT NULL,
	[BreakQty09] [decimal](18, 5) NOT NULL,
	[BreakQty10] [decimal](18, 5) NOT NULL,
	[BreakQty11] [decimal](18, 5) NOT NULL,
	[Amount01] [decimal](18, 5) NOT NULL,
	[Amount02] [decimal](18, 5) NOT NULL,
	[Amount03] [decimal](18, 5) NOT NULL,
	[Amount04] [decimal](18, 5) NOT NULL,
	[Amount05] [decimal](18, 5) NOT NULL,
	[Amount06] [decimal](18, 5) NOT NULL,
	[Amount07] [decimal](18, 5) NOT NULL,
	[Amount08] [decimal](18, 5) NOT NULL,
	[Amount09] [decimal](18, 5) NOT NULL,
	[Amount10] [decimal](18, 5) NOT NULL,
	[Amount11] [decimal](18, 5) NOT NULL,
	[AltAmount01] [decimal](18, 5) NOT NULL,
	[AltAmount02] [decimal](18, 5) NOT NULL,
	[AltAmount03] [decimal](18, 5) NOT NULL,
	[AltAmount04] [decimal](18, 5) NOT NULL,
	[AltAmount05] [decimal](18, 5) NOT NULL,
	[AltAmount06] [decimal](18, 5) NOT NULL,
	[AltAmount07] [decimal](18, 5) NOT NULL,
	[AltAmount08] [decimal](18, 5) NOT NULL,
	[AltAmount09] [decimal](18, 5) NOT NULL,
	[AltAmount10] [decimal](18, 5) NOT NULL,
	[AltAmount11] [decimal](18, 5) NOT NULL,
 CONSTRAINT [PK_PriceMatrix_Batch] PRIMARY KEY CLUSTERED 
(
	[PriceMatrixId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Product]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ProductId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Product_ProductId]  DEFAULT (newsequentialid()),
	[Name] [nvarchar](255) NOT NULL,
	[ShortDescription] [nvarchar](2048) NOT NULL CONSTRAINT [DF_Product_ShortDescription]  DEFAULT (''),
	[Description] [nvarchar](max) NOT NULL CONSTRAINT [DF_Product_Description]  DEFAULT (''),
	[ERPDescription] [nvarchar](max) NOT NULL CONSTRAINT [DF_Product_ERPDescription]  DEFAULT (''),
	[ProductCode] [nvarchar](50) NOT NULL CONSTRAINT [DF_Product_ProductCode]  DEFAULT (''),
	[PriceCode] [nvarchar](50) NOT NULL CONSTRAINT [DF_Product_PriceCode]  DEFAULT (''),
	[UnitOfMeasure] [nvarchar](50) NOT NULL CONSTRAINT [DF_Product_UnitOfMeasure]  DEFAULT (''),
	[Sku] [nvarchar](100) NOT NULL CONSTRAINT [DF_Product_Sku]  DEFAULT (''),
	[SmallImagePath] [nvarchar](255) NOT NULL CONSTRAINT [DF_Product_SmallImagePath]  DEFAULT (''),
	[MediumImagePath] [nvarchar](255) NULL CONSTRAINT [DF_Product_MediumImagePath]  DEFAULT (''),
	[LargeImagePath] [nvarchar](255) NOT NULL CONSTRAINT [DF_Product_LargeImagePath]  DEFAULT (''),
	[Drawing] [nvarchar](255) NOT NULL CONSTRAINT [DF_Product_Drawing]  DEFAULT (''),
	[Active] [datetime] NOT NULL CONSTRAINT [DF_Product_Active]  DEFAULT (getdate()),
	[Deactivate] [datetime] NULL,
	[SortOrder] [int] NOT NULL CONSTRAINT [DF_Product_SortOrder]  DEFAULT ((0)),
	[TaxCode1] [nvarchar](50) NOT NULL CONSTRAINT [DF_Product_TaxCode1]  DEFAULT (''),
	[TaxCode2] [nvarchar](50) NOT NULL CONSTRAINT [DF_Product_TaxCode2]  DEFAULT (''),
	[ShippingWeight] [decimal](18, 3) NOT NULL CONSTRAINT [DF_Product_ShippingWeight]  DEFAULT ((0)),
	[ShippingLength] [decimal](18, 3) NOT NULL CONSTRAINT [DF_Product_ShippingLength]  DEFAULT ((0)),
	[ShippingWidth] [decimal](18, 3) NOT NULL CONSTRAINT [DF_Product_ShippingWidth]  DEFAULT ((0)),
	[ShippingHeight] [decimal](18, 3) NOT NULL CONSTRAINT [DF_Product_ShippingHeight]  DEFAULT ((0)),
	[ShippingAmountOverride] [decimal](18, 5) NULL,
	[QtyPerShippingPackage] [int] NOT NULL CONSTRAINT [DF_Product_QtyPerShippingPackage]  DEFAULT ((0)),
	[QtyPerPackageLength] [int] NOT NULL CONSTRAINT [DF_Product_QtyPerPackageLength]  DEFAULT ((1)),
	[QtyPerPackageWidth] [int] NOT NULL CONSTRAINT [DF_Product_QtyPerPackageWidth]  DEFAULT ((1)),
	[QtyPerPackageHeight] [int] NOT NULL CONSTRAINT [DF_Product_QtyPerPackageHeight]  DEFAULT ((1)),
	[MetaKeywords] [nvarchar](max) NOT NULL CONSTRAINT [DF_Product_MetaKeywords]  DEFAULT (''),
	[MetaDescription] [nvarchar](max) NOT NULL CONSTRAINT [DF_Product_MetaDescription]  DEFAULT (''),
	[PageTitle] [nvarchar](max) NOT NULL CONSTRAINT [DF_Product_PageTitle]  DEFAULT (''),
	[ShippingClassification] [nvarchar](100) NOT NULL CONSTRAINT [DF_Product_ShippingClassification]  DEFAULT (''),
	[EachDescription] [nvarchar](255) NOT NULL CONSTRAINT [DF_Product_EachDescription]  DEFAULT (''),
	[PackDescription] [nvarchar](255) NOT NULL CONSTRAINT [DF_Product_PackDescription]  DEFAULT (''),
	[DisplayPricePerPiece] [tinyint] NOT NULL CONSTRAINT [DF_Product_DisplayPricePerPiece]  DEFAULT ((1)),
	[Cost] [decimal](18, 5) NOT NULL CONSTRAINT [DF_Product_Cost]  DEFAULT ((0)),
	[StyleSheet] [nvarchar](255) NOT NULL CONSTRAINT [DF_Product_StyleSheet]  DEFAULT (''),
	[ContentManagerId] [uniqueidentifier] NULL,
	[IsGiftCard] [tinyint] NOT NULL CONSTRAINT [DF_Product_IsGiftCard]  DEFAULT ((0)),
	[AllowAnyGiftCardAmount] [tinyint] NOT NULL CONSTRAINT [DF_Product_AllowAnyGiftCardAmount]  DEFAULT ((0)),
	[ERPNumber] [nvarchar](50) NOT NULL CONSTRAINT [DF_Product_ERPNumber]  DEFAULT (''),
	[OutOfStock] [tinyint] NOT NULL CONSTRAINT [DF_Product_OutOfStock]  DEFAULT ((0)),
	[UPCCode] [nvarchar](50) NOT NULL CONSTRAINT [DF_Product_UPCCode]  DEFAULT (''),
	[ERPManaged] [tinyint] NOT NULL CONSTRAINT [DF_Product_ERPManaged]  DEFAULT ((0)),
	[DocumentManagerId] [uniqueidentifier] NULL,
	[ModelNumber] [nvarchar](50) NOT NULL CONSTRAINT [DF_Product_ModelNumber]  DEFAULT (''),
	[HandlingAmountOverride] [decimal](18, 5) NULL,
	[IsSubscription] [tinyint] NOT NULL CONSTRAINT [DF_Product_IsSubscription]  DEFAULT ((0)),
	[SubscriptionCyclePeriod] [nvarchar](50) NOT NULL CONSTRAINT [DF_Product_SubscriptionCyclePeriod]  DEFAULT (''),
	[SubscriptionPeriodsPerCycle] [int] NOT NULL CONSTRAINT [DF_Product_SubscriptionPeriodsPerCycle]  DEFAULT ((0)),
	[SubscriptionTotalCycles] [int] NOT NULL CONSTRAINT [DF_Product_SubscriptionTotalCycles]  DEFAULT ((0)),
	[SubscriptionFixedPrice] [tinyint] NOT NULL CONSTRAINT [DF_Product_SubscriptionFixedPrice]  DEFAULT ((0)),
	[SubscriptionIncludeInInitialOrder] [tinyint] NOT NULL CONSTRAINT [DF_Product_SubscriptionIncludeInInitialOrder]  DEFAULT ((0)),
	[SubscriptionShipViaId] [uniqueidentifier] NULL,
	[SubscriptionAllMonths] [tinyint] NOT NULL CONSTRAINT [DF_Product_SubscriptionAllMonths]  DEFAULT ((0)),
	[SubscriptionJanuary] [tinyint] NOT NULL CONSTRAINT [DF_Product_SubscriptionJanuary]  DEFAULT ((0)),
	[SubscriptionFebruary] [tinyint] NOT NULL CONSTRAINT [DF_Product_SubscriptionFebruary]  DEFAULT ((0)),
	[SubscriptionMarch] [tinyint] NOT NULL CONSTRAINT [DF_Product_SubscriptionMarch]  DEFAULT ((0)),
	[SubscriptionApril] [tinyint] NOT NULL CONSTRAINT [DF_Product_SubscriptionApril]  DEFAULT ((0)),
	[SubscriptionMay] [tinyint] NOT NULL CONSTRAINT [DF_Product_SubscriptionMay]  DEFAULT ((0)),
	[SubscriptionJune] [tinyint] NOT NULL CONSTRAINT [DF_Product_SubscriptionJune]  DEFAULT ((0)),
	[SubscriptionJuly] [tinyint] NOT NULL CONSTRAINT [DF_Product_SubscriptionJuly]  DEFAULT ((0)),
	[SubscriptionAugust] [tinyint] NOT NULL CONSTRAINT [DF_Product_SubscriptionAugust]  DEFAULT ((0)),
	[SubscriptionSeptember] [tinyint] NOT NULL CONSTRAINT [DF_Product_SubscriptionSeptember]  DEFAULT ((0)),
	[SubscriptionOctober] [tinyint] NOT NULL CONSTRAINT [DF_Product_SubscriptionOctober]  DEFAULT ((0)),
	[SubscriptionNovember] [tinyint] NOT NULL CONSTRAINT [DF_Product_SubscriptionNovember]  DEFAULT ((0)),
	[SubscriptionDecember] [tinyint] NOT NULL CONSTRAINT [DF_Product_SubscriptionDecember]  DEFAULT ((0)),
	[VendorId] [uniqueidentifier] NULL,
	[PriceBasis] [nvarchar](50) NOT NULL CONSTRAINT [DF_Product_PriceBasis]  DEFAULT ('Price'),
	[UserVendorMarkup] [tinyint] NOT NULL CONSTRAINT [DF_Product_UserVendorMarkup]  DEFAULT ((1)),
	[UseVendorMarkup] [tinyint] NOT NULL CONSTRAINT [DF_Product_UseVendorMarkup]  DEFAULT ((1)),
	[TrackInventory] [tinyint] NOT NULL CONSTRAINT [DF_Product_TrackInventory]  DEFAULT ((0)),
	[IsConfigured] [tinyint] NOT NULL CONSTRAINT [DF_Product_IsConfigured]  DEFAULT ((0)),
	[Configuration] [nvarchar](max) NOT NULL CONSTRAINT [DF_Product_Configuration]  DEFAULT (''),
	[TaxCategory] [nvarchar](50) NOT NULL CONSTRAINT [DF_Product_TaxCategory]  DEFAULT (''),
	[BasicListPrice] [decimal](18, 5) NOT NULL CONSTRAINT [DF_Product_BasicListPrice]  DEFAULT ((0)),
	[BasicSalePrice] [decimal](18, 5) NOT NULL CONSTRAINT [DF_Product_BasicSalePrice]  DEFAULT ((0)),
	[BasicSaleStart] [datetime] NULL,
	[BasicSaleEnd] [datetime] NULL,
	[StyleClassId] [uniqueidentifier] NULL,
	[StyleParentId] [uniqueidentifier] NULL,
	[SearchLookup] [nvarchar](max) NOT NULL CONSTRAINT [DF_Product_SearchLookup]  DEFAULT (''),
	[RestrictionGroupId] [uniqueidentifier] NULL,
	[ReplacementProductId] [uniqueidentifier] NULL,
	[HasMsds] [tinyint] NOT NULL CONSTRAINT [DF_Product_HasMsds]  DEFAULT ((0)),
	[IsHazardousGood] [tinyint] NOT NULL CONSTRAINT [DF_Product_IsHazardousGood]  DEFAULT ((0)),
	[IsDiscontinued] [tinyint] NOT NULL CONSTRAINT [DF_Product_IsDiscontinued]  DEFAULT ((0)),
	[ManufacturerItem] [nvarchar](100) NOT NULL CONSTRAINT [DF_Product_ManufacturerItem]  DEFAULT (''),
	[RoundingRule] [nvarchar](50) NOT NULL CONSTRAINT [DF_Product_RoundingRule]  DEFAULT (''),
	[MultipleSaleQty] [int] NOT NULL CONSTRAINT [DF_Product_MultipleSaleQty]  DEFAULT ((0)),
	[Unspsc] [nvarchar](100) NOT NULL CONSTRAINT [DF_Product_Unspsc]  DEFAULT (''),
	[IsSpecialOrder] [tinyint] NOT NULL CONSTRAINT [DF_Product_IsSpecialOrder]  DEFAULT ((0)),
	[IsFixedConfiguration] [tinyint] NOT NULL CONSTRAINT [DF_Product_IsFixedConfiguration]  DEFAULT ((0)),
	[ConfigurationId] [uniqueidentifier] NULL,
	[IndexStatus] [tinyint] NOT NULL CONSTRAINT [DF_Product_IndexStatus]  DEFAULT ((0)),
	[QuoteOption] [tinyint] NOT NULL CONSTRAINT [DF_Product_QuoteOption]  DEFAULT ((0)),
	[AltText] [nvarchar](max) NOT NULL CONSTRAINT [DF_Product_AltText]  DEFAULT (''),
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductCost]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductCost](
	[ProductCostId] [uniqueidentifier] NOT NULL,
	[ProductId] [uniqueidentifier] NOT NULL,
	[SiteName] [nvarchar](50) NOT NULL,
	[Cost] [decimal](19, 5) NOT NULL,
 CONSTRAINT [PK_ProductCost] PRIMARY KEY CLUSTERED 
(
	[ProductCostId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductFilterValue]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductFilterValue](
	[ProductId] [uniqueidentifier] NOT NULL,
	[FilterValueId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_ProductFilterValue] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC,
	[FilterValueId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductPrice]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductPrice](
	[ProductPriceId] [uniqueidentifier] NOT NULL,
	[ProductId] [uniqueidentifier] NOT NULL,
	[BreakQty] [decimal](18, 5) NOT NULL,
	[Price] [decimal](18, 5) NOT NULL,
	[Active] [datetime] NOT NULL,
	[Deactivate] [datetime] NULL,
	[PricePerPiece] [decimal](18, 5) NOT NULL,
	[IsOnSale] [tinyint] NOT NULL,
	[SalePrice] [decimal](18, 5) NOT NULL,
	[RegularMarkup] [decimal](18, 5) NOT NULL,
	[SaleMarkup] [decimal](18, 5) NOT NULL,
	[CurrencyCode] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ProductPrice] PRIMARY KEY CLUSTERED 
(
	[ProductPriceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductProductAccessory]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductProductAccessory](
	[ProductId] [uniqueidentifier] NOT NULL,
	[ProductAccessoryId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK__ProductProductAc__6F7569AA] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC,
	[ProductAccessoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductProductCrossSell]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductProductCrossSell](
	[ProductId] [uniqueidentifier] NOT NULL,
	[CrossSellProductId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_ProductProductCrossSell] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC,
	[CrossSellProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductProperty]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductProperty](
	[ProductPropertyId] [uniqueidentifier] NOT NULL,
	[ProductId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Value] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_ProductProperty] PRIMARY KEY CLUSTERED 
(
	[ProductPropertyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductSpecification]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductSpecification](
	[ProductId] [uniqueidentifier] NOT NULL,
	[SpecificationId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_ProductSpecification] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC,
	[SpecificationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductTaxExemption]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductTaxExemption](
	[ProductId] [uniqueidentifier] NOT NULL,
	[TaxExemptionId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_ProductTaxExemption] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC,
	[TaxExemptionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductUnitOfMeasure]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductUnitOfMeasure](
	[ProductUnitOfMeasureId] [uniqueidentifier] NOT NULL,
	[ProductId] [uniqueidentifier] NOT NULL,
	[UnitOfMeasure] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[QtyPerBaseUnitOfMeasure] [decimal](18, 9) NOT NULL,
	[RoundingRule] [nvarchar](100) NOT NULL,
	[IsDefault] [tinyint] NOT NULL,
 CONSTRAINT [PK_ProductUnitOfMeasure] PRIMARY KEY CLUSTERED 
(
	[ProductUnitOfMeasureId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductWarehouse]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductWarehouse](
	[ProductWarehouseId] [uniqueidentifier] NOT NULL,
	[ProductId] [uniqueidentifier] NOT NULL,
	[WarehouseId] [uniqueidentifier] NOT NULL,
	[ErpQtyAvailable] [decimal](18, 5) NOT NULL,
	[QtyOnOrder] [decimal](18, 5) NOT NULL,
	[SafetyStock] [decimal](18, 5) NOT NULL,
	[UnitCost] [decimal](18, 5) NOT NULL,
	[IsDiscontinued] [tinyint] NOT NULL,
 CONSTRAINT [PK_ProductWarehouse] PRIMARY KEY CLUSTERED 
(
	[ProductWarehouseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Promotion]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Promotion](
	[PromotionId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Promotion_PromotionId]  DEFAULT (newsequentialid()),
	[Name] [nvarchar](50) NOT NULL CONSTRAINT [DF_Promotion_Name]  DEFAULT (''),
	[DisplayMessage] [nvarchar](max) NOT NULL CONSTRAINT [DF_Promotion_DisplayMessage]  DEFAULT (''),
	[Description] [nvarchar](max) NOT NULL CONSTRAINT [DF_Promotion_Description]  DEFAULT (''),
	[DiscountAmount] [decimal](18, 3) NOT NULL CONSTRAINT [DF_Promotion_Amount]  DEFAULT ((0)),
	[Active] [datetime] NOT NULL CONSTRAINT [DF_Table_1_ActiveDate]  DEFAULT (getdate()),
	[Deactivate] [datetime] NULL,
	[PromoCode] [nvarchar](50) NOT NULL CONSTRAINT [DF_Promotion_PromoCode]  DEFAULT (''),
	[IsPercentage] [tinyint] NOT NULL CONSTRAINT [DF_Promotion_IsPercentage]  DEFAULT ((1)),
	[IsFreight] [tinyint] NOT NULL CONSTRAINT [DF_Promotion_IsFreight]  DEFAULT ((0)),
	[IsAutomatic] [tinyint] NOT NULL CONSTRAINT [DF_Table_1_AutomaticPromo]  DEFAULT ((0)),
	[Rank] [decimal](18, 5) NOT NULL CONSTRAINT [DF_Promotion_Rank]  DEFAULT ((0)),
	[IsActive] [tinyint] NOT NULL CONSTRAINT [DF_Promotion_IsActive]  DEFAULT ((0)),
 CONSTRAINT [PK_Promotion] PRIMARY KEY CLUSTERED 
(
	[PromotionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PromotionCode]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PromotionCode](
	[PromotionCodeId] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[CustomerOrderId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_PromotionCode] PRIMARY KEY CLUSTERED 
(
	[PromotionCodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PromotionResult]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PromotionResult](
	[PromotionResultId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_PromotionResult_PromotionResultId]  DEFAULT (newsequentialid()),
	[PromotionId] [uniqueidentifier] NOT NULL,
	[ProductId] [uniqueidentifier] NULL,
	[Amount] [decimal](18, 5) NULL,
	[PromotionResultType] [nvarchar](100) NOT NULL CONSTRAINT [DF_PromotionResult_PromotionResultType]  DEFAULT (''),
	[Visible] [tinyint] NOT NULL CONSTRAINT [DF_PromotionResult_Visible]  DEFAULT ((1)),
	[ShipViaId] [uniqueidentifier] NULL,
	[CategoryId] [uniqueidentifier] NULL,
	[MaxValue] [decimal](18, 5) NULL CONSTRAINT [DF_PromotionResult_MaxValue]  DEFAULT ((0)),
	[IsPercent] [tinyint] NULL,
	[VendorId] [uniqueidentifier] NULL,
	[CustomResultName] [nvarchar](255) NULL CONSTRAINT [DF_PromotionResult_CustomResultName]  DEFAULT (''),
	[Code] [nvarchar](255) NULL CONSTRAINT [DF_PromotionResult_Code]  DEFAULT (''),
 CONSTRAINT [PK_PromotionResult] PRIMARY KEY CLUSTERED 
(
	[PromotionResultId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PromotionRule]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PromotionRule](
	[PromotionRuleId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_PromotionRule_PromotionRuleId]  DEFAULT (newsequentialid()),
	[PromotionId] [uniqueidentifier] NOT NULL,
	[PromotionRuleType] [nvarchar](50) NOT NULL CONSTRAINT [DF_PromotionRule_PromotionRuleType]  DEFAULT (''),
	[Amount] [decimal](18, 5) NULL CONSTRAINT [DF_PromotionRule_Amount]  DEFAULT ((0)),
	[ProductId] [uniqueidentifier] NULL,
	[ShipViaId] [uniqueidentifier] NULL,
	[ExecutionGroup] [int] NOT NULL CONSTRAINT [DF_Table3_Group]  DEFAULT ((0)),
	[ExecutionOrder] [int] NOT NULL CONSTRAINT [DF_PromotionRule_ExecutionOrder]  DEFAULT ((0)),
	[Condition] [nvarchar](50) NOT NULL CONSTRAINT [DF_PromotionRule_]  DEFAULT ('AND'),
	[LowerRange] [decimal](18, 5) NULL CONSTRAINT [DF_PromotionRule_LowerRange]  DEFAULT ((0)),
	[UpperRange] [decimal](18, 5) NULL CONSTRAINT [DF_PromotionRule_UpperRange]  DEFAULT ((0)),
	[Code] [nvarchar](50) NULL CONSTRAINT [DF_PromotionRule_Code]  DEFAULT (''),
	[AffiliateId] [uniqueidentifier] NULL,
	[CountryId] [uniqueidentifier] NULL,
	[CustomerId] [uniqueidentifier] NULL,
	[PaymentTermId] [uniqueidentifier] NULL,
	[ContainedPromotionId] [uniqueidentifier] NULL,
	[SalesmanId] [uniqueidentifier] NULL,
	[StateId] [uniqueidentifier] NULL,
	[UserProfileId] [uniqueidentifier] NULL,
	[CategoryId] [uniqueidentifier] NULL,
	[VendorId] [uniqueidentifier] NULL,
	[FromDateTime] [datetime] NULL,
	[ToDateTime] [datetime] NULL,
	[CurrencyId] [uniqueidentifier] NULL,
	[CustomRuleName] [nvarchar](255) NULL CONSTRAINT [DF_PromotionRule_CustomRuleName]  DEFAULT (''),
	[PersonaId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_PromotionRule] PRIMARY KEY CLUSTERED 
(
	[PromotionRuleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PunchOutCustomerUserProfileMap]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PunchOutCustomerUserProfileMap](
	[PunchOutCustomerUserProfileMapId] [uniqueidentifier] NOT NULL,
	[AddressId] [nvarchar](50) NOT NULL,
	[UserProfileId] [uniqueidentifier] NOT NULL,
	[CustomerId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_PunchOutCustomerUserProfileMap] PRIMARY KEY CLUSTERED 
(
	[PunchOutCustomerUserProfileMapId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PunchOutOrderRequest]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PunchOutOrderRequest](
	[PunchOutOrderRequestId] [uniqueidentifier] NOT NULL,
	[FromIdentity] [nvarchar](256) NOT NULL,
	[ToIdentity] [nvarchar](256) NOT NULL,
	[SenderIdentity] [nvarchar](256) NOT NULL,
	[FromUserAgent] [nvarchar](512) NOT NULL,
	[OrderId] [nvarchar](256) NOT NULL,
	[OrderDate] [nvarchar](128) NOT NULL,
	[OrderType] [nvarchar](64) NOT NULL,
	[OrderVersion] [nvarchar](64) NOT NULL,
	[IsInternalVersion] [nvarchar](50) NOT NULL,
	[AgreementId] [nvarchar](64) NOT NULL,
	[AgreementPayloadId] [nvarchar](64) NOT NULL,
	[ParentAgreementId] [nvarchar](64) NOT NULL,
	[ParentAgreementPayloadId] [nvarchar](64) NOT NULL,
	[EffectiveDate] [nvarchar](64) NOT NULL,
	[ExpirationDate] [nvarchar](64) NOT NULL,
	[RequisitionId] [nvarchar](64) NOT NULL,
	[ShipComplete] [nvarchar](50) NOT NULL,
	[ReleaseRequired] [nvarchar](50) NOT NULL,
	[Type] [nvarchar](64) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[PunchOutOrderRequestCXml] [nvarchar](max) NOT NULL,
	[Total] [nvarchar](50) NOT NULL,
	[TotalCurrency] [nvarchar](50) NOT NULL,
	[Shipping] [nvarchar](50) NOT NULL,
	[ShippingCurrency] [nvarchar](50) NOT NULL,
	[ShippingDescription] [nvarchar](max) NOT NULL,
	[BillToAddressId] [nvarchar](50) NOT NULL,
	[BillToName] [nvarchar](512) NOT NULL,
	[BillToStreet] [nvarchar](256) NOT NULL,
	[BillToCity] [nvarchar](128) NOT NULL,
	[BillToState] [nvarchar](128) NOT NULL,
	[BillToPostalCode] [nvarchar](50) NOT NULL,
	[BillToIsoCountryCode] [nvarchar](50) NOT NULL,
	[BillToCountry] [nvarchar](128) NOT NULL,
	[ShipToAddressId] [nvarchar](50) NOT NULL,
	[ShipToName] [nvarchar](512) NOT NULL,
	[ShipToStreet] [nvarchar](256) NOT NULL,
	[ShipToCity] [nvarchar](128) NOT NULL,
	[ShipToState] [nvarchar](128) NOT NULL,
	[ShipToPostalCode] [nvarchar](50) NOT NULL,
	[ShipToIsoCountryCode] [nvarchar](50) NOT NULL,
	[ShipToCountry] [nvarchar](128) NOT NULL,
	[BillToDeliver1] [nvarchar](128) NOT NULL,
	[ShipToDeliver1] [nvarchar](128) NOT NULL,
	[ShipToDeliver2] [nvarchar](128) NOT NULL,
	[BillToDeliver2] [nvarchar](128) NOT NULL,
	[Comments] [nvarchar](max) NOT NULL,
	[BillToEmail] [nvarchar](max) NOT NULL,
	[ShipToEmail] [nvarchar](max) NOT NULL,
	[CustomerOrderId] [uniqueidentifier] NULL,
	[UserProfileId] [uniqueidentifier] NULL,
	[BillToStreet2] [nvarchar](max) NOT NULL,
	[BillToStreet3] [nvarchar](max) NOT NULL,
	[BillToStreet4] [nvarchar](max) NOT NULL,
	[BillToTelephoneNumber] [nvarchar](max) NOT NULL,
	[BillToTelephoneIsoCountryCode] [nvarchar](max) NOT NULL,
	[BillToTelephoneAreaOrCityCode] [nvarchar](max) NOT NULL,
	[ShipToStreet2] [nvarchar](max) NOT NULL,
	[ShipToStreet3] [nvarchar](max) NOT NULL,
	[ShipToStreet4] [nvarchar](max) NOT NULL,
	[ShipToTelephoneNumber] [nvarchar](max) NOT NULL,
	[ShipToTelephoneIsoCountryCode] [nvarchar](max) NOT NULL,
	[ShipToTelephoneAreaOrCityCode] [nvarchar](max) NOT NULL,
	[PunchOutSessionId] [uniqueidentifier] NULL,
	[BillToTelephoneCountryCode] [nvarchar](5) NOT NULL,
	[ShipToTelephoneCountryCode] [nvarchar](5) NOT NULL,
	[OrderResponse] [nvarchar](max) NOT NULL,
	[CustomerPo] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_PunchOutOrderRequest] PRIMARY KEY CLUSTERED 
(
	[PunchOutOrderRequestId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PunchOutOrderRequestExtrinsic]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PunchOutOrderRequestExtrinsic](
	[PunchOutOrderRequestExtrinsicId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
	[Value] [nvarchar](max) NOT NULL,
	[PunchOutOrderRequestId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_PunchOutOrderRequestExtrinsic] PRIMARY KEY CLUSTERED 
(
	[PunchOutOrderRequestExtrinsicId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PunchOutOrderRequestItemOut]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PunchOutOrderRequestItemOut](
	[PunchOutOrderRequestItemOutId] [uniqueidentifier] NOT NULL,
	[PunchOutOrderRequestId] [uniqueidentifier] NOT NULL,
	[SupplierPartId] [nvarchar](256) NOT NULL,
	[SupplierPartAuxiliaryId] [nvarchar](256) NOT NULL,
	[Quantity] [nvarchar](50) NOT NULL,
	[LineNumber] [nvarchar](50) NOT NULL,
	[RequisitionId] [nvarchar](50) NOT NULL,
	[AgreementItemNumber] [nvarchar](50) NOT NULL,
	[RequestedDeliveryDate] [nvarchar](50) NOT NULL,
	[IsAdHoc] [nvarchar](50) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[UnitPrice] [nvarchar](50) NOT NULL,
	[UnitPriceCurrency] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[UnitOfMeasure] [nvarchar](50) NOT NULL,
	[Classification] [nvarchar](50) NOT NULL,
	[ClassificationDomain] [nvarchar](50) NOT NULL,
	[ManufacturerPartId] [nvarchar](128) NOT NULL,
	[ManufacturerName] [nvarchar](512) NOT NULL,
	[Url] [nvarchar](1024) NOT NULL,
	[BillToAddressId] [nvarchar](50) NOT NULL,
	[BillToName] [nvarchar](512) NOT NULL,
	[BillToStreet] [nvarchar](256) NOT NULL,
	[BillToCity] [nvarchar](128) NOT NULL,
	[BillToState] [nvarchar](128) NOT NULL,
	[BillToPostalCode] [nvarchar](50) NOT NULL,
	[BillToIsoCountryCode] [nvarchar](50) NOT NULL,
	[BillToCountry] [nvarchar](128) NOT NULL,
	[BillToDeliver1] [nvarchar](128) NOT NULL,
	[BillToDeliver2] [nvarchar](128) NOT NULL,
	[ShipToAddressId] [nvarchar](50) NOT NULL,
	[ShipToName] [nvarchar](512) NOT NULL,
	[ShipToStreet] [nvarchar](256) NOT NULL,
	[ShipToCity] [nvarchar](128) NOT NULL,
	[ShipToState] [nvarchar](128) NOT NULL,
	[ShipToPostalCode] [nvarchar](50) NOT NULL,
	[ShipToIsoCountryCode] [nvarchar](50) NOT NULL,
	[ShipToCountry] [nvarchar](128) NOT NULL,
	[ShipToDeliver1] [nvarchar](128) NOT NULL,
	[ShipToDeliver2] [nvarchar](128) NOT NULL,
	[BillToStreet2] [nvarchar](max) NOT NULL,
	[BillToStreet3] [nvarchar](max) NOT NULL,
	[BillToStreet4] [nvarchar](max) NOT NULL,
	[ShipToStreet2] [nvarchar](max) NOT NULL,
	[ShipToStreet3] [nvarchar](max) NOT NULL,
	[ShipToStreet4] [nvarchar](max) NOT NULL,
	[OrderLineId] [uniqueidentifier] NULL,
	[Comments] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_PunchOutOrderRequestItemOut] PRIMARY KEY CLUSTERED 
(
	[PunchOutOrderRequestItemOutId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PunchOutOrderRequestValidationMessage]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PunchOutOrderRequestValidationMessage](
	[PunchOutOrderRequestValidationMessageId] [uniqueidentifier] NOT NULL,
	[PunchOutOrderRequestValidationMessageType] [nvarchar](128) NOT NULL,
	[Message] [nvarchar](max) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[PunchOutOrderRequestId] [uniqueidentifier] NULL,
	[PunchOutOrderRequestItemOutId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_PunchOutOrderRequestValidationMessage] PRIMARY KEY CLUSTERED 
(
	[PunchOutOrderRequestValidationMessageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PunchOutSession]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PunchOutSession](
	[PunchOutSessionId] [uniqueidentifier] NOT NULL,
	[UserProfileId] [uniqueidentifier] NOT NULL,
	[CustomerOrderId] [uniqueidentifier] NOT NULL,
	[FromIdentity] [nvarchar](255) NOT NULL,
	[ToIdentity] [nvarchar](255) NOT NULL,
	[SenderIdentity] [nvarchar](255) NOT NULL,
	[FromUserAgent] [nvarchar](255) NOT NULL,
	[BuyerCookie] [nvarchar](255) NOT NULL,
	[BrowserFormPost] [nvarchar](1024) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[Domain] [nvarchar](1024) NOT NULL,
	[PunchOutSessionMode] [nvarchar](50) NOT NULL,
	[ToIdentityNode] [nvarchar](1024) NOT NULL,
	[FromIdentityNode] [nvarchar](1024) NOT NULL,
	[SenderIdentityNode] [nvarchar](1024) NOT NULL,
	[ShipToAddressId] [nvarchar](1024) NOT NULL,
	[ShipToName] [nvarchar](1024) NOT NULL,
	[ShipToDeliverTo] [nvarchar](1024) NOT NULL,
	[ShipToStreet] [nvarchar](1024) NOT NULL,
	[ShipToCity] [nvarchar](1024) NOT NULL,
	[ShipToState] [nvarchar](1024) NOT NULL,
	[ShipToPostalCode] [nvarchar](1024) NOT NULL,
	[ShipToIsoCountryCode] [nvarchar](1024) NOT NULL,
	[ShipToCountry] [nvarchar](1024) NOT NULL,
	[ShipAddressIdResolved] [tinyint] NOT NULL,
 CONSTRAINT [PK_PunchOutSession] PRIMARY KEY CLUSTERED 
(
	[PunchOutSessionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PunchOutSessionAccess]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PunchOutSessionAccess](
	[PunchOutSessionAccessId] [uniqueidentifier] NOT NULL,
	[IpAddress] [nvarchar](50) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[PunchOutSessionId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_PunchOutSessionAccess] PRIMARY KEY CLUSTERED 
(
	[PunchOutSessionAccessId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PunchOutSessionExtrinsic]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PunchOutSessionExtrinsic](
	[PunchOutSessionExtrinsicId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
	[Value] [nvarchar](max) NOT NULL,
	[PunchOutSessionId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_PunchOutSessionExtrinsic] PRIMARY KEY CLUSTERED 
(
	[PunchOutSessionExtrinsicId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PunchOutSessionItemIn]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PunchOutSessionItemIn](
	[PunchOutSessionItemInId] [uniqueidentifier] NOT NULL,
	[SupplierPartId] [nvarchar](256) NOT NULL,
	[SupplierPartAuxiliaryId] [nvarchar](256) NOT NULL,
	[PunchOutSessionId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_PunchOutSessionItemIn] PRIMARY KEY CLUSTERED 
(
	[PunchOutSessionItemInId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PunchOutSetupRequest]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PunchOutSetupRequest](
	[PunchOutSetupRequestId] [uniqueidentifier] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[PunchOutSetupRequestCXml] [nvarchar](max) NOT NULL,
	[PunchOutSessionId] [uniqueidentifier] NULL,
	[IpAddress] [nvarchar](50) NOT NULL,
	[SetupRequestResponse] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_PunchOutSetupRequest] PRIMARY KEY CLUSTERED 
(
	[PunchOutSetupRequestId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Restriction]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Restriction](
	[RestrictionId] [uniqueidentifier] NOT NULL,
	[IsActive] [tinyint] NOT NULL,
	[StateId] [uniqueidentifier] NULL,
	[ProductId] [uniqueidentifier] NULL,
	[CategoryId] [uniqueidentifier] NULL,
	[Name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Restriction] PRIMARY KEY CLUSTERED 
(
	[RestrictionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RestrictionGroup]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RestrictionGroup](
	[RestrictionGroupId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](2048) NOT NULL,
	[DefaultCondition] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_RestrictionGroup] PRIMARY KEY CLUSTERED 
(
	[RestrictionGroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_RestrictionGroup] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Review]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Review](
	[ReviewId] [uniqueidentifier] NOT NULL,
	[CategoryId] [uniqueidentifier] NULL,
	[ContentManagerId] [uniqueidentifier] NULL,
	[UserProfileId] [uniqueidentifier] NULL,
	[ProductId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](255) NOT NULL,
	[Active] [datetime] NOT NULL,
	[Deactivate] [datetime] NOT NULL,
 CONSTRAINT [PK_Review] PRIMARY KEY CLUSTERED 
(
	[ReviewId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RuleClause]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RuleClause](
	[RuleClauseId] [uniqueidentifier] NOT NULL,
	[RuleManagerId] [uniqueidentifier] NOT NULL,
	[RuleTypeOptionId] [uniqueidentifier] NOT NULL,
	[ExecutionGroup] [int] NOT NULL,
	[ExecutionOrder] [int] NOT NULL,
	[Condition] [nvarchar](50) NOT NULL,
	[CriteriaType] [nvarchar](50) NOT NULL,
	[CriteriaObject] [nvarchar](255) NOT NULL,
	[CriteriaProperty] [nvarchar](100) NOT NULL,
	[CriteriaValue] [nvarchar](255) NOT NULL,
	[ComparisonOperator] [nvarchar](50) NOT NULL,
	[SimpleValue] [nvarchar](2048) NOT NULL,
	[ValueList] [nvarchar](2048) NOT NULL,
	[ValueMinimum] [nvarchar](100) NOT NULL,
	[ValueMaximum] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_RuleClause] PRIMARY KEY CLUSTERED 
(
	[RuleClauseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RuleManager]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RuleManager](
	[RuleManagerId] [uniqueidentifier] NOT NULL,
	[RuleTypeId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_RulesManager] PRIMARY KEY CLUSTERED 
(
	[RuleManagerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RuleType]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RuleType](
	[RuleTypeId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_RuleType_RuleTypeId]  DEFAULT (newsequentialid()),
	[Name] [nvarchar](50) NOT NULL CONSTRAINT [DF_RuleType_Name]  DEFAULT (''),
 CONSTRAINT [PK_RuleType] PRIMARY KEY CLUSTERED 
(
	[RuleTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RuleTypeOption]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RuleTypeOption](
	[RuleTypeOptionId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_RuleTypeOption_RuleTypeOptionId]  DEFAULT (newsequentialid()),
	[RuleTypeId] [uniqueidentifier] NOT NULL,
	[Description] [nvarchar](2048) NOT NULL CONSTRAINT [DF_RuleTypeOption_Description]  DEFAULT (''),
	[CriteriaType] [nvarchar](50) NOT NULL CONSTRAINT [DF_RuleTypeOption_CriteriaType]  DEFAULT (''),
	[CriteriaObject] [nvarchar](255) NOT NULL CONSTRAINT [DF_RuleTypeOption_CriteriaObject]  DEFAULT (''),
	[CriteriaProperty] [nvarchar](255) NOT NULL CONSTRAINT [DF_RuleTypeOption_CriteriaProperty]  DEFAULT (''),
	[ValueType] [nvarchar](50) NOT NULL CONSTRAINT [DF_RuleTypeOption_ValueType]  DEFAULT (''),
 CONSTRAINT [PK_RuleTypeOption] PRIMARY KEY CLUSTERED 
(
	[RuleTypeOptionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Salesman]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Salesman](
	[SalesmanId] [uniqueidentifier] NOT NULL,
	[SalesmanNumber] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[SalesClass] [nvarchar](50) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[SalesManager] [nvarchar](50) NOT NULL,
	[ReferenceNumber] [nvarchar](50) NOT NULL,
	[Outside] [tinyint] NOT NULL,
	[SalesPeriodToDate] [decimal](18, 5) NOT NULL,
	[SalesYearToDate] [decimal](18, 5) NOT NULL,
	[Email] [nvarchar](128) NOT NULL,
	[Phone1] [nvarchar](50) NOT NULL,
	[Phone2] [nvarchar](50) NOT NULL,
	[Title] [nvarchar](100) NOT NULL,
	[ParentId] [uniqueidentifier] NULL,
	[UserProfileId] [uniqueidentifier] NULL,
	[ImagePath] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[MinMarginAllowed] [decimal](18, 5) NOT NULL,
	[MaxDiscountPercent] [decimal](18, 5) NOT NULL,
 CONSTRAINT [PK_Salesman] PRIMARY KEY CLUSTERED 
(
	[SalesmanId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ScheduledTask]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ScheduledTask](
	[ScheduledTaskId] [uniqueidentifier] NOT NULL,
	[Type] [nvarchar](50) NOT NULL,
	[Parameter] [nvarchar](max) NOT NULL,
	[RunDateTime] [datetime] NOT NULL,
	[LastRunDateTime] [datetime] NULL,
	[MinuteInterval] [int] NOT NULL,
	[IsRealTime] [tinyint] NOT NULL,
	[LastFinishedDateTime] [datetime] NULL,
	[ReturnAction] [int] NOT NULL,
	[ResultData] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_ScheduledTask] PRIMARY KEY CLUSTERED 
(
	[ScheduledTaskId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SearchSynonym]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SearchSynonym](
	[SearchSynonymId] [uniqueidentifier] NOT NULL,
	[Word] [nvarchar](255) NOT NULL,
	[Synonym] [nvarchar](255) NOT NULL,
	[Bidirectional] [tinyint] NOT NULL,
	[LanguageCode] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_SearchSynonymId] PRIMARY KEY CLUSTERED 
(
	[SearchSynonymId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SeqBatchNumber]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SeqBatchNumber](
	[SeqBatchNumber] [int] IDENTITY(1,1) NOT NULL,
	[Prefix] [nvarchar](50) NOT NULL CONSTRAINT [DF_SeqBatchNumber_Prefix]  DEFAULT (''),
 CONSTRAINT [PK_SeqBatchNumber] PRIMARY KEY CLUSTERED 
(
	[SeqBatchNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SeqContentKey]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SeqContentKey](
	[SeqContentKey] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_SeqContentKey] PRIMARY KEY CLUSTERED 
(
	[SeqContentKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SeqCustomerNumber]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SeqCustomerNumber](
	[SeqCustomerNumber] [int] IDENTITY(1,1) NOT NULL,
	[Prefix] [nvarchar](50) NOT NULL CONSTRAINT [DF_SeqCustomerNumber_Prefix]  DEFAULT (''),
 CONSTRAINT [PK_SeqCustomerNumber] PRIMARY KEY CLUSTERED 
(
	[SeqCustomerNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SeqOrderNumber]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SeqOrderNumber](
	[SeqOrderNumber] [int] IDENTITY(1,1) NOT NULL,
	[Prefix] [nvarchar](50) NOT NULL CONSTRAINT [DF_SeqOrderNumber_Prefix]  DEFAULT (''),
 CONSTRAINT [PK_SeqOrderNumber] PRIMARY KEY CLUSTERED 
(
	[SeqOrderNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ShipCharge]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShipCharge](
	[ShipChargeId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_ShipCharge_ShipChargeId]  DEFAULT (newsequentialid()),
	[CarrierId] [uniqueidentifier] NULL,
	[ShipViaId] [uniqueidentifier] NULL,
	[Name] [nvarchar](100) NOT NULL CONSTRAINT [DF_ShipCharge_Name]  DEFAULT (''),
	[Description] [nvarchar](max) NOT NULL,
	[Enable] [tinyint] NOT NULL CONSTRAINT [DF_ShipCharge_Enable]  DEFAULT ((0)),
	[ShipChargeType] [nvarchar](50) NOT NULL CONSTRAINT [DF_ShipCharge_ShipChargeType]  DEFAULT (''),
	[Charge] [decimal](18, 5) NOT NULL CONSTRAINT [DF_ShipCharge_Charge]  DEFAULT ((0)),
 CONSTRAINT [PK_ShipCharge] PRIMARY KEY CLUSTERED 
(
	[ShipChargeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Shipment]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shipment](
	[ShipmentId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Shipment_ShipmentId]  DEFAULT (newsequentialid()),
	[ShipmentNumber] [nvarchar](50) NOT NULL CONSTRAINT [DF_Shipment_ShipmentNumber]  DEFAULT (''),
	[ShipmentDate] [datetime] NOT NULL CONSTRAINT [DF_Shipment_ShipmentDate]  DEFAULT (getdate()),
	[EmailSent] [datetime] NULL,
	[ASNSent] [datetime] NULL,
	[WebOrderNumber] [nvarchar](50) NOT NULL CONSTRAINT [DF_Shipment_WebOrderNumber]  DEFAULT (''),
	[ERPOrderNumber] [nvarchar](50) NOT NULL CONSTRAINT [DF_Shipment_ERPOrderNumber]  DEFAULT (''),
 CONSTRAINT [PK_Shipment] PRIMARY KEY CLUSTERED 
(
	[ShipmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ShipmentPackage]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShipmentPackage](
	[ShipmentPackageId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_ShipmentPackage_ShipmentPackageId]  DEFAULT (newsequentialid()),
	[ShipmentId] [uniqueidentifier] NOT NULL,
	[Carrier] [nvarchar](100) NOT NULL CONSTRAINT [DF_ShipmentPackage_Carrier]  DEFAULT (''),
	[TrackingNumber] [nvarchar](50) NOT NULL CONSTRAINT [DF_ShipmentPackage_TrackingNumber]  DEFAULT (''),
	[Freight] [decimal](18, 5) NOT NULL CONSTRAINT [DF_ShipmentPackage_Freight]  DEFAULT ((0)),
	[PackageNumber] [nvarchar](100) NOT NULL CONSTRAINT [DF_ShipmentPackage_PackageNumber]  DEFAULT (''),
	[ShipVia] [nvarchar](100) NOT NULL CONSTRAINT [DF_ShipmentPackage_ShipVia]  DEFAULT (''),
 CONSTRAINT [PK_ShipmentPackage] PRIMARY KEY CLUSTERED 
(
	[ShipmentPackageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ShippingClassification]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShippingClassification](
	[ShippingClassificationId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Classification] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_ShippingClassification] PRIMARY KEY CLUSTERED 
(
	[ShippingClassificationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ShipRate]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShipRate](
	[ShipRateId] [uniqueidentifier] NOT NULL,
	[ShipViaId] [uniqueidentifier] NOT NULL,
	[OrderAmount] [decimal](18, 5) NOT NULL,
	[ChargeAmount] [decimal](18, 5) NOT NULL,
	[PerEach] [tinyint] NOT NULL,
 CONSTRAINT [PK_ShipRate] PRIMARY KEY CLUSTERED 
(
	[ShipRateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ShipRule]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShipRule](
	[ShipRuleId] [uniqueidentifier] NOT NULL,
	[CarrierId] [uniqueidentifier] NULL,
	[ShipViaId] [uniqueidentifier] NULL,
	[ShipRateId] [uniqueidentifier] NULL,
	[Zip] [nvarchar](50) NULL,
	[StateId] [uniqueidentifier] NULL,
	[CountryId] [uniqueidentifier] NULL,
	[MinimumAmount] [decimal](18, 5) NULL,
	[MaximumAmount] [decimal](18, 5) NULL,
	[ZipLowerRange] [nvarchar](50) NULL,
	[ZipUpperRange] [nvarchar](50) NULL,
	[CustomerId] [uniqueidentifier] NULL,
	[ShipRuleType] [nvarchar](max) NOT NULL,
	[ExecutionGroup] [int] NOT NULL,
	[ExecutionOrder] [int] NOT NULL,
	[Condition] [nvarchar](50) NOT NULL,
	[CategoryId] [uniqueidentifier] NULL,
	[ProductId] [uniqueidentifier] NULL,
	[DayOfWeek] [int] NULL,
	[TermsCode] [nvarchar](150) NOT NULL,
	[CustomerType] [nvarchar](50) NULL,
	[CustomRuleName] [nvarchar](255) NULL,
 CONSTRAINT [PK_ShipRule] PRIMARY KEY CLUSTERED 
(
	[ShipRuleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ShipVia]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShipVia](
	[ShipViaId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_ShipVia_ShipViaId]  DEFAULT (newsequentialid()),
	[CarrierId] [uniqueidentifier] NOT NULL,
	[ShipCode] [nvarchar](50) NOT NULL CONSTRAINT [DF_ShipVia_ShipCode]  DEFAULT (''),
	[Description] [nvarchar](100) NOT NULL CONSTRAINT [DF_ShipVia_Description]  DEFAULT (''),
	[Active] [datetime] NOT NULL CONSTRAINT [DF_ShipVia_Active]  DEFAULT (getdate()),
	[Deactivate] [datetime] NULL,
	[Enable] [tinyint] NOT NULL CONSTRAINT [DF_ShipVia_Enable]  DEFAULT ((0)),
	[ErpShipCode] [nvarchar](50) NOT NULL CONSTRAINT [DF_ShipVia_ErpShipCode]  DEFAULT (''),
	[ChargeAmount] [decimal](18, 5) NOT NULL CONSTRAINT [DF_ShipVia_ChargeAmount]  DEFAULT ((100)),
	[FlatFee] [decimal](18, 5) NOT NULL CONSTRAINT [DF_ShipVia_FlatFee]  DEFAULT ((0)),
	[MinimumFee] [decimal](18, 5) NOT NULL CONSTRAINT [DF_ShipVia_MinimumFee]  DEFAULT ((0)),
	[IsDefault] [tinyint] NOT NULL CONSTRAINT [DF_ShipVia_IsDefault]  DEFAULT ((0)),
	[AllowScheduledShipDate] [tinyint] NOT NULL CONSTRAINT [DF_ShipVia_AllowScheduledShipDate]  DEFAULT ((0)),
 CONSTRAINT [PK_ShipVia] PRIMARY KEY CLUSTERED 
(
	[ShipViaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Specification]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Specification](
	[SpecificationId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Specification_SpecificationId]  DEFAULT (newsequentialid()),
	[ParentId] [uniqueidentifier] NULL,
	[ContentManagerId] [uniqueidentifier] NULL,
	[Name] [nvarchar](100) NOT NULL CONSTRAINT [DF_Specification_Name]  DEFAULT (''),
	[SortOrder] [decimal](18, 5) NOT NULL CONSTRAINT [DF_Specification_SortOrder]  DEFAULT ((0)),
	[Description] [nvarchar](max) NOT NULL CONSTRAINT [DF_Specification_Description]  DEFAULT (''),
	[Active] [tinyint] NOT NULL CONSTRAINT [DF_Specification_Active]  DEFAULT ((1)),
	[Value] [nvarchar](max) NOT NULL CONSTRAINT [DF_Specification_Value]  DEFAULT (''),
 CONSTRAINT [PK_Specification] PRIMARY KEY CLUSTERED 
(
	[SpecificationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[State]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[State](
	[StateId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_State_StateId]  DEFAULT (newsequentialid()),
	[Name] [nvarchar](100) NOT NULL CONSTRAINT [DF_State_Name]  DEFAULT (''),
	[Abbreviation] [nvarchar](50) NOT NULL CONSTRAINT [DF_State_Abbreviation]  DEFAULT (''),
	[TaxRate] [decimal](18, 4) NOT NULL CONSTRAINT [DF_State_TaxRate]  DEFAULT ((0)),
	[Taxable] [tinyint] NOT NULL CONSTRAINT [DF_State_Taxable]  DEFAULT ((0)),
	[IsActive] [tinyint] NOT NULL CONSTRAINT [DF_State_Active]  DEFAULT ((0)),
	[TaxCode] [nvarchar](50) NOT NULL CONSTRAINT [DF_State_TaxCode]  DEFAULT (''),
	[TaxFreight] [tinyint] NOT NULL CONSTRAINT [DF_State_TaxFreight]  DEFAULT ((0)),
	[HandlingAmount] [decimal](18, 5) NOT NULL CONSTRAINT [DF_State_HandlingAmount]  DEFAULT ((0)),
	[CountryId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_State] PRIMARY KEY CLUSTERED 
(
	[StateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StateTaxExemption]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StateTaxExemption](
	[StateId] [uniqueidentifier] NOT NULL,
	[TaxExemptionId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_StateTaxExemption] PRIMARY KEY CLUSTERED 
(
	[StateId] ASC,
	[TaxExemptionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StyleClass]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StyleClass](
	[StyleClassId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[IsActive] [tinyint] NOT NULL,
 CONSTRAINT [PK_StyleClass] PRIMARY KEY CLUSTERED 
(
	[StyleClassId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StyleTrait]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StyleTrait](
	[StyleTraitId] [uniqueidentifier] NOT NULL,
	[StyleClassId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[UnselectedValue] [nvarchar](255) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_StyleTrait] PRIMARY KEY CLUSTERED 
(
	[StyleTraitId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StyleTraitValue]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StyleTraitValue](
	[StyleTraitValueId] [uniqueidentifier] NOT NULL,
	[StyleTraitId] [uniqueidentifier] NOT NULL,
	[Value] [nvarchar](255) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[IsDefault] [tinyint] NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_StyleTraitValue] PRIMARY KEY CLUSTERED 
(
	[StyleTraitValueId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StyleTraitValueProduct]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StyleTraitValueProduct](
	[StyleTraitValueId] [uniqueidentifier] NOT NULL,
	[ProductId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_StyleTraitValueProduct] PRIMARY KEY CLUSTERED 
(
	[StyleTraitValueId] ASC,
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Subscription]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Subscription](
	[SubscriptionId] [uniqueidentifier] NOT NULL,
	[CustomerId] [uniqueidentifier] NOT NULL,
	[ShipToId] [uniqueidentifier] NOT NULL,
	[ProductId] [uniqueidentifier] NOT NULL,
	[Active] [datetime] NOT NULL,
	[Deactivate] [datetime] NULL,
	[CyclePeriod] [nvarchar](50) NOT NULL,
	[PeriodsPerCycle] [int] NOT NULL,
	[TotalCycles] [int] NOT NULL,
	[FixedPrice] [tinyint] NOT NULL,
	[WebSiteId] [uniqueidentifier] NOT NULL,
	[UserProfileId] [uniqueidentifier] NOT NULL,
	[ShipViaId] [uniqueidentifier] NOT NULL,
	[IncludeInInitialOrder] [tinyint] NOT NULL,
	[AllMonths] [tinyint] NOT NULL,
	[January] [tinyint] NOT NULL,
	[February] [tinyint] NOT NULL,
	[March] [tinyint] NOT NULL,
	[April] [tinyint] NOT NULL,
	[May] [tinyint] NOT NULL,
	[June] [tinyint] NOT NULL,
	[July] [tinyint] NOT NULL,
	[August] [tinyint] NOT NULL,
	[September] [tinyint] NOT NULL,
	[October] [tinyint] NOT NULL,
	[November] [tinyint] NOT NULL,
	[December] [tinyint] NOT NULL,
	[CustomerOrderId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Subscription] PRIMARY KEY CLUSTERED 
(
	[SubscriptionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SubscriptionLine]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubscriptionLine](
	[SubscriptionLineId] [uniqueidentifier] NOT NULL,
	[SubscriptionId] [uniqueidentifier] NOT NULL,
	[ProductId] [uniqueidentifier] NOT NULL,
	[QtyOrdered] [decimal](18, 5) NOT NULL,
	[Price] [decimal](18, 5) NOT NULL,
 CONSTRAINT [PK_SubscriptionLine] PRIMARY KEY CLUSTERED 
(
	[SubscriptionLineId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SubscriptionProduct]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubscriptionProduct](
	[SubscriptionProductId] [uniqueidentifier] NOT NULL,
	[ParentProductId] [uniqueidentifier] NOT NULL,
	[ProductId] [uniqueidentifier] NOT NULL,
	[QtyOrdered] [decimal](18, 5) NOT NULL,
 CONSTRAINT [PK_SubscriptionProduct] PRIMARY KEY CLUSTERED 
(
	[SubscriptionProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TaxExemption]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaxExemption](
	[TaxExemptionId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](255) NOT NULL,
	[Amount] [decimal](18, 5) NULL,
	[Active] [datetime] NOT NULL,
	[Deactivate] [datetime] NULL,
 CONSTRAINT [PK_TaxExemption] PRIMARY KEY CLUSTERED 
(
	[TaxExemptionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tmp_PriceData]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tmp_PriceData](
	[tmp_PriceDataId] [uniqueidentifier] NOT NULL,
	[RecordType] [varchar](50) NULL,
	[CustNum] [varchar](50) NULL,
	[ShipToNum] [varchar](50) NULL,
	[PartNum] [varchar](50) NULL,
	[CustomerKeyPart] [varchar](50) NULL,
	[ProductKeyPart] [varchar](50) NULL,
	[CurrencyCode] [varchar](50) NULL,
	[Warehouse] [varchar](50) NULL,
	[UnitOfMeasure] [varchar](50) NULL,
	[PriceBasis] [varchar](50) NULL,
	[AdjustmentType] [varchar](50) NULL,
	[BreakQty] [decimal](18, 5) NULL,
	[Amount] [decimal](18, 5) NULL,
	[AltAmount] [decimal](18, 5) NULL,
	[Active] [varchar](100) NULL,
	[Deactivate] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TranslationDictionary]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TranslationDictionary](
	[TranslationDictionaryId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_TranslationDictionary_TranslationDictionaryId]  DEFAULT (newsequentialid()),
	[Source] [nvarchar](50) NOT NULL CONSTRAINT [DF_TranslationDictionary_Source]  DEFAULT (''),
	[Keyword] [nvarchar](255) NOT NULL CONSTRAINT [DF_TranslationDictionary_Keyword]  DEFAULT (''),
	[LanguageCode] [nvarchar](50) NOT NULL CONSTRAINT [DF_TranslationDictionary_LanguageCode]  DEFAULT (''),
	[Translation] [nvarchar](255) NOT NULL CONSTRAINT [DF_TranslationDictionary_Translation]  DEFAULT (''),
 CONSTRAINT [PK_TranslationDictionary] PRIMARY KEY CLUSTERED 
(
	[TranslationDictionaryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TranslationProperty]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TranslationProperty](
	[TranslationPropertyId] [uniqueidentifier] NOT NULL,
	[ParentTable] [nvarchar](100) NOT NULL,
	[ParentId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[LanguageCode] [nvarchar](50) NOT NULL,
	[TranslatedValue] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_TranslationProperty] PRIMARY KEY CLUSTERED 
(
	[TranslationPropertyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserProfile]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserProfile](
	[UserProfileId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_UserProfile_UserProfileId]  DEFAULT (newsequentialid()),
	[FirstName] [nvarchar](100) NOT NULL CONSTRAINT [DF_UserProfile_FirstName]  DEFAULT (''),
	[LastName] [nvarchar](100) NOT NULL CONSTRAINT [DF_UserProfile_LastName]  DEFAULT (''),
	[Company] [nvarchar](100) NOT NULL CONSTRAINT [DF_UserProfile_Company]  DEFAULT (''),
	[Phone] [nvarchar](50) NOT NULL CONSTRAINT [DF_UserProfile_Phone]  DEFAULT (''),
	[Extension] [nvarchar](50) NOT NULL CONSTRAINT [DF_UserProfile_Ext]  DEFAULT (''),
	[Fax] [nvarchar](50) NOT NULL CONSTRAINT [DF_UserProfile_Fax]  DEFAULT (''),
	[Position] [nvarchar](100) NOT NULL CONSTRAINT [DF_UserProfile_Position]  DEFAULT (''),
	[UserName] [nvarchar](256) NOT NULL CONSTRAINT [DF_UserProfile_UserName]  DEFAULT (''),
	[CanChangePassword] [tinyint] NOT NULL CONSTRAINT [DF_UserProfile_CanChangePassword]  DEFAULT ((0)),
	[CanSubmitOrder] [tinyint] NOT NULL CONSTRAINT [DF_UserProfile_CanSubmitOrder]  DEFAULT ((0)),
	[CanViewAllOrders] [tinyint] NOT NULL CONSTRAINT [DF_UserProfile_CanViewAllOrders]  DEFAULT ((0)),
	[IsSubscribed] [tinyint] NOT NULL CONSTRAINT [DF_UserProfile_IsSubscribed]  DEFAULT ((0)),
	[ApplicationName] [nvarchar](256) NULL CONSTRAINT [DF_UserProfile_ApplicationName]  DEFAULT (N'/'),
	[LanguageCode] [nvarchar](50) NOT NULL CONSTRAINT [DF_UserProfile_LanguageCode]  DEFAULT (''),
	[SubscriptionUser] [tinyint] NOT NULL CONSTRAINT [DF_UserProfile_SubscriptionUser]  DEFAULT ((0)),
	[IsGuest] [tinyint] NOT NULL CONSTRAINT [DF_UserProfile_IsGuest]  DEFAULT ((0)),
	[Email] [nvarchar](256) NOT NULL CONSTRAINT [DF_UserProfile_Email]  DEFAULT (''),
	[IsReviewingContent] [tinyint] NOT NULL CONSTRAINT [DF_UserProfile_IsReviewingContent]  DEFAULT ((0)),
	[DefaultCustomerId] [uniqueidentifier] NULL,
	[ApproverUserProfileId] [uniqueidentifier] NULL,
	[LimitExceededNotification] [tinyint] NOT NULL CONSTRAINT [DF_UserProfile_LimitExceededNotification]  DEFAULT ((0)),
	[IsEditingContent] [tinyint] NOT NULL CONSTRAINT [DF_UserProfile_IsEditingContent]  DEFAULT ((0)),
	[DashboardIsHomepage] [tinyint] NOT NULL CONSTRAINT [DF_UserProfile_DashboardIsHomepage]  DEFAULT ((0)),
	[CurrencyId] [uniqueidentifier] NULL,
	[IsPasswordChangeRequired] [tinyint] NOT NULL CONSTRAINT [DF_UserProfile_IsPasswordChangeRequired]  DEFAULT ((0)),
	[HasRfqUpdates] [bit] NULL,
 CONSTRAINT [PK_UserProfile] PRIMARY KEY CLUSTERED 
(
	[UserProfileId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserProfileEmailList]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserProfileEmailList](
	[UserProfileId] [uniqueidentifier] NOT NULL,
	[EmailListId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_UserProfileEmailList] PRIMARY KEY CLUSTERED 
(
	[UserProfileId] ASC,
	[EmailListId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserProfilePassword]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserProfilePassword](
	[UserProfilePasswordId] [uniqueidentifier] NOT NULL,
	[UserProfileId] [uniqueidentifier] NOT NULL,
	[Password] [nvarchar](128) NOT NULL,
	[PasswordFormat] [int] NOT NULL,
	[PasswordSalt] [nvarchar](128) NOT NULL,
	[PasswordChangedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_UserProfilePassword] PRIMARY KEY CLUSTERED 
(
	[UserProfilePasswordId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserProfileProperty]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserProfileProperty](
	[UserProfilePropertyId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_UserProfileProperty_UserProfilePropertyId]  DEFAULT (newsequentialid()),
	[UserProfileId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](100) NOT NULL CONSTRAINT [DF_UserProfileProperty_Name]  DEFAULT (''),
	[Value] [nvarchar](max) NOT NULL CONSTRAINT [DF_UserProfileProperty_Value]  DEFAULT (''),
 CONSTRAINT [PK_UserProfileProperty] PRIMARY KEY CLUSTERED 
(
	[UserProfilePropertyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Vendor]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vendor](
	[VendorId] [uniqueidentifier] NOT NULL,
	[VendorNumber] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Address1] [nvarchar](100) NOT NULL,
	[Address2] [nvarchar](100) NOT NULL,
	[City] [nvarchar](100) NOT NULL,
	[State] [nvarchar](50) NOT NULL,
	[Zip] [nvarchar](50) NOT NULL,
	[WebSiteAddress] [nvarchar](255) NOT NULL,
	[ContactName] [nvarchar](255) NOT NULL,
	[ContactEmail] [nvarchar](255) NOT NULL,
	[Phone] [nvarchar](50) NOT NULL,
	[Ranking] [int] NOT NULL,
	[RegularMarkup] [decimal](18, 5) NOT NULL,
	[SaleMarkup] [decimal](18, 5) NOT NULL,
	[VendorMessage] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Vendor] PRIMARY KEY CLUSTERED 
(
	[VendorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Warehouse]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Warehouse](
	[WarehouseId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](2048) NOT NULL,
	[Address1] [nvarchar](100) NOT NULL,
	[Address2] [nvarchar](100) NOT NULL,
	[City] [nvarchar](100) NOT NULL,
	[State] [nvarchar](50) NOT NULL,
	[Zip] [nvarchar](50) NOT NULL,
	[ContactName] [nvarchar](255) NOT NULL,
	[Phone] [nvarchar](50) NOT NULL,
	[ShipSite] [nvarchar](255) NOT NULL,
	[Deactivate] [datetime] NULL,
	[IsDefaultWarehouse] [tinyint] NOT NULL,
 CONSTRAINT [PK_Warehouse] PRIMARY KEY CLUSTERED 
(
	[WarehouseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_Warehouse] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WarehouseAlternate]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WarehouseAlternate](
	[WarehouseId] [uniqueidentifier] NOT NULL,
	[AlternateWarehouseId] [uniqueidentifier] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Index [PK_WarehouseAlternate]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE CLUSTERED INDEX [PK_WarehouseAlternate] ON [dbo].[WarehouseAlternate]
(
	[WarehouseId] ASC,
	[AlternateWarehouseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WebPage]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebPage](
	[WebPageId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_WebPage_WebPageId]  DEFAULT (newsequentialid()),
	[WebSiteId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](max) NOT NULL CONSTRAINT [DF_WebPage_Description]  DEFAULT (''),
	[PageContent] [nvarchar](max) NOT NULL CONSTRAINT [DF_WebPage_PageContent]  DEFAULT (''),
	[Title] [nvarchar](100) NOT NULL CONSTRAINT [DF_WebPage_Title]  DEFAULT (''),
	[StyleSheet] [nvarchar](255) NOT NULL CONSTRAINT [DF_WebPage_StyleSheet]  DEFAULT (''),
	[BodyOnLoad] [nvarchar](max) NOT NULL CONSTRAINT [DF_WebPage_BodyOnLoad]  DEFAULT (''),
	[ContentManagerId] [uniqueidentifier] NULL,
	[MetaKeywords] [nvarchar](max) NULL,
	[MetaDescription] [nvarchar](max) NULL,
	[ViewName] [nvarchar](100) NOT NULL CONSTRAINT [DF_WebPage_ViewName]  DEFAULT (''),
	[Inherit] [tinyint] NOT NULL CONSTRAINT [DF_WebPage_Inherit]  DEFAULT ((0)),
 CONSTRAINT [PK_WebPage] PRIMARY KEY CLUSTERED 
(
	[WebPageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WebPageContent]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebPageContent](
	[WebPageContentId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_WebPageContent_WebPageContentId]  DEFAULT (newsequentialid()),
	[WebSiteId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](100) NOT NULL CONSTRAINT [DF_WebPageContent_Name]  DEFAULT (''),
	[PageTitle] [nvarchar](512) NOT NULL CONSTRAINT [DF_WebPageContent_PageTitle]  DEFAULT (''),
	[ContentTitle] [nvarchar](512) NOT NULL CONSTRAINT [DF_WebPageContent_ContentTitle]  DEFAULT (''),
	[MetaTags] [nvarchar](max) NOT NULL CONSTRAINT [DF_WebPageContent_MetaTags]  DEFAULT (''),
	[MetaDescription] [nvarchar](max) NOT NULL CONSTRAINT [DF_WebPageContent_MetaDescription]  DEFAULT (''),
	[PageContent] [nvarchar](max) NOT NULL CONSTRAINT [DF_WebPageContent_PageContent]  DEFAULT (''),
	[OverrideParent] [tinyint] NOT NULL CONSTRAINT [DF_WebPageContent_OverrideParent]  DEFAULT ((0)),
	[ContentManagerId] [uniqueidentifier] NULL,
	[WebPageId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_WebPageContent] PRIMARY KEY CLUSTERED 
(
	[WebPageContentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WebSite]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebSite](
	[WebSiteId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_WebSite_WebSiteId]  DEFAULT (newsequentialid()),
	[ParentWebSiteId] [uniqueidentifier] NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](max) NOT NULL CONSTRAINT [DF_WebSite_Description]  DEFAULT (''),
	[TopContent] [nvarchar](max) NOT NULL CONSTRAINT [DF_WebSite_TopContent]  DEFAULT (''),
	[ShowTopContent] [tinyint] NOT NULL CONSTRAINT [DF_WebSite_ShowTopContent]  DEFAULT ((0)),
	[LeftContent] [nvarchar](max) NOT NULL CONSTRAINT [DF_WebSite_LeftContent]  DEFAULT (''),
	[ShowLeftContent] [tinyint] NOT NULL CONSTRAINT [DF_WebSite_ShowLeftContent]  DEFAULT ((0)),
	[RightContent] [nvarchar](max) NOT NULL CONSTRAINT [DF_WebSite_RightContent]  DEFAULT (''),
	[ShowRightContent] [tinyint] NOT NULL CONSTRAINT [DF_WebSite_ShowRightContent]  DEFAULT ((0)),
	[BottomContent] [nvarchar](max) NOT NULL CONSTRAINT [DF_WebSite_BottomContent]  DEFAULT (''),
	[ShowBottomContent] [tinyint] NOT NULL CONSTRAINT [DF_WebSite_ShowBottomContent]  DEFAULT ((0)),
	[OpeningPageTags] [nvarchar](max) NOT NULL CONSTRAINT [DF_WebSite_OpeningPageTags]  DEFAULT (''),
	[ClosingPageTags] [nvarchar](max) NOT NULL CONSTRAINT [DF_WebSite_ClosingPageTags]  DEFAULT (''),
	[Title] [nvarchar](100) NOT NULL CONSTRAINT [DF_WebSite_Title]  DEFAULT (''),
	[HeaderContent] [nvarchar](max) NOT NULL CONSTRAINT [DF_WebSite_HeaderContent]  DEFAULT (''),
	[BodyStyle] [nvarchar](255) NOT NULL CONSTRAINT [DF_WebSite_BodyTags]  DEFAULT (''),
	[StyleSheet] [nvarchar](255) NOT NULL CONSTRAINT [DF_WebSite_StyleSheet]  DEFAULT (''),
	[JavaScript] [nvarchar](255) NOT NULL CONSTRAINT [DF_WebSite_JavaScript]  DEFAULT (''),
	[ERPServiceUrl] [nvarchar](255) NOT NULL CONSTRAINT [DF_WebSite_ERPServiceUrl]  DEFAULT (''),
	[ERPServiceTimeout] [int] NOT NULL CONSTRAINT [DF_WebSite_ERPServiceTimeout]  DEFAULT ((600000)),
	[TaxCalculation] [nvarchar](50) NOT NULL CONSTRAINT [DF_WebSite_ChargeTax]  DEFAULT ('None'),
	[TaxAmount] [decimal](18, 5) NOT NULL CONSTRAINT [DF_WebSite_TaxAmount]  DEFAULT ((0)),
	[HandlingCalculation] [nvarchar](50) NOT NULL CONSTRAINT [DF_WebSite_HandlingCalculation]  DEFAULT ('None'),
	[HandlingAmount] [decimal](18, 5) NOT NULL CONSTRAINT [DF_WebSite_HandlingAmount]  DEFAULT ((0)),
	[TaxFreeTaxCode] [nvarchar](50) NOT NULL CONSTRAINT [DF_WebSite_TaxFreeTaxCode]  DEFAULT (''),
	[DefaultShipSite] [nvarchar](50) NOT NULL CONSTRAINT [DF_WebSite_DefaultShipSite]  DEFAULT (''),
	[TermsOfUse] [nvarchar](max) NOT NULL CONSTRAINT [DF_WebSite_TermsOfUse]  DEFAULT (''),
	[DomainName] [nvarchar](450) NOT NULL CONSTRAINT [DF_WebSite_DomainName]  DEFAULT (''),
	[MapProductsToCategories] [tinyint] NOT NULL CONSTRAINT [DF_WebSite_MapProductsToCategories]  DEFAULT ((0)),
	[HostCompanyName] [nvarchar](100) NOT NULL CONSTRAINT [DF_WebSite_HostCompanyName]  DEFAULT (''),
	[OrderNumberPrefix] [nvarchar](50) NOT NULL CONSTRAINT [DF_WebSite_OrderNumberPrefix]  DEFAULT (''),
	[OrderNumberFormat] [nvarchar](50) NOT NULL CONSTRAINT [DF_WebSite_OrderNumberFormat]  DEFAULT (''),
	[CustomerNumberPrefix] [nvarchar](50) NOT NULL CONSTRAINT [DF_WebSite_CustomerNumberPrefix]  DEFAULT (''),
	[CustomerNumberFormat] [nvarchar](50) NOT NULL CONSTRAINT [DF_WebSite_CustomerNumberFormat]  DEFAULT (''),
	[AllowMultiplePromotions] [tinyint] NOT NULL CONSTRAINT [DF_WebSite_AllowMultiplePromotions]  DEFAULT ((0)),
	[IsActive] [tinyint] NOT NULL CONSTRAINT [DF_WebSite_IsActive]  DEFAULT ((1)),
	[MicroSiteIdentifiers] [nvarchar](450) NOT NULL CONSTRAINT [DF_WebSite_MicroSiteIdentifiers]  DEFAULT (''),
	[ApplicationName] [nvarchar](256) NOT NULL CONSTRAINT [DF_WebSite_ApplicationName]  DEFAULT (N'/'),
	[IsRestricted] [tinyint] NOT NULL CONSTRAINT [DF_WebSite_IsRestricted]  DEFAULT ((0)),
 CONSTRAINT [PK_WebSite] PRIMARY KEY CLUSTERED 
(
	[WebSiteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WebSiteAllowedCustomers]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebSiteAllowedCustomers](
	[WebSiteId] [uniqueidentifier] NOT NULL,
	[CustomerId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_WebSiteAllowedCustomers] PRIMARY KEY CLUSTERED 
(
	[WebSiteId] ASC,
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WebSiteCarrier]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebSiteCarrier](
	[WebSiteId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_WebSiteCarrier_WebSiteId]  DEFAULT (newid()),
	[CarrierId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_WebSiteCarrier_CarrierId]  DEFAULT (newid()),
 CONSTRAINT [PK_WebSiteCarrier] PRIMARY KEY CLUSTERED 
(
	[WebSiteId] ASC,
	[CarrierId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WebSiteConfiguration]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebSiteConfiguration](
	[WebSiteConfigurationId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_WebSiteConfiguration_WebSiteConfigurationId]  DEFAULT (newsequentialid()),
	[WebSiteId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
	[Value] [nvarchar](max) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_WebSiteConfiguration] PRIMARY KEY CLUSTERED 
(
	[WebSiteConfigurationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WebSiteCountry]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebSiteCountry](
	[WebSiteId] [uniqueidentifier] NOT NULL,
	[CountryId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_WebSiteCountry] PRIMARY KEY CLUSTERED 
(
	[WebSiteId] ASC,
	[CountryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WebSiteCurrency]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebSiteCurrency](
	[WebSiteCurrencyId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_WebSiteCurrency_WebSiteCurrencyId]  DEFAULT (newsequentialid()),
	[WebSiteId] [uniqueidentifier] NOT NULL,
	[CurrencyId] [uniqueidentifier] NOT NULL,
	[IsLive] [tinyint] NOT NULL CONSTRAINT [DF_WebSiteCurrency_IsLive]  DEFAULT ((0)),
	[IsDefault] [tinyint] NOT NULL CONSTRAINT [DF_WebSiteCurrency_IsDefault]  DEFAULT ((0)),
 CONSTRAINT [PK_WebSiteCurrency] PRIMARY KEY CLUSTERED 
(
	[WebSiteCurrencyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WebSiteDealer]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebSiteDealer](
	[WebSiteId] [uniqueidentifier] NOT NULL,
	[DealerId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_WebSiteDealer] PRIMARY KEY CLUSTERED 
(
	[WebSiteId] ASC,
	[DealerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WebSiteLanguage]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebSiteLanguage](
	[WebSiteLanguageId] [uniqueidentifier] NOT NULL CONSTRAINT [DF_WebSiteLanguage_WebSiteLanguageId]  DEFAULT (newsequentialid()),
	[WebSiteId] [uniqueidentifier] NOT NULL,
	[LanguageId] [uniqueidentifier] NOT NULL,
	[IsDefault] [tinyint] NOT NULL CONSTRAINT [DF_WebSiteLanguage_IsDefault]  DEFAULT ((0)),
	[IsLive] [tinyint] NOT NULL CONSTRAINT [DF_WebSiteLanguage_IsLive]  DEFAULT ((1)),
 CONSTRAINT [PK_WebSiteLangauge] PRIMARY KEY CLUSTERED 
(
	[WebSiteLanguageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WebSiteProductCrossSell]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebSiteProductCrossSell](
	[WebSiteId] [uniqueidentifier] NOT NULL,
	[ProductId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_WebSiteProductCrossSell] PRIMARY KEY CLUSTERED 
(
	[WebSiteId] ASC,
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WebSitePromotion]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebSitePromotion](
	[WebSiteId] [uniqueidentifier] NOT NULL,
	[PromotionId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_WebSitePromotion] PRIMARY KEY CLUSTERED 
(
	[WebSiteId] ASC,
	[PromotionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WebSiteState]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebSiteState](
	[WebSiteId] [uniqueidentifier] NOT NULL,
	[StateId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_WebSiteState] PRIMARY KEY CLUSTERED 
(
	[WebSiteId] ASC,
	[StateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WishList]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WishList](
	[WishListId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[UserProfileId] [uniqueidentifier] NULL,
	[CustomerId] [uniqueidentifier] NULL,
 CONSTRAINT [PK__WishList__4A43E4FB] PRIMARY KEY CLUSTERED 
(
	[WishListId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WishListProduct]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WishListProduct](
	[WishListProductId] [uniqueidentifier] NOT NULL,
	[WishListId] [uniqueidentifier] NOT NULL,
	[ProductId] [uniqueidentifier] NOT NULL,
	[QtyOrdered] [decimal](18, 5) NOT NULL,
	[UnitOfMeasure] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK__WishListProduct__4F089A18] PRIMARY KEY CLUSTERED 
(
	[WishListProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_WishListProductId_ProductId_uk] UNIQUE NONCLUSTERED 
(
	[WishListId] ASC,
	[ProductId] ASC,
	[UnitOfMeasure] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[ReportOrderHistoryLineView]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ReportOrderHistoryLineView]
AS
SELECT        
	'OrderHistoryLine' AS Source, ohl.OrderHistoryLineId, ohl.OrderHistoryId AS Orderid, ohl.RequiredDate, ohl.LastShipDate, ohl.CustomerNumber, 
    ohl.CustomerSequence, ohl.LineType, ohl.Status, ohl.LineNumber, ohl.ReleaseNumber, ohl.ProductErpNumber, ohl.CustomerProductNumber, ohl.LinePOReference, 
    ohl.Description, ohl.Warehouse, ohl.Notes, ohl.QtyOrdered, ohl.QtyShipped, ohl.UnitOfMeasure, ohl.InventoryQtyOrdered, ohl.InventoryQtyShipped, 
	CASE ISNULL(oh.ConversionRate,0)
		WHEN 0 THEN ohl.UnitPrice
		ELSE ohl.UnitPrice / oh.ConversionRate
	END AS UnitPrice, 
    ohl.DiscountPercent, 
	CASE ISNULL(oh.ConversionRate,0)
		WHEN 0 THEN ohl.DiscountAmount
		ELSE ohl.DiscountAmount / oh.ConversionRate
	END AS DiscountAmount,
	CASE ISNULL(oh.ConversionRate,0)
		WHEN 0 THEN ohl.PromotionAmountApplied
		ELSE ohl.PromotionAmountApplied/ oh.ConversionRate
	END AS PromotionAmountApplied,
	CASE ISNULL(oh.ConversionRate,0)
		WHEN 0 THEN ohl.LineTotal
		ELSE ohl.LineTotal / oh.ConversionRate
	END AS LineTotal,
	ohl.RMAQtyRequested, 
	ohl.RMAQtyReceived,
	oh.ConversionRate
FROM
	OrderHistoryLine ohl WITH (NOLOCK)
	LEFT JOIN OrderHistory oh WITH (NOLOCK) ON ohl.OrderHistoryId = oh.OrderHistoryId
UNION
SELECT
	'OrderLine' AS Source, ol.OrderLineId AS OrderHistoryLineId, ol.CustomerOrderId AS OrderId, ol.DueDate AS RequiredDate, ol.ShipDate AS LastShipDate, 
    co.CustomerNumber, co.CustomerSequence, '' AS LineType, ol.Status, ol.Line AS LineNumber, ol.Release AS ReleaseNumber, ISNULL(p.ErpDescription, '') 
    AS ProductErpNumber, ISNULL(cp.Name, ''), ISNULL(ol.CustomerPOLine, '') AS LinePOReference, ISNULL(ol.Description, ''), ol.Warehouse, ol.Notes, ol.QtyOrdered, 
    ol.QtyShipped, ol.UnitOfMeasure, ol.QtyOrdered AS InventoryQtyOrdered, ol.QtyShipped AS InventoryQtyShipped, 
	CASE ISNULL(co.ConversionRate,0)
		WHEN 0 THEN ol.ActualPrice
		ELSE ol.ActualPrice / co.ConversionRate
	END AS UnitPrice,
	ol.DiscountPercent, 
	CASE ISNULL(co.ConversionRate,0)
		WHEN 0 THEN ol.DiscountAmount
		ELSE ol.DiscountAmount / co.ConversionRate
	END AS DiscountAmount,
	0.00 AS PromotionAmountApplied, 
	CASE ISNULL(co.ConversionRate,0)
		WHEN 0 THEN (ol.QtyOrdered * ol.ActualPrice)
		ELSE (ol.QtyOrdered * ol.ActualPrice) / co.ConversionRate
	END AS LineTotal,
	0.00 AS RMAQtyRequested, 
	0.00 AS RMAQtyReceived,
	co.ConversionRate
FROM 
	CustomerOrder co WITH (NOLOCK) LEFT JOIN
    OrderLine ol WITH (NOLOCK) ON co.CustomerOrderId = ol.CustomerOrderId LEFT JOIN
    Product p WITH (NOLOCK) ON ol.ProductId = p.ProductId LEFT JOIN
    CustomerProduct cp WITH (NOLOCK) ON p.ProductId = cp.ProductId
WHERE
	co.Status LIKE '%Aba%' AND ol.OrderLineId IS NOT NULL AND ol.QtyOrdered > 0




GO
/****** Object:  View [dbo].[ReportOrderHistoryView]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ReportOrderHistoryView]
AS
SELECT        
	'OrderHistory' AS Source, oh.OrderHistoryId AS Orderid, oh.ERPOrderNumber, oh.WebOrderNumber, oh.OrderDate, oh.Status, oh.CustomerNumber, oh.CustomerSequence, oh.CustomerPO, oh.CurrencyCode, oh.Terms, oh.ShipCode, oh.Salesperson, oh.BTCompanyName, oh.BTAddress1, oh.BTAddress2, oh.BTCity, oh.BTState, oh.BTPostalCode, oh.BTCountry, oh.STCompanyName, oh.STAddress1, oh.STAddress2, oh.STCity, oh.STState, oh.STPostalCode, oh.STCountry, 
	CASE ISNULL(oh.ConversionRate,0)
		WHEN 0 THEN oh.DiscountAmount
		ELSE oh.DiscountAmount / oh.ConversionRate
	END AS DiscountAmount,
	CASE ISNULL(oh.ConversionRate,0)
		WHEN 0 THEN oh.ShippingAndHandling
		ELSE oh.ShippingAndHandling / oh.ConversionRate
	END AS ShippingAndHandling,
	CASE ISNULL(oh.ConversionRate,0)
		WHEN 0 THEN oh.OtherCharges
		ELSE oh.OtherCharges / oh.ConversionRate
	END AS OtherCharges,
	CASE ISNULL(oh.ConversionRate,0)
		WHEN 0 THEN oh.TaxAmount
		ELSE oh.TaxAmount / oh.ConversionRate
	END AS TaxAmount, 
	oh.ModifyDate, 
	CASE ISNULL(oh.ConversionRate,0)
		WHEN 0 THEN oh.ProductTotal
		ELSE oh.ProductTotal  / oh.ConversionRate
	END AS ProductTotal, 
	--oh.ProductTotal, 
	CASE ISNULL(oh.ConversionRate,0)
		WHEN 0 THEN oh.OrderTotal
		ELSE oh.OrderTotal  / oh.ConversionRate
	END AS OrderTotal, 
	--oh.OrderTotal, 
	ISNULL(ws.Name, '') AS WebSiteName, 
	CASE oh.WebOrderNumber WHEN '' THEN 'ERP' ELSE CASE WHEN ws.Name LIKE 'm.%' THEN 'MOBILE' ELSE 'WEB' END END AS OrderType, 
    ISNULL(c.CustomerType, '') AS CustomerType,
	oh.ConversionRate AS ConversionRate
FROM            
	OrderHistory oh WITH (NOLOCK) LEFT JOIN
    CustomerOrder co WITH (NOLOCK) ON oh.WebOrderNumber = co.OrderNumber LEFT JOIN
    WebSite ws WITH (NOLOCK) ON ws.WebSiteId = co.WebSiteId LEFT JOIN
    Customer c WITH (NOLOCK) ON oh.CustomerNumber = c.CustomerNumber AND (c.ParentId IS NULL OR c.ParentId = c.CustomerId)
UNION
SELECT        
	'CustomerOrder' AS Source, co.customerorderid AS Orderid, co.ERPOrderNumber, co.OrderNumber AS WebOrderNumber, co.OrderDate, co.Status, co.CustomerNumber, co.CustomerSequence, co.CustomerPO, co.CurrencyCode, co.TermsCode AS Terms, co.ShipCode, co.Salesman AS Salesperson, co.BTCompany AS BTCompanyName, co.BTAddress1, co.BTAddress2, co.BTCity, co.BTState, co.BTZip AS BTPostalCode, co.BTCountry, co.STCompany AS STCompanyName, co.STAddress1, co.STAddress2, co.STCity, co.STState, co.STZip AS STPostalCode, co.STCountry, 0.00 AS DiscountAmount, 
    0.00 AS ShippingAndHandling, 0.00 AS OtherCharges, 0.00 AS TaxAmount, co.OrderDate AS ModifyDate, 
	CASE ISNULL(co.ConversionRate,0)
		WHEN 0 THEN SUM(ol.QtyOrdered *  ol.ActualPrice)
		ELSE SUM((ol.QtyOrdered * ol.ActualPrice))  / co.ConversionRate
	END AS ProductTotal,
	CASE ISNULL(co.ConversionRate,0)
		WHEN 0 THEN SUM(ol.QtyOrdered *  ol.ActualPrice)
		ELSE SUM((ol.QtyOrdered * ol.ActualPrice))  / co.ConversionRate
	END AS OrderTotal,
	ws.Name AS WebSiteName, 
    CASE WHEN ws.Name LIKE 'm.%' THEN 'MOBILE' ELSE 'WEB' END AS OrderType, ISNULL(c.CustomerType, '') AS CustomerType,
	co.ConversionRate AS ConversionRate
FROM 
	customerorder co WITH (NOLOCK) 
	LEFT JOIN WebSite ws WITH (NOLOCK) ON co.WebSiteId = ws.WebSiteId 
	LEFT JOIN Customer c WITH (NOLOCK) ON co.CustomerNumber = c.CustomerNumber AND (c.ParentId IS NULL OR c.ParentId = c.CustomerId) 
	LEFT JOIN OrderLine ol WITH (NOLOCK) ON co.CustomerOrderId = ol.CustomerOrderId
WHERE        
	co.status LIKE '%Aba%' AND ol.QtyOrdered > 0
GROUP BY 
	co.CustomerOrderId, co.ErpOrderNumber, co.OrderNumber, co.OrderDate, co.Status, co.CustomerNumber, co.CustomerSequence, co.CustomerPO, co.CurrencyCode, 
    co.TermsCode, co.ShipCode, co.Salesman, co.BTCompany, co.BTAddress1, co.BTAddress2, co.BTCity, co.BTState, co.BTZip, co.BTCountry, co.STCompany, 
    co.STAddress1, co.STAddress2, co.STCity, co.STState, co.STZip, co.STCountry, ws.Name, c.CustomerType, co.ConversionRate

GO
/****** Object:  View [dbo].[vw_aspnet_Applications]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE VIEW [dbo].[vw_aspnet_Applications]
  AS SELECT [dbo].[aspnet_Applications].[ApplicationName], [dbo].[aspnet_Applications].[LoweredApplicationName], [dbo].[aspnet_Applications].[ApplicationId], [dbo].[aspnet_Applications].[Description]
  FROM [dbo].[aspnet_Applications]


GO
/****** Object:  View [dbo].[vw_aspnet_MembershipUsers]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE VIEW [dbo].[vw_aspnet_MembershipUsers]
  AS SELECT [dbo].[aspnet_Membership].[UserId],
            [dbo].[aspnet_Membership].[PasswordFormat],
            [dbo].[aspnet_Membership].[MobilePIN],
            [dbo].[aspnet_Membership].[Email],
            [dbo].[aspnet_Membership].[LoweredEmail],
            [dbo].[aspnet_Membership].[PasswordQuestion],
            [dbo].[aspnet_Membership].[PasswordAnswer],
            [dbo].[aspnet_Membership].[IsApproved],
            [dbo].[aspnet_Membership].[IsLockedOut],
            [dbo].[aspnet_Membership].[CreateDate],
            [dbo].[aspnet_Membership].[LastLoginDate],
            [dbo].[aspnet_Membership].[LastPasswordChangedDate],
            [dbo].[aspnet_Membership].[LastLockoutDate],
            [dbo].[aspnet_Membership].[FailedPasswordAttemptCount],
            [dbo].[aspnet_Membership].[FailedPasswordAttemptWindowStart],
            [dbo].[aspnet_Membership].[FailedPasswordAnswerAttemptCount],
            [dbo].[aspnet_Membership].[FailedPasswordAnswerAttemptWindowStart],
            [dbo].[aspnet_Membership].[Comment],
            [dbo].[aspnet_Users].[ApplicationId],
            [dbo].[aspnet_Users].[UserName],
            [dbo].[aspnet_Users].[MobileAlias],
            [dbo].[aspnet_Users].[IsAnonymous],
            [dbo].[aspnet_Users].[LastActivityDate]
  FROM [dbo].[aspnet_Membership] INNER JOIN [dbo].[aspnet_Users]
      ON [dbo].[aspnet_Membership].[UserId] = [dbo].[aspnet_Users].[UserId]


GO
/****** Object:  View [dbo].[vw_aspnet_Profiles]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE VIEW [dbo].[vw_aspnet_Profiles]
  AS SELECT [dbo].[aspnet_Profile].[UserId], [dbo].[aspnet_Profile].[LastUpdatedDate],
      [DataSize]=  DATALENGTH([dbo].[aspnet_Profile].[PropertyNames])
                 + DATALENGTH([dbo].[aspnet_Profile].[PropertyValuesString])
                 + DATALENGTH([dbo].[aspnet_Profile].[PropertyValuesBinary])
  FROM [dbo].[aspnet_Profile]


GO
/****** Object:  View [dbo].[vw_aspnet_Roles]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE VIEW [dbo].[vw_aspnet_Roles]
  AS SELECT [dbo].[aspnet_Roles].[ApplicationId], [dbo].[aspnet_Roles].[RoleId], [dbo].[aspnet_Roles].[RoleName], [dbo].[aspnet_Roles].[LoweredRoleName], [dbo].[aspnet_Roles].[Description]
  FROM [dbo].[aspnet_Roles]


GO
/****** Object:  View [dbo].[vw_aspnet_Users]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE VIEW [dbo].[vw_aspnet_Users]
  AS SELECT [dbo].[aspnet_Users].[ApplicationId], [dbo].[aspnet_Users].[UserId], [dbo].[aspnet_Users].[UserName], [dbo].[aspnet_Users].[LoweredUserName], [dbo].[aspnet_Users].[MobileAlias], [dbo].[aspnet_Users].[IsAnonymous], [dbo].[aspnet_Users].[LastActivityDate]
  FROM [dbo].[aspnet_Users]


GO
/****** Object:  View [dbo].[vw_aspnet_UsersInRoles]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE VIEW [dbo].[vw_aspnet_UsersInRoles]
  AS SELECT [dbo].[aspnet_UsersInRoles].[UserId], [dbo].[aspnet_UsersInRoles].[RoleId]
  FROM [dbo].[aspnet_UsersInRoles]


GO
/****** Object:  View [dbo].[vw_aspnet_WebPartState_Paths]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE VIEW [dbo].[vw_aspnet_WebPartState_Paths]
  AS SELECT [dbo].[aspnet_Paths].[ApplicationId], [dbo].[aspnet_Paths].[PathId], [dbo].[aspnet_Paths].[Path], [dbo].[aspnet_Paths].[LoweredPath]
  FROM [dbo].[aspnet_Paths]


GO
/****** Object:  View [dbo].[vw_aspnet_WebPartState_Shared]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE VIEW [dbo].[vw_aspnet_WebPartState_Shared]
  AS SELECT [dbo].[aspnet_PersonalizationAllUsers].[PathId], [DataSize]=DATALENGTH([dbo].[aspnet_PersonalizationAllUsers].[PageSettings]), [dbo].[aspnet_PersonalizationAllUsers].[LastUpdatedDate]
  FROM [dbo].[aspnet_PersonalizationAllUsers]


GO
/****** Object:  View [dbo].[vw_aspnet_WebPartState_User]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE VIEW [dbo].[vw_aspnet_WebPartState_User]
  AS SELECT [dbo].[aspnet_PersonalizationPerUser].[PathId], [dbo].[aspnet_PersonalizationPerUser].[UserId], [DataSize]=DATALENGTH([dbo].[aspnet_PersonalizationPerUser].[PageSettings]), [dbo].[aspnet_PersonalizationPerUser].[LastUpdatedDate]
  FROM [dbo].[aspnet_PersonalizationPerUser]


GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_ApplicationDictionary]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_ApplicationDictionary] ON [dbo].[ApplicationDictionary]
(
	[ObjectName] ASC,
	[FieldName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ApplicationLog_BatchNumber]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_ApplicationLog_BatchNumber] ON [dbo].[ApplicationLog]
(
	[BatchNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ApplicationLog_LogDate]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_ApplicationLog_LogDate] ON [dbo].[ApplicationLog]
(
	[LogDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ApplicationLog_Sequence]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_ApplicationLog_Sequence] ON [dbo].[ApplicationLog]
(
	[Sequence] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_ApplicationLog_Type]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_ApplicationLog_Type] ON [dbo].[ApplicationLog]
(
	[Type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_ApplicationMessage_Name]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_ApplicationMessage_Name] ON [dbo].[ApplicationMessage]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_ApplicationSetting_Name]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_ApplicationSetting_Name] ON [dbo].[ApplicationSetting]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [aspnet_PersonalizationPerUser_ncindex2]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [aspnet_PersonalizationPerUser_ncindex2] ON [dbo].[aspnet_PersonalizationPerUser]
(
	[UserId] ASC,
	[PathId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [aspnet_Users_Index2]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [aspnet_Users_Index2] ON [dbo].[aspnet_Users]
(
	[ApplicationId] ASC,
	[LastActivityDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [aspnet_UsersInRoles_index]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [aspnet_UsersInRoles_index] ON [dbo].[aspnet_UsersInRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_BudgetCalendar_Customer_FiscalYear]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_BudgetCalendar_Customer_FiscalYear] ON [dbo].[BudgetCalendar]
(
	[CustomerId] ASC,
	[FiscalYear] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Carrier_Name]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Carrier_Name] ON [dbo].[Carrier]
(
	[CarrierId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Category]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Category] ON [dbo].[Category]
(
	[Name] ASC,
	[WebSiteId] ASC,
	[ParentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_CategoryFilterSection]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_CategoryFilterSection] ON [dbo].[CategoryFilterSection]
(
	[CategoryId] ASC,
	[FilterSectionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_CategoryProperty]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_CategoryProperty] ON [dbo].[CategoryProperty]
(
	[CategoryId] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Company]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Company] ON [dbo].[Company]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Configuration]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Configuration] ON [dbo].[Configuration]
(
	[Name] ASC,
	[Revision] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ConfigurationConditionFilter_ConfigurationOptionId_Sequence]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_ConfigurationConditionFilter_ConfigurationOptionId_Sequence] ON [dbo].[ConfigurationConditionFilter]
(
	[ConfigurationOptionConditionId] ASC,
	[Sequence] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_ConfigurationOption_ConfigurationPageId_Name]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_ConfigurationOption_ConfigurationPageId_Name] ON [dbo].[ConfigurationOption]
(
	[ConfigurationPageId] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ConfigurationOption_ParentId]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_ConfigurationOption_ParentId] ON [dbo].[ConfigurationOption]
(
	[ParentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ConfigurationOptionCondition_ConfigurationOptionId_Sequence]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_ConfigurationOptionCondition_ConfigurationOptionId_Sequence] ON [dbo].[ConfigurationOptionCondition]
(
	[ConfigurationOptionId] ASC,
	[Sequence] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ConfigurationPage_ConfigurationId_PageNumber]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_ConfigurationPage_ConfigurationId_PageNumber] ON [dbo].[ConfigurationPage]
(
	[ConfigurationId] ASC,
	[PageNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_ConfigurationQueryResult_QueryName]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_ConfigurationQueryResult_QueryName] ON [dbo].[ConfigurationQueryResult]
(
	[QueryName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_Content_9_1092914965__K2_5]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [_dta_index_Content_9_1092914965__K2_5] ON [dbo].[Content]
(
	[ContentManagerId] ASC
)
INCLUDE ( 	[Html]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ContentItem_ContentKey]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_ContentItem_ContentKey] ON [dbo].[ContentItem]
(
	[ContentKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ContentItem_PageContentKey]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_ContentItem_PageContentKey] ON [dbo].[ContentItem]
(
	[PageContentKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ContentItem_ParentContentKey]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_ContentItem_ParentContentKey] ON [dbo].[ContentItem]
(
	[ParentContentKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ContentItemField_ContentKeyPublishOn]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_ContentItemField_ContentKeyPublishOn] ON [dbo].[ContentItemField]
(
	[ContentKey] ASC,
	[PublishOn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_CreditCardTransaction_AuthCode]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_CreditCardTransaction_AuthCode] ON [dbo].[CreditCardTransaction]
(
	[AuthCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_CreditCardTransaction_CustomerNumber]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_CreditCardTransaction_CustomerNumber] ON [dbo].[CreditCardTransaction]
(
	[CustomerNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_CreditCardTransaction_OrderNumber]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_CreditCardTransaction_OrderNumber] ON [dbo].[CreditCardTransaction]
(
	[OrderNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_CreditCardTransaction_OrigId]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_CreditCardTransaction_OrigId] ON [dbo].[CreditCardTransaction]
(
	[OrigId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_CreditCardTransaction_ShipmentNumber]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_CreditCardTransaction_ShipmentNumber] ON [dbo].[CreditCardTransaction]
(
	[ShipmentNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Customer_CustNumCustSeq]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Customer_CustNumCustSeq] ON [dbo].[Customer]
(
	[CustomerNumber] ASC,
	[CustomerSequence] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Customer_CustomerNumber]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_Customer_CustomerNumber] ON [dbo].[Customer]
(
	[CustomerNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Customer_ParentId]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_Customer_ParentId] ON [dbo].[Customer]
(
	[ParentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_CustomerBudget_Customer_ShipToCustomer_UserProfile_FiscalYear]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_CustomerBudget_Customer_ShipToCustomer_UserProfile_FiscalYear] ON [dbo].[CustomerBudget]
(
	[CustomerId] ASC,
	[ShipToCustomerId] ASC,
	[UserProfileId] ASC,
	[FiscalYear] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_CustomerOrder_CustomerId]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_CustomerOrder_CustomerId] ON [dbo].[CustomerOrder]
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_CustomerOrder_ERPOrderNumber]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_CustomerOrder_ERPOrderNumber] ON [dbo].[CustomerOrder]
(
	[ERPOrderNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_CustomerOrder_ShipToId]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_CustomerOrder_ShipToId] ON [dbo].[CustomerOrder]
(
	[ShipToId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Order_CustomerNumber]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_Order_CustomerNumber] ON [dbo].[CustomerOrder]
(
	[CustomerNumber] ASC,
	[CustomerSequence] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Order_OrderNumber]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Order_OrderNumber] ON [dbo].[CustomerOrder]
(
	[OrderNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Order_Status]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_Order_Status] ON [dbo].[CustomerOrder]
(
	[Status] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_CustomerOrderProperty_Name]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_CustomerOrderProperty_Name] ON [dbo].[CustomerOrderProperty]
(
	[CustomerOrderId] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_CustomerProduct]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_CustomerProduct] ON [dbo].[CustomerProduct]
(
	[CustomerId] ASC,
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_CustomerProductPrice_Customer_Product]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_CustomerProductPrice_Customer_Product] ON [dbo].[CustomerProductPrice]
(
	[CustomerId] ASC,
	[ProductId] ASC,
	[BreakQty] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_CustomerProductSet_CustomerId]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_CustomerProductSet_CustomerId] ON [dbo].[CustomerProductSet]
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_CustomerProductSetProduct_ParentId]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_CustomerProductSetProduct_ParentId] ON [dbo].[CustomerProductSetProduct]
(
	[CustomerProductSetId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_CustomerProductSetProduct_ProductId]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_CustomerProductSetProduct_ProductId] ON [dbo].[CustomerProductSetProduct]
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_CustomerProperty]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_CustomerProperty] ON [dbo].[CustomerProperty]
(
	[CustomerId] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_CustomProperty]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_CustomProperty] ON [dbo].[CustomProperty]
(
	[ParentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_DashboardPanelPosition_UserProfile_PanelType]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_DashboardPanelPosition_UserProfile_PanelType] ON [dbo].[DashboardPanelPosition]
(
	[UserProfileId] ASC,
	[PanelType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_DictionaryAttribute]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_DictionaryAttribute] ON [dbo].[DictionaryAttribute]
(
	[ApplicationDictionaryId] ASC,
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_DictionaryLabel]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_DictionaryLabel] ON [dbo].[DictionaryLabel]
(
	[ApplicationDictionaryId] ASC,
	[LanguageCode] ASC,
	[SystemLabel] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Document_DocumentManagerId]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_Document_DocumentManagerId] ON [dbo].[Document]
(
	[DocumentManagerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_ELMAH_Error_App_Time_Seq]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_ELMAH_Error_App_Time_Seq] ON [dbo].[ELMAH_Error]
(
	[Application] ASC,
	[TimeUtc] DESC,
	[Sequence] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_EmailMessageDeliveryAttempt_EmailMessage]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_EmailMessageDeliveryAttempt_EmailMessage] ON [dbo].[EmailMessageDeliveryAttempt]
(
	[EmailMessageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_FilterSection]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_FilterSection] ON [dbo].[FilterSection]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_FilterValue]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_FilterValue] ON [dbo].[FilterValue]
(
	[FilterSectionId] ASC,
	[Value] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_GiftCard]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_GiftCard] ON [dbo].[GiftCard]
(
	[GiftCardNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_GlobalSynonym_Lookup]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_GlobalSynonym_Lookup] ON [dbo].[GlobalSynonym]
(
	[LookupValue] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_IntegrationConnection_Name]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_IntegrationConnection_Name] ON [dbo].[IntegrationConnection]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_IntegrationJob_JobDefinition]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_IntegrationJob_JobDefinition] ON [dbo].[IntegrationJob]
(
	[IntegrationJobDefinitionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_IntegrationJob_JobNumber]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_IntegrationJob_JobNumber] ON [dbo].[IntegrationJob]
(
	[JobNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_IntegrationJob_StartDateTime]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_IntegrationJob_StartDateTime] ON [dbo].[IntegrationJob]
(
	[StartDateTime] ASC,
	[IsRealTime] ASC,
	[ScheduleDateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Index [IX_IntegrationJob_StartDateTime_IsRealTime_ScheduleDateTime]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_IntegrationJob_StartDateTime_IsRealTime_ScheduleDateTime] ON [dbo].[IntegrationJob]
(
	[StartDateTime] ASC,
	[IsRealTime] ASC,
	[ScheduleDateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_IntegrationJobDefinition_Name]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_IntegrationJobDefinition_Name] ON [dbo].[IntegrationJobDefinition]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_IntegrationJobDefinitionPostprocessorParameter_Name]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_IntegrationJobDefinitionPostprocessorParameter_Name] ON [dbo].[IntegrationJobDefinitionPostprocessorParameter]
(
	[IntegrationJobDefinitionId] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_IntegrationJobDefinitionStep_Sequence]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_IntegrationJobDefinitionStep_Sequence] ON [dbo].[IntegrationJobDefinitionStep]
(
	[IntegrationJobDefinitionId] ASC,
	[Sequence] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_IntegrationJobDefinitionStepFieldMap]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_IntegrationJobDefinitionStepFieldMap] ON [dbo].[IntegrationJobDefinitionStepFieldMap]
(
	[IntegrationJobDefinitionStepId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_IntegrationJobDefinitionStepParameter_Name]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_IntegrationJobDefinitionStepParameter_Name] ON [dbo].[IntegrationJobDefinitionStepParameter]
(
	[IntegrationJobDefinitionStepId] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_IntegrationJob]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_IntegrationJob] ON [dbo].[IntegrationJobLog]
(
	[IntegrationJobId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_IntegrationJobParameter_StepParameter]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_IntegrationJobParameter_StepParameter] ON [dbo].[IntegrationJobParameter]
(
	[IntegrationJobId] ASC,
	[IntegrationJobDefinitionStepParameterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_InventoryTransaction]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_InventoryTransaction] ON [dbo].[InventoryTransaction]
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Invoice_CustomerId]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_Invoice_CustomerId] ON [dbo].[Invoice]
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Invoice_InvoiceNumber]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_Invoice_InvoiceNumber] ON [dbo].[Invoice]
(
	[InvoiceNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Invoice_OrderNumber]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_Invoice_OrderNumber] ON [dbo].[Invoice]
(
	[OrderNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Invoice_ShipToId]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_Invoice_ShipToId] ON [dbo].[Invoice]
(
	[ShipToId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_InvoiceHistory_SearchColumns]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_InvoiceHistory_SearchColumns] ON [dbo].[InvoiceHistory]
(
	[CustomerNumber] ASC,
	[InvoiceDate] ASC,
	[IsOpen] ASC,
	[InvoiceNumber] ASC,
	[CustomerSequence] ASC,
	[CustomerPO] ASC
)
INCLUDE ( 	[InvoiceHistoryId],
	[DueDate],
	[InvoiceType],
	[Status],
	[CurrencyCode],
	[Terms],
	[ShipCode],
	[Salesperson],
	[BTCompanyName],
	[BTAddress1],
	[BTAddress2],
	[BTCity],
	[BTState],
	[BTPostalCode],
	[BTCountry],
	[STCompanyName],
	[STAddress1],
	[STAddress2],
	[STCity],
	[STState],
	[STPostalCode],
	[STCountry],
	[Notes],
	[ProductTotal],
	[DiscountAmount],
	[ShippingAndHandling],
	[OtherCharges],
	[TaxAmount],
	[InvoiceTotal],
	[CurrentBalance]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_InvoiceHistoryLine_SearchColumns]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_InvoiceHistoryLine_SearchColumns] ON [dbo].[InvoiceHistoryLine]
(
	[InvoiceHistoryId] ASC,
	[ERPOrderNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_InvoiceLine_InvoiceId]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_InvoiceLine_InvoiceId] ON [dbo].[InvoiceLine]
(
	[InvoiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Language_LanguageCode]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Language_LanguageCode] ON [dbo].[Language]
(
	[LanguageCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_LocalizedTaxRateByPostalCode]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_LocalizedTaxRateByPostalCode] ON [dbo].[LocalTaxRate]
(
	[Zip] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Message_Subject_DateToDisplay]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Message_Subject_DateToDisplay] ON [dbo].[Message]
(
	[Subject] ASC,
	[DateToDisplay] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_MessageStatus_Message_UserProfile]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_MessageStatus_Message_UserProfile] ON [dbo].[MessageStatus]
(
	[MessageId] ASC,
	[UserProfileId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_MessageTarget_Message]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_MessageTarget_Message] ON [dbo].[MessageTarget]
(
	[MessageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_MessageTarget_TargetType_TargetKey]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_MessageTarget_TargetType_TargetKey] ON [dbo].[MessageTarget]
(
	[MessageId] ASC,
	[TargetType] ASC,
	[TargetKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_MiscellaneousCode]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_MiscellaneousCode] ON [dbo].[MiscellaneousCode]
(
	[ParentId] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_OrderHistory_ERPOrderNumber]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_OrderHistory_ERPOrderNumber] ON [dbo].[OrderHistory]
(
	[ERPOrderNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_OrderHistory_SearchColumns]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_OrderHistory_SearchColumns] ON [dbo].[OrderHistory]
(
	[CustomerNumber] ASC,
	[OrderDate] ASC,
	[WebOrderNumber] ASC,
	[ERPOrderNumber] ASC,
	[CustomerSequence] ASC,
	[Status] ASC,
	[OrderTotal] ASC,
	[CustomerPO] ASC
)
INCLUDE ( 	[CurrencyCode],
	[Terms],
	[ShipCode],
	[Salesperson],
	[BTCompanyName],
	[BTAddress1],
	[BTAddress2],
	[BTCity],
	[BTState],
	[BTPostalCode],
	[BTCountry],
	[STCompanyName],
	[STAddress1],
	[STAddress2],
	[STCity],
	[STState],
	[STPostalCode],
	[STCountry],
	[Notes],
	[ProductTotal],
	[DiscountAmount],
	[ShippingAndHandling],
	[OtherCharges],
	[TaxAmount],
	[ModifyDate],
	[ConversionRate]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_OrderHistory_WebOrderNumber]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_OrderHistory_WebOrderNumber] ON [dbo].[OrderHistory]
(
	[WebOrderNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_OrderHistoryLine_CustomerNumberSequence]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_OrderHistoryLine_CustomerNumberSequence] ON [dbo].[OrderHistoryLine]
(
	[CustomerNumber] ASC,
	[CustomerSequence] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_OrderHistoryLine_OrderHistory]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_OrderHistoryLine_OrderHistory] ON [dbo].[OrderHistoryLine]
(
	[OrderHistoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_OrderHistoryLine_ProductERPNumber]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_OrderHistoryLine_ProductERPNumber] ON [dbo].[OrderHistoryLine]
(
	[ProductERPNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_OrderLine_Line]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_OrderLine_Line] ON [dbo].[OrderLine]
(
	[CustomerOrderId] ASC,
	[Line] ASC,
	[Release] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_OrderLineAttribute]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_OrderLineAttribute] ON [dbo].[OrderLineAttribute]
(
	[OrderLineId] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_OrderLineConfigurationValue_ConfigurationOptionId]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_OrderLineConfigurationValue_ConfigurationOptionId] ON [dbo].[OrderLineConfigurationValue]
(
	[ConfigurationOptionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_OrderLineConfigurationValue_OrderLineId]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_OrderLineConfigurationValue_OrderLineId] ON [dbo].[OrderLineConfigurationValue]
(
	[OrderLineId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PackageLine_OrderLineId]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_PackageLine_OrderLineId] ON [dbo].[PackageLine]
(
	[OrderLineId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PackageLine_ShipmentPackageId]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_PackageLine_ShipmentPackageId] ON [dbo].[PackageLine]
(
	[ShipmentPackageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Persona_Name]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Persona_Name] ON [dbo].[Persona]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Plugin]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Plugin] ON [dbo].[Plugin]
(
	[Name] ASC,
	[ConnectionName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_PriceMatrix]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_PriceMatrix] ON [dbo].[PriceMatrix]
(
	[RecordType] ASC,
	[CurrencyCode] ASC,
	[Warehouse] ASC,
	[UnitOfMeasure] ASC,
	[CustomerKeyPart] ASC,
	[ProductKeyPart] ASC,
	[Active] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_PriceMatrix_ProductKeyPart]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_PriceMatrix_ProductKeyPart] ON [dbo].[PriceMatrix]
(
	[ProductKeyPart] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_PriceMatrix_Batch]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_PriceMatrix_Batch] ON [dbo].[PriceMatrix_Batch]
(
	[RecordType] ASC,
	[CurrencyCode] ASC,
	[Warehouse] ASC,
	[UnitOfMeasure] ASC,
	[CustomerKeyPart] ASC,
	[ProductKeyPart] ASC,
	[Active] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Product]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Product] ON [dbo].[Product]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Product_Configuration]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_Product_Configuration] ON [dbo].[Product]
(
	[ConfigurationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Product_ERPNumber]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_Product_ERPNumber] ON [dbo].[Product]
(
	[ERPNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Product_IndexStatus]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_Product_IndexStatus] ON [dbo].[Product]
(
	[IndexStatus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Product_ManufacturerItem]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_Product_ManufacturerItem] ON [dbo].[Product]
(
	[ManufacturerItem] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Product_Sku]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_Product_Sku] ON [dbo].[Product]
(
	[Sku] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Product_StyleClassId]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_Product_StyleClassId] ON [dbo].[Product]
(
	[StyleClassId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Product_StyleParentId]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_Product_StyleParentId] ON [dbo].[Product]
(
	[StyleParentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Product_Unspsc]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_Product_Unspsc] ON [dbo].[Product]
(
	[Unspsc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Product_UPCCode]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_Product_UPCCode] ON [dbo].[Product]
(
	[UPCCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ProductPrice_ProductId]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_ProductPrice_ProductId] ON [dbo].[ProductPrice]
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_ProductProperty]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_ProductProperty] ON [dbo].[ProductProperty]
(
	[ProductId] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [_dta_index_ProductSpecification_9_1364915934__K2_K1]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [_dta_index_ProductSpecification_9_1364915934__K2_K1] ON [dbo].[ProductSpecification]
(
	[SpecificationId] ASC,
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_ProductUnitOfMeasure_ProductIdUnitOfMeasure]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_ProductUnitOfMeasure_ProductIdUnitOfMeasure] ON [dbo].[ProductUnitOfMeasure]
(
	[ProductId] ASC,
	[UnitOfMeasure] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ProductWarehouse_ProductIdWarehouseId]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_ProductWarehouse_ProductIdWarehouseId] ON [dbo].[ProductWarehouse]
(
	[ProductId] ASC,
	[WarehouseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_RuleClause_RuleManagerId]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_RuleClause_RuleManagerId] ON [dbo].[RuleClause]
(
	[RuleManagerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_RuleType_Name]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_RuleType_Name] ON [dbo].[RuleType]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_RuleTypeOption_RuleTypeId]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_RuleTypeOption_RuleTypeId] ON [dbo].[RuleTypeOption]
(
	[RuleTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_SalesmanNumber]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_SalesmanNumber] ON [dbo].[Salesman]
(
	[SalesmanNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_SearchSynonym_Synonym]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_SearchSynonym_Synonym] ON [dbo].[SearchSynonym]
(
	[Synonym] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_SearchSynonym_Word]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_SearchSynonym_Word] ON [dbo].[SearchSynonym]
(
	[Word] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Shipment_ERPOrderNumber]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_Shipment_ERPOrderNumber] ON [dbo].[Shipment]
(
	[ERPOrderNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Shipment_ShipmentNumber]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_Shipment_ShipmentNumber] ON [dbo].[Shipment]
(
	[ShipmentNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Shipment_WebOrderNumber]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_Shipment_WebOrderNumber] ON [dbo].[Shipment]
(
	[WebOrderNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ShipmentPackage_ShipmentId]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_ShipmentPackage_ShipmentId] ON [dbo].[ShipmentPackage]
(
	[ShipmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_ShippingClassification_Classification]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_ShippingClassification_Classification] ON [dbo].[ShippingClassification]
(
	[Classification] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_ShipVia_Carrier_ShipCode]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_ShipVia_Carrier_ShipCode] ON [dbo].[ShipVia]
(
	[CarrierId] ASC,
	[ShipCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [_dta_index_Specification_9_1752393312__K3_K1]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [_dta_index_Specification_9_1752393312__K3_K1] ON [dbo].[Specification]
(
	[ContentManagerId] ASC,
	[SpecificationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Abbreviation]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_Abbreviation] ON [dbo].[State]
(
	[Abbreviation] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_StyleClass_Name]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_StyleClass_Name] ON [dbo].[StyleClass]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_StyleTrait_Name]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_StyleTrait_Name] ON [dbo].[StyleTrait]
(
	[StyleClassId] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_StyleTraitValue_Value]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_StyleTraitValue_Value] ON [dbo].[StyleTraitValue]
(
	[StyleTraitId] ASC,
	[Value] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [ix_custnum]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [ix_custnum] ON [dbo].[tmp_PriceData]
(
	[CustNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [ix_customerkeypart]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [ix_customerkeypart] ON [dbo].[tmp_PriceData]
(
	[CustomerKeyPart] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [ix_partnum]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [ix_partnum] ON [dbo].[tmp_PriceData]
(
	[PartNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [ix_productkeypart]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [ix_productkeypart] ON [dbo].[tmp_PriceData]
(
	[ProductKeyPart] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [ix_recordtype]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [ix_recordtype] ON [dbo].[tmp_PriceData]
(
	[RecordType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [ix_shiptonum]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [ix_shiptonum] ON [dbo].[tmp_PriceData]
(
	[ShipToNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_TranslationDictionary_SourceKeywordLanguageCode]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_TranslationDictionary_SourceKeywordLanguageCode] ON [dbo].[TranslationDictionary]
(
	[LanguageCode] ASC,
	[Source] ASC,
	[Keyword] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_TranslationProperty_LanguageCode]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_TranslationProperty_LanguageCode] ON [dbo].[TranslationProperty]
(
	[LanguageCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_TranslationProperty_ParentNameLanguageCode]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_TranslationProperty_ParentNameLanguageCode] ON [dbo].[TranslationProperty]
(
	[ParentTable] ASC,
	[ParentId] ASC,
	[Name] ASC,
	[LanguageCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_TranslationProperty_ParentTable]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_TranslationProperty_ParentTable] ON [dbo].[TranslationProperty]
(
	[ParentTable] ASC
)
INCLUDE ( 	[ParentId],
	[LanguageCode],
	[TranslatedValue]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_UserProfile]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_UserProfile] ON [dbo].[UserProfile]
(
	[UserName] ASC,
	[ApplicationName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Vendor_Name]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE NONCLUSTERED INDEX [IX_Vendor_Name] ON [dbo].[Vendor]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Vendor_VendorNumber]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Vendor_VendorNumber] ON [dbo].[Vendor]
(
	[VendorNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_WebPage]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_WebPage] ON [dbo].[WebPage]
(
	[Name] ASC,
	[WebSiteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_WebPageContent_Name]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_WebPageContent_Name] ON [dbo].[WebPageContent]
(
	[WebSiteId] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_WebSite]    Script Date: 3/18/2016 10:25:36 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_WebSite] ON [dbo].[WebSite]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Affiliate] ADD  CONSTRAINT [DF_Affiliate_AffiliateId]  DEFAULT (newsequentialid()) FOR [AffiliateId]
GO
ALTER TABLE [dbo].[Affiliate] ADD  CONSTRAINT [DF_Affiliate_Name]  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[Affiliate] ADD  CONSTRAINT [DF_Affiliate_Image]  DEFAULT ('') FOR [Image]
GO
ALTER TABLE [dbo].[Affiliate] ADD  CONSTRAINT [DF_Affiliate_Active]  DEFAULT ((0)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Affiliate] ADD  CONSTRAINT [DF_Affiliate_Description]  DEFAULT ('') FOR [Description]
GO
ALTER TABLE [dbo].[Affiliate] ADD  CONSTRAINT [DF_Affiliate_SiteUrl]  DEFAULT ('') FOR [Url]
GO
ALTER TABLE [dbo].[Affiliate] ADD  CONSTRAINT [DF_Affiliate_ReplaceLogoImage]  DEFAULT ((0)) FOR [ReplaceLogoImage]
GO
ALTER TABLE [dbo].[aspnet_Paths] ADD  CONSTRAINT [DF_aspnet_Paths_PathId]  DEFAULT (newid()) FOR [PathId]
GO
ALTER TABLE [dbo].[aspnet_PersonalizationPerUser] ADD  CONSTRAINT [DF_aspnet_PersonalizationPerUser_Id]  DEFAULT (newid()) FOR [Id]
GO
ALTER TABLE [dbo].[BudgetCalendar] ADD  CONSTRAINT [DF_BudgetCalendar_BudgetCalendarId]  DEFAULT (newsequentialid()) FOR [BudgetCalendarId]
GO
ALTER TABLE [dbo].[BudgetCalendar] ADD  CONSTRAINT [DF_BudgetCalendar_FiscalYear]  DEFAULT ((0)) FOR [FiscalYear]
GO
ALTER TABLE [dbo].[CarrierZone] ADD  CONSTRAINT [DF_CarrierZone_CarrierZoneId]  DEFAULT (newsequentialid()) FOR [CarrierZoneId]
GO
ALTER TABLE [dbo].[CarrierZone] ADD  CONSTRAINT [DF_CarrierZone_Zone]  DEFAULT ('') FOR [Zone]
GO
ALTER TABLE [dbo].[CarrierZoneRate] ADD  CONSTRAINT [DF_CarrierZoneRate_CarrierZoneRateId]  DEFAULT (newsequentialid()) FOR [CarrierZoneRateId]
GO
ALTER TABLE [dbo].[CarrierZoneRate] ADD  CONSTRAINT [DF_CarrierZoneRate_Weight]  DEFAULT ((0)) FOR [Weight]
GO
ALTER TABLE [dbo].[CarrierZoneRate] ADD  CONSTRAINT [DF_CarrierZoneRate_Rate]  DEFAULT ((0)) FOR [Rate]
GO
ALTER TABLE [dbo].[CarrierZoneZipCodeRange] ADD  CONSTRAINT [DF_CarrierZoneZipCodeRange_CarrierZoneZipCodeRangeId]  DEFAULT (newsequentialid()) FOR [CarrierZoneZipCodeRangeId]
GO
ALTER TABLE [dbo].[CarrierZoneZipCodeRange] ADD  CONSTRAINT [DF_CarrierZoneZipCodeRange_ZipStartRange]  DEFAULT ('') FOR [ZipStartRange]
GO
ALTER TABLE [dbo].[CarrierZoneZipCodeRange] ADD  CONSTRAINT [DF_CarrierZoneZipCodeRange_ZipEndRange]  DEFAULT ('') FOR [ZipEndRange]
GO
ALTER TABLE [dbo].[CategoryFilterSection] ADD  CONSTRAINT [DF_CategoryFilterSection_CategoryFilterSectionId]  DEFAULT (newsequentialid()) FOR [CategoryFilterSectionId]
GO
ALTER TABLE [dbo].[CategoryFilterSection] ADD  CONSTRAINT [DF_CategoryFilterSection_SortOrder]  DEFAULT ((0)) FOR [SortOrder]
GO
ALTER TABLE [dbo].[CategoryFilterSection] ADD  CONSTRAINT [DF_CategoryFilterSection_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[CategoryFilterSection] ADD  CONSTRAINT [DF_CategoryFilterSection_DetailDisplaySequence]  DEFAULT (NULL) FOR [DetailDisplaySequence]
GO
ALTER TABLE [dbo].[CategoryProperty] ADD  CONSTRAINT [DF_CategoryProperty_CategoryPropertyId]  DEFAULT (newsequentialid()) FOR [CategoryPropertyId]
GO
ALTER TABLE [dbo].[CategoryProperty] ADD  CONSTRAINT [DF_CategoryProperty_Name]  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[CategoryProperty] ADD  CONSTRAINT [DF_CategoryProperty_Value]  DEFAULT ('') FOR [Value]
GO
ALTER TABLE [dbo].[City] ADD  CONSTRAINT [DF_City_CityId]  DEFAULT (newsequentialid()) FOR [CityId]
GO
ALTER TABLE [dbo].[City] ADD  CONSTRAINT [DF_City_CityName]  DEFAULT ('') FOR [CityName]
GO
ALTER TABLE [dbo].[Configuration] ADD  CONSTRAINT [DF_Configuration_ConfigurationId]  DEFAULT (newsequentialid()) FOR [ConfigurationId]
GO
ALTER TABLE [dbo].[Configuration] ADD  CONSTRAINT [DF_ConfigurationHeader_Revision]  DEFAULT ('') FOR [Revision]
GO
ALTER TABLE [dbo].[Configuration] ADD  CONSTRAINT [DF_ConfigurationHeader_HasSmartPart]  DEFAULT ((0)) FOR [HasSmartPart]
GO
ALTER TABLE [dbo].[Configuration] ADD  CONSTRAINT [DF_ConfigurationHeader_SmartPartSeparator]  DEFAULT ('') FOR [SmartPartSeparator]
GO
ALTER TABLE [dbo].[Configuration] ADD  CONSTRAINT [DF_ConfigurationHeader_SmartPartPrefix]  DEFAULT ('') FOR [SmartPartPrefix]
GO
ALTER TABLE [dbo].[Configuration] ADD  CONSTRAINT [DF_ConfigurationHeader_ScriptOnInitialize]  DEFAULT ('') FOR [ScriptOnInitialize]
GO
ALTER TABLE [dbo].[Configuration] ADD  CONSTRAINT [DF_ConfigurationHeader_ScriptOnFinalize]  DEFAULT ('') FOR [ScriptOnFinalize]
GO
ALTER TABLE [dbo].[Configuration] ADD  CONSTRAINT [DF_ConfigurationHeader_OverrideOnRefresh]  DEFAULT ((1)) FOR [OverrideOnRefresh]
GO
ALTER TABLE [dbo].[Configuration] ADD  CONSTRAINT [DF_ConfigurationHeader_DisplaySummary]  DEFAULT ((1)) FOR [DisplaySummary]
GO
ALTER TABLE [dbo].[Configuration] ADD  CONSTRAINT [DF_Configuration_ScriptOnPricingRequest]  DEFAULT ('') FOR [ScriptOnPricingRequest]
GO
ALTER TABLE [dbo].[Configuration] ADD  CONSTRAINT [DF_Configuration_Name]  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[ConfigurationConditionFilter] ADD  CONSTRAINT [DF_ConfigurationConditionFilter_ConfigurationConditionFilterId]  DEFAULT (newsequentialid()) FOR [ConfigurationConditionFilterId]
GO
ALTER TABLE [dbo].[ConfigurationConditionFilter] ADD  CONSTRAINT [DF_ConfigurationConditionFilter_ColumnName]  DEFAULT ('') FOR [ColumnName]
GO
ALTER TABLE [dbo].[ConfigurationConditionFilter] ADD  CONSTRAINT [DF_ConfigurationConditionFilter_ValueFrom]  DEFAULT ('') FOR [ValueFrom]
GO
ALTER TABLE [dbo].[ConfigurationOption] ADD  CONSTRAINT [DF_ConfigurationOption_ConfigurationOptionId]  DEFAULT (newsequentialid()) FOR [ConfigurationOptionId]
GO
ALTER TABLE [dbo].[ConfigurationOptionCondition] ADD  CONSTRAINT [DF_ConfigurationOptionCondition_ConfigurationOptionConditionId]  DEFAULT (newsequentialid()) FOR [ConfigurationOptionConditionId]
GO
ALTER TABLE [dbo].[ConfigurationOptionCondition] ADD  CONSTRAINT [DF_ConfigurationOptionCondition_Sequence]  DEFAULT ('') FOR [Sequence]
GO
ALTER TABLE [dbo].[ConfigurationOptionCondition] ADD  CONSTRAINT [DF_ConfigurationOptionCondition_ScriptCondition]  DEFAULT ('') FOR [ScriptConditionOriginal]
GO
ALTER TABLE [dbo].[ConfigurationOptionCondition] ADD  CONSTRAINT [DF_ConfigurationOptionCondition_QueryName]  DEFAULT ('') FOR [QueryName]
GO
ALTER TABLE [dbo].[ConfigurationOptionCondition] ADD  CONSTRAINT [DF_ConfigurationOptionCondition_QueryDisplayField]  DEFAULT ('') FOR [QueryDisplayField]
GO
ALTER TABLE [dbo].[ConfigurationOptionCondition] ADD  CONSTRAINT [DF_ConfigurationOptionCondition_QueryInputField]  DEFAULT ('') FOR [QueryInputField]
GO
ALTER TABLE [dbo].[ConfigurationOptionCondition] ADD  CONSTRAINT [DF_ConfigurationOptionCondition_SelectionListValues]  DEFAULT ('') FOR [SelectionListValues]
GO
ALTER TABLE [dbo].[ConfigurationOptionCondition] ADD  CONSTRAINT [DF_ConfigurationOptionCondition_SelectionListDisplays]  DEFAULT ('') FOR [SelectionListDisplays]
GO
ALTER TABLE [dbo].[ConfigurationOptionCondition] ADD  CONSTRAINT [DF_ConfigurationOptionCondition_SelectionListPriceAdjustment]  DEFAULT ('') FOR [SelectionListPriceAdjustment]
GO
ALTER TABLE [dbo].[ConfigurationOptionCondition] ADD  CONSTRAINT [DF_ConfigurationOptionCondition_DefaultValue]  DEFAULT ('') FOR [DefaultValue]
GO
ALTER TABLE [dbo].[ConfigurationPage] ADD  CONSTRAINT [DF_ConfigurationPage_ConfigurationPageId]  DEFAULT (newsequentialid()) FOR [ConfigurationPageId]
GO
ALTER TABLE [dbo].[ConfigurationPage] ADD  CONSTRAINT [DF_ConfigurationPage_PageNumber]  DEFAULT ((1)) FOR [PageNumber]
GO
ALTER TABLE [dbo].[ConfigurationPage] ADD  CONSTRAINT [DF_ConfigurationPage_PageTitle]  DEFAULT ('') FOR [PageTitle]
GO
ALTER TABLE [dbo].[ConfigurationPage] ADD  CONSTRAINT [DF_ConfigurationPage_SkipIfNoInputs]  DEFAULT ((1)) FOR [SkipIfNoInputs]
GO
ALTER TABLE [dbo].[ConfigurationPage] ADD  CONSTRAINT [DF_ConfigurationPage_SkipScriptsIfNoInputs]  DEFAULT ((1)) FOR [SkipScriptsIfNoInputs]
GO
ALTER TABLE [dbo].[ConfigurationPage] ADD  CONSTRAINT [DF_ConfigurationPage_ScriptPromptWhen]  DEFAULT ('') FOR [ScriptPromptWhen]
GO
ALTER TABLE [dbo].[ConfigurationPage] ADD  CONSTRAINT [DF_ConfigurationPage_ScriptOnEntry]  DEFAULT ('') FOR [ScriptOnEntry]
GO
ALTER TABLE [dbo].[ConfigurationPage] ADD  CONSTRAINT [DF_ConfigurationPage_ScriptPassFail]  DEFAULT ('') FOR [ScriptPassFail]
GO
ALTER TABLE [dbo].[ConfigurationPage] ADD  CONSTRAINT [DF_ConfigurationPage_ScriptOnLeave]  DEFAULT ('') FOR [ScriptOnLeave]
GO
ALTER TABLE [dbo].[ConfigurationPage] ADD  CONSTRAINT [DF_ConfigurationPage_OverrideHtmlOutput]  DEFAULT ((0)) FOR [OverrideHtmlOutput]
GO
ALTER TABLE [dbo].[ConfigurationPage] ADD  CONSTRAINT [DF_ConfigurationPage_CssOutput]  DEFAULT ('') FOR [CssOutput]
GO
ALTER TABLE [dbo].[ConfigurationPage] ADD  CONSTRAINT [DF_ConfigurationPage_OverrideCssOutput]  DEFAULT ((0)) FOR [OverrideCssOutput]
GO
ALTER TABLE [dbo].[ConfigurationPage] ADD  CONSTRAINT [DF_ConfigurationPage_JavaScriptOutput]  DEFAULT ('') FOR [JavaScriptOutput]
GO
ALTER TABLE [dbo].[ConfigurationPage] ADD  CONSTRAINT [DF_ConfigurationPage_OverrideJavaScriptOutput]  DEFAULT ((0)) FOR [OverrideJavaScriptOutput]
GO
ALTER TABLE [dbo].[ConfigurationQueryResult] ADD  CONSTRAINT [DF_ConfigurationQueryResult_ConfigurationQueryResultId]  DEFAULT (newsequentialid()) FOR [ConfigurationQueryResultId]
GO
ALTER TABLE [dbo].[ConfigurationQueryResult] ADD  CONSTRAINT [DF_ConfigurationQueryResults_QueryName]  DEFAULT ('') FOR [QueryName]
GO
ALTER TABLE [dbo].[ConfigurationQueryResult] ADD  CONSTRAINT [DF_ConfigurationQueryResults_ResultDataset]  DEFAULT ('') FOR [ResultDataset]
GO
ALTER TABLE [dbo].[ConfigurationQueryResultField] ADD  CONSTRAINT [DF_ConfigurationQueryResultField_ConfigurationQueryResultFieldId]  DEFAULT (newsequentialid()) FOR [ConfigurationQueryResultFieldId]
GO
ALTER TABLE [dbo].[ConfigurationQueryResultValue] ADD  CONSTRAINT [DF_ConfigurationQueryResultValue_ConfigurationQueryResultValueId]  DEFAULT (newsequentialid()) FOR [ConfigurationQueryResultValueId]
GO
ALTER TABLE [dbo].[County] ADD  CONSTRAINT [DF_County_CountyId]  DEFAULT (newsequentialid()) FOR [CountyId]
GO
ALTER TABLE [dbo].[County] ADD  CONSTRAINT [DF_County_StateId]  DEFAULT (newid()) FOR [StateId]
GO
ALTER TABLE [dbo].[County] ADD  CONSTRAINT [DF_County_Name]  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[CreditCardTransaction] ADD  CONSTRAINT [DF_CreditCardTransaction_CreditCardTransactionId]  DEFAULT (newsequentialid()) FOR [CreditCardTransactionId]
GO
ALTER TABLE [dbo].[CreditCardTransaction] ADD  CONSTRAINT [DF_CreditCardTransaction_TransactionType]  DEFAULT ('') FOR [TransactionType]
GO
ALTER TABLE [dbo].[CreditCardTransaction] ADD  CONSTRAINT [DF_CreditCardTransaction_Result]  DEFAULT ('') FOR [Result]
GO
ALTER TABLE [dbo].[CreditCardTransaction] ADD  CONSTRAINT [DF_CreditCardTransaction_AuthCode]  DEFAULT ('') FOR [AuthCode]
GO
ALTER TABLE [dbo].[CreditCardTransaction] ADD  CONSTRAINT [DF_CreditCardTransaction_PNRef]  DEFAULT ('') FOR [PNRef]
GO
ALTER TABLE [dbo].[CreditCardTransaction] ADD  CONSTRAINT [DF_CreditCardTransaction_RespMsg]  DEFAULT ('') FOR [RespMsg]
GO
ALTER TABLE [dbo].[CreditCardTransaction] ADD  CONSTRAINT [DF_CreditCardTransaction_RespText]  DEFAULT ('') FOR [RespText]
GO
ALTER TABLE [dbo].[CreditCardTransaction] ADD  CONSTRAINT [DF_CreditCardTransaction_AVSAddr]  DEFAULT ('') FOR [AVSAddr]
GO
ALTER TABLE [dbo].[CreditCardTransaction] ADD  CONSTRAINT [DF_CreditCardTransaction_AVSZip]  DEFAULT ('') FOR [AVSZip]
GO
ALTER TABLE [dbo].[CreditCardTransaction] ADD  CONSTRAINT [DF_CreditCardTransaction_CVV2Match]  DEFAULT ('') FOR [CVV2Match]
GO
ALTER TABLE [dbo].[CreditCardTransaction] ADD  CONSTRAINT [DF_CreditCardTransaction_RequestId]  DEFAULT ('') FOR [RequestId]
GO
ALTER TABLE [dbo].[CreditCardTransaction] ADD  CONSTRAINT [DF_CreditCardTransaction_RequestString]  DEFAULT ('') FOR [RequestString]
GO
ALTER TABLE [dbo].[CreditCardTransaction] ADD  CONSTRAINT [DF_CreditCardTransaction_ResponseString]  DEFAULT ('') FOR [ResponseString]
GO
ALTER TABLE [dbo].[CreditCardTransaction] ADD  CONSTRAINT [DF_CreditCardTransaction_Amount]  DEFAULT ((0)) FOR [Amount]
GO
ALTER TABLE [dbo].[CreditCardTransaction] ADD  CONSTRAINT [DF_CreditCardTransaction_Status]  DEFAULT ('') FOR [Status]
GO
ALTER TABLE [dbo].[CreditCardTransaction] ADD  CONSTRAINT [DF_CreditCardTransaction_CreditCardNumber]  DEFAULT ('') FOR [CreditCardNumber]
GO
ALTER TABLE [dbo].[CreditCardTransaction] ADD  CONSTRAINT [DF_CreditCardTransaction_Name]  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[CreditCardTransaction] ADD  CONSTRAINT [DF_CreditCardTransaction_ExpirationDate]  DEFAULT ('') FOR [ExpirationDate]
GO
ALTER TABLE [dbo].[CreditCardTransaction] ADD  CONSTRAINT [DF_CreditCardTransaction_OrderNumber]  DEFAULT ('') FOR [OrderNumber]
GO
ALTER TABLE [dbo].[CreditCardTransaction] ADD  CONSTRAINT [DF_CreditCardTransaction_ShipmentNumber]  DEFAULT ('') FOR [ShipmentNumber]
GO
ALTER TABLE [dbo].[CreditCardTransaction] ADD  CONSTRAINT [DF_CreditCardTransaction_CustomerNumber]  DEFAULT ('') FOR [CustomerNumber]
GO
ALTER TABLE [dbo].[CreditCardTransaction] ADD  CONSTRAINT [DF_CreditCardTransaction_Site]  DEFAULT ('') FOR [Site]
GO
ALTER TABLE [dbo].[CreditCardTransaction] ADD  CONSTRAINT [DF_CreditCardTransaction_OrigId]  DEFAULT ('') FOR [OrigId]
GO
ALTER TABLE [dbo].[CreditCardTransaction] ADD  CONSTRAINT [DF_CreditCardTransaction_BankCode]  DEFAULT ('') FOR [BankCode]
GO
ALTER TABLE [dbo].[CreditCardTransaction] ADD  CONSTRAINT [DF_CreditCardTransaction_CardType]  DEFAULT ('') FOR [CardType]
GO
ALTER TABLE [dbo].[CreditCardTransaction] ADD  CONSTRAINT [DF_CreditCardTransaction_PostedToERP]  DEFAULT ((0)) FOR [PostedToERP]
GO
ALTER TABLE [dbo].[CreditCardTransaction] ADD  CONSTRAINT [DF_CreditCardTransaction_InvoiceNumber]  DEFAULT ('') FOR [InvoiceNumber]
GO
ALTER TABLE [dbo].[CreditCardTransaction] ADD  CONSTRAINT [DF_CreditCardTransaction_CurrencyAmount]  DEFAULT ((0)) FOR [CurrencyAmount]
GO
ALTER TABLE [dbo].[CustomerBudget] ADD  CONSTRAINT [DF_CustomerBudget_CustomerBudgetId]  DEFAULT (newsequentialid()) FOR [CustomerBudgetId]
GO
ALTER TABLE [dbo].[CustomerBudget] ADD  CONSTRAINT [DF_CustomerBudget_FiscalYear]  DEFAULT ((0)) FOR [FiscalYear]
GO
ALTER TABLE [dbo].[CustomerCostCode] ADD  CONSTRAINT [DF_CustomerCostCode_CustomerCostCodeId]  DEFAULT (newsequentialid()) FOR [CustomerCostCodeId]
GO
ALTER TABLE [dbo].[CustomerCostCode] ADD  CONSTRAINT [DF_CustomerCostCode_CostCode]  DEFAULT ('') FOR [CostCode]
GO
ALTER TABLE [dbo].[CustomerCostCode] ADD  CONSTRAINT [DF_CustomerCostCode_Description]  DEFAULT ('') FOR [Description]
GO
ALTER TABLE [dbo].[CustomerCostCode] ADD  CONSTRAINT [DF_CustomerCostCode_IsActive]  DEFAULT ((0)) FOR [IsActive]
GO
ALTER TABLE [dbo].[CustomerDiscount] ADD  CONSTRAINT [DF_CustomerDiscount_CustomerDiscountId]  DEFAULT (newsequentialid()) FOR [CustomerDiscountId]
GO
ALTER TABLE [dbo].[CustomerDiscount] ADD  CONSTRAINT [DF_CustomerDiscount_CustomerId]  DEFAULT (newid()) FOR [CustomerId]
GO
ALTER TABLE [dbo].[CustomerDiscount] ADD  CONSTRAINT [DF_CustomerDiscount_WebSiteId]  DEFAULT (newid()) FOR [WebSiteId]
GO
ALTER TABLE [dbo].[CustomerDiscount] ADD  CONSTRAINT [DF_CustomerDiscount_Discount]  DEFAULT ((0)) FOR [Discount]
GO
ALTER TABLE [dbo].[CustomerDiscount] ADD  CONSTRAINT [DF_CustomerDiscount_ApplyDiscount]  DEFAULT ((0)) FOR [ApplyDiscount]
GO
ALTER TABLE [dbo].[CustomerDiscount] ADD  CONSTRAINT [DF_CustomerDiscount_Name]  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[CustomerDiscount] ADD  CONSTRAINT [DF_CustomerDiscount_Description]  DEFAULT ('') FOR [Description]
GO
ALTER TABLE [dbo].[CustomerOrderPromotion] ADD  CONSTRAINT [DF_CustomerOrderPromotion_CustomerOrderId]  DEFAULT (newid()) FOR [CustomerOrderId]
GO
ALTER TABLE [dbo].[CustomerOrderPromotion] ADD  CONSTRAINT [DF_CustomerOrderPromotion_PromotionId]  DEFAULT (newid()) FOR [PromotionId]
GO
ALTER TABLE [dbo].[CustomerProduct] ADD  CONSTRAINT [DF_CustomerProduct_CustomerProductId]  DEFAULT (newsequentialid()) FOR [CustomerProductId]
GO
ALTER TABLE [dbo].[CustomerProduct] ADD  CONSTRAINT [DF_CustomerProduct_CustomerId]  DEFAULT (newid()) FOR [CustomerId]
GO
ALTER TABLE [dbo].[CustomerProduct] ADD  CONSTRAINT [DF_CustomerProduct_ProductId]  DEFAULT (newid()) FOR [ProductId]
GO
ALTER TABLE [dbo].[CustomerProduct] ADD  CONSTRAINT [DF_CustomerProduct_Name]  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[CustomerProduct] ADD  CONSTRAINT [DF_CustomerProduct_UnitOfMeasure]  DEFAULT ('') FOR [UnitOfMeasure]
GO
ALTER TABLE [dbo].[CustomerProductPrice] ADD  CONSTRAINT [DF_CustomerProductPrice_CustomerProductPriceId]  DEFAULT (newsequentialid()) FOR [CustomerProductPriceId]
GO
ALTER TABLE [dbo].[CustomerProductPrice] ADD  CONSTRAINT [DF_CustomerProductPrice_BreakQty]  DEFAULT ((0)) FOR [BreakQty]
GO
ALTER TABLE [dbo].[CustomerProductPrice] ADD  CONSTRAINT [DF_CustomerProductPrice_Active]  DEFAULT (getdate()) FOR [Active]
GO
ALTER TABLE [dbo].[CustomerProductPrice] ADD  CONSTRAINT [DF_CustomerProductPrice_PricePerPiece]  DEFAULT ((0)) FOR [PricePerPiece]
GO
ALTER TABLE [dbo].[CustomerProductPrice] ADD  CONSTRAINT [DF_CustomerProductPrice_IsOnSale]  DEFAULT ((0)) FOR [IsOnSale]
GO
ALTER TABLE [dbo].[CustomerProductPrice] ADD  CONSTRAINT [DF_CustomerProductPrice_RegularMarkup]  DEFAULT ((0)) FOR [RegularMarkup]
GO
ALTER TABLE [dbo].[CustomerProductPrice] ADD  CONSTRAINT [DF_CustomerProductPrice_SaleMarkup]  DEFAULT ((0)) FOR [SaleMarkup]
GO
ALTER TABLE [dbo].[CustomerProductPrice] ADD  CONSTRAINT [DF_CustomerProductPrice_CurrencyCode]  DEFAULT ('') FOR [CurrencyCode]
GO
ALTER TABLE [dbo].[CustomerProductSet] ADD  CONSTRAINT [DF_CustomerProductSet_CustomerProductSetId]  DEFAULT (newsequentialid()) FOR [CustomerProductSetId]
GO
ALTER TABLE [dbo].[CustomerProductSet] ADD  CONSTRAINT [DF_CustomerProductSet_Name]  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[CustomerProductSet] ADD  CONSTRAINT [DF_CustomerProductSet_Description]  DEFAULT ('') FOR [Description]
GO
ALTER TABLE [dbo].[CustomerProductSet] ADD  CONSTRAINT [DF_CustomerProductSet_Active]  DEFAULT (getdate()) FOR [Active]
GO
ALTER TABLE [dbo].[CustomerProductSetProduct] ADD  CONSTRAINT [DF_CustomerProductSetProduct_CustomerProductSetProductId]  DEFAULT (newsequentialid()) FOR [CustomerProductSetProductId]
GO
ALTER TABLE [dbo].[CustomerProperty] ADD  CONSTRAINT [DF_CustomerProperty_CustomerPropertyId]  DEFAULT (newsequentialid()) FOR [CustomerPropertyId]
GO
ALTER TABLE [dbo].[CustomerProperty] ADD  CONSTRAINT [DF_CustomerProperty_CustomerId]  DEFAULT (newid()) FOR [CustomerId]
GO
ALTER TABLE [dbo].[CustomerProperty] ADD  CONSTRAINT [DF_CustomerProperty_Name]  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[CustomerProperty] ADD  CONSTRAINT [DF_CustomerProperty_Value]  DEFAULT ('') FOR [Value]
GO
ALTER TABLE [dbo].[CustomerSalesman] ADD  CONSTRAINT [DF_CustomerSalesman_CustomerId]  DEFAULT (newid()) FOR [CustomerId]
GO
ALTER TABLE [dbo].[CustomerSalesman] ADD  CONSTRAINT [DF_CustomerSalesman_SalesmanId]  DEFAULT (newid()) FOR [SalesmanId]
GO
ALTER TABLE [dbo].[DashboardPanelPosition] ADD  CONSTRAINT [DF_DashboardPanelPosition_DashboardPanelPositionId]  DEFAULT (newsequentialid()) FOR [DashboardPanelPositionId]
GO
ALTER TABLE [dbo].[DashboardPanelPosition] ADD  CONSTRAINT [DF_DashboardPanelPosition_PanelType]  DEFAULT ('') FOR [PanelType]
GO
ALTER TABLE [dbo].[DashboardPanelPosition] ADD  CONSTRAINT [DF_DashboardPanelPosition_SortOrder]  DEFAULT ((0)) FOR [SortOrder]
GO
ALTER TABLE [dbo].[Dealer] ADD  CONSTRAINT [DF_Dealer_DealerId]  DEFAULT (newsequentialid()) FOR [DealerId]
GO
ALTER TABLE [dbo].[Dealer] ADD  CONSTRAINT [DF_Dealers_Name]  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[Dealer] ADD  CONSTRAINT [DF_Dealers_Address1]  DEFAULT ('') FOR [Address1]
GO
ALTER TABLE [dbo].[Dealer] ADD  CONSTRAINT [DF_Dealers_Address2]  DEFAULT ('') FOR [Address2]
GO
ALTER TABLE [dbo].[Dealer] ADD  CONSTRAINT [DF_Dealers_City]  DEFAULT ('') FOR [City]
GO
ALTER TABLE [dbo].[Dealer] ADD  CONSTRAINT [DF_Dealers_State]  DEFAULT ('') FOR [State]
GO
ALTER TABLE [dbo].[Dealer] ADD  CONSTRAINT [DF_Dealers_Zip]  DEFAULT ('') FOR [Zip]
GO
ALTER TABLE [dbo].[Dealer] ADD  CONSTRAINT [DF_Dealers_Phone1]  DEFAULT ('') FOR [Phone1]
GO
ALTER TABLE [dbo].[Dealer] ADD  CONSTRAINT [DF_Dealers_Fax1]  DEFAULT ('') FOR [Fax1]
GO
ALTER TABLE [dbo].[Dealer] ADD  CONSTRAINT [DF_Dealers_Manager]  DEFAULT ('') FOR [Manager]
GO
ALTER TABLE [dbo].[Dealer] ADD  CONSTRAINT [DF_Dealer_Latitude]  DEFAULT ((0)) FOR [Latitude]
GO
ALTER TABLE [dbo].[Dealer] ADD  CONSTRAINT [DF_Dealer_Longitude]  DEFAULT ((0)) FOR [Longitude]
GO
ALTER TABLE [dbo].[Dealer] ADD  CONSTRAINT [DF_Dealer_WebsiteUrl]  DEFAULT ('') FOR [WebSiteUrl]
GO
ALTER TABLE [dbo].[DealerProperty] ADD  CONSTRAINT [DF_DealerProperty_DealerPropertyId]  DEFAULT (newsequentialid()) FOR [DealerPropertyId]
GO
ALTER TABLE [dbo].[Document] ADD  CONSTRAINT [DF_Document_DocumentId]  DEFAULT (newsequentialid()) FOR [DocumentId]
GO
ALTER TABLE [dbo].[Document] ADD  CONSTRAINT [DF_Document_Name]  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[Document] ADD  CONSTRAINT [DF_Document_Description]  DEFAULT ('') FOR [Description]
GO
ALTER TABLE [dbo].[Document] ADD  CONSTRAINT [DF_Document_Created]  DEFAULT (getdate()) FOR [Created]
GO
ALTER TABLE [dbo].[Document] ADD  CONSTRAINT [DF_Document_FilePath]  DEFAULT ('') FOR [FilePath]
GO
ALTER TABLE [dbo].[Document] ADD  CONSTRAINT [DF_Document_FileName]  DEFAULT ('') FOR [FileName]
GO
ALTER TABLE [dbo].[Document] ADD  CONSTRAINT [DF_Document_LanguageCode]  DEFAULT ('') FOR [LanguageCode]
GO
ALTER TABLE [dbo].[EmailMessage] ADD  CONSTRAINT [DF_EmailMessage_EmailMessageId]  DEFAULT (newsequentialid()) FOR [EmailMessageId]
GO
ALTER TABLE [dbo].[EmailMessage] ADD  CONSTRAINT [DF_EmailMessage_Body]  DEFAULT ('') FOR [Body]
GO
ALTER TABLE [dbo].[EmailMessage] ADD  CONSTRAINT [DF_EmailMessage_Subject]  DEFAULT ('') FOR [Subject]
GO
ALTER TABLE [dbo].[EmailMessage] ADD  CONSTRAINT [DF_EmailMessage_SentDate]  DEFAULT (getdate()) FOR [SentDate]
GO
ALTER TABLE [dbo].[EmailMessageAddress] ADD  CONSTRAINT [DF_EmailMessageAddress_EmailMessageAddressId]  DEFAULT (newsequentialid()) FOR [EmailMessageAddressId]
GO
ALTER TABLE [dbo].[EmailMessageAddress] ADD  CONSTRAINT [DF_EmailMessageAddress_EmailAddress]  DEFAULT ('') FOR [EmailAddress]
GO
ALTER TABLE [dbo].[EmailMessageDeliveryAttempt] ADD  CONSTRAINT [DF_EmailMessageDeliveryAttempt_EmailMessageDeliveryAttemptId]  DEFAULT (newsequentialid()) FOR [EmailMessageDeliveryAttemptId]
GO
ALTER TABLE [dbo].[EmailMessageDeliveryAttempt] ADD  CONSTRAINT [DF_EmailMessageDeliveryAttempt_AttemptedDateTime]  DEFAULT (getdate()) FOR [AttemptedDateTime]
GO
ALTER TABLE [dbo].[EmailMessageDeliveryAttempt] ADD  CONSTRAINT [DF_EmailMessageDeliveryAttempt_ErrorMessage]  DEFAULT ('') FOR [ErrorMessage]
GO
ALTER TABLE [dbo].[FilterSection] ADD  CONSTRAINT [DF_FilterSection_FilterSectionId]  DEFAULT (newsequentialid()) FOR [FilterSectionId]
GO
ALTER TABLE [dbo].[FilterSection] ADD  CONSTRAINT [DF_FilterSection_Name]  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[FilterSection] ADD  CONSTRAINT [DF_FilterSection_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[FilterSection] ADD  CONSTRAINT [DF_FilterSection_Label]  DEFAULT ('') FOR [Label]
GO
ALTER TABLE [dbo].[FilterSection] ADD  CONSTRAINT [DF_FilterSection_IsFilter]  DEFAULT ((1)) FOR [IsFilter]
GO
ALTER TABLE [dbo].[FilterSection] ADD  CONSTRAINT [DF_FilterSection_IsComparable]  DEFAULT ((0)) FOR [IsComparable]
GO
ALTER TABLE [dbo].[FilterValue] ADD  CONSTRAINT [DF_FilterValue_FilterValueId]  DEFAULT (newsequentialid()) FOR [FilterValueId]
GO
ALTER TABLE [dbo].[FilterValue] ADD  CONSTRAINT [DF_FilterValue_Value]  DEFAULT ('') FOR [Value]
GO
ALTER TABLE [dbo].[FilterValue] ADD  CONSTRAINT [DF_FilterValue_SortOrder]  DEFAULT ((0)) FOR [SortOrder]
GO
ALTER TABLE [dbo].[FilterValue] ADD  CONSTRAINT [DF_FilterValue_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[GiftCard] ADD  CONSTRAINT [DF_GiftCard_GiftCardId]  DEFAULT (newsequentialid()) FOR [GiftCardId]
GO
ALTER TABLE [dbo].[GiftCard] ADD  CONSTRAINT [DF_GiftCard_GiftCardNumber]  DEFAULT ('') FOR [GiftCardNumber]
GO
ALTER TABLE [dbo].[GiftCard] ADD  CONSTRAINT [DF_GiftCard_LastName]  DEFAULT ('') FOR [LastName]
GO
ALTER TABLE [dbo].[GiftCard] ADD  CONSTRAINT [DF_GiftCard_FirstName]  DEFAULT ('') FOR [FirstName]
GO
ALTER TABLE [dbo].[GiftCard] ADD  CONSTRAINT [DF_GiftCard_Email]  DEFAULT ('') FOR [Email]
GO
ALTER TABLE [dbo].[GiftCard] ADD  CONSTRAINT [DF_GiftCard_Purchased]  DEFAULT (getdate()) FOR [Purchased]
GO
ALTER TABLE [dbo].[GiftCard] ADD  CONSTRAINT [DF_GiftCard_Active]  DEFAULT ((0)) FOR [IsActive]
GO
ALTER TABLE [dbo].[GiftCard] ADD  CONSTRAINT [DF_GiftCard_Amount]  DEFAULT ((0)) FOR [Amount]
GO
ALTER TABLE [dbo].[GiftCard] ADD  CONSTRAINT [DF_GiftCard_ConversionRate]  DEFAULT ((0)) FOR [ConversionRate]
GO
ALTER TABLE [dbo].[GiftCard] ADD  CONSTRAINT [DF_GiftCard_CurrencyAmount]  DEFAULT ((0)) FOR [CurrencyAmount]
GO
ALTER TABLE [dbo].[GiftCardTransaction] ADD  CONSTRAINT [DF_GiftCardTransaction_GiftCardTransactionId]  DEFAULT (newsequentialid()) FOR [GiftCardTransactionId]
GO
ALTER TABLE [dbo].[GiftCardTransaction] ADD  CONSTRAINT [DF_GiftCardTransaction_Amount]  DEFAULT ((0)) FOR [Amount]
GO
ALTER TABLE [dbo].[GiftCardTransaction] ADD  CONSTRAINT [DF_GiftCardTransaction_TransactionDate]  DEFAULT (getdate()) FOR [TransactionDate]
GO
ALTER TABLE [dbo].[GiftCardTransaction] ADD  CONSTRAINT [DF_GiftCardTransaction_CurrencyAmount]  DEFAULT ((0)) FOR [CurrencyAmount]
GO
ALTER TABLE [dbo].[GlobalSynonym] ADD  CONSTRAINT [DF_GlobalSynonym_GlobalSynonymId]  DEFAULT (newsequentialid()) FOR [GlobalSynonymId]
GO
ALTER TABLE [dbo].[GlobalSynonym] ADD  CONSTRAINT [DF_GlobalSynonym_SynonymType]  DEFAULT ('') FOR [SynonymType]
GO
ALTER TABLE [dbo].[GlobalSynonym] ADD  CONSTRAINT [DF_GlobalSynonym_LookupValue]  DEFAULT ('') FOR [LookupValue]
GO
ALTER TABLE [dbo].[GlobalSynonym] ADD  CONSTRAINT [DF_GlobalSynonym_MappedValue]  DEFAULT ('') FOR [MappedValue]
GO
ALTER TABLE [dbo].[GlobalSynonym] ADD  CONSTRAINT [DF_GlobalSynonym_Description]  DEFAULT ('') FOR [Description]
GO
ALTER TABLE [dbo].[GlobalSynonym] ADD  CONSTRAINT [DF_GlobalSynonym_LanguageCode]  DEFAULT ('') FOR [LanguageCode]
GO
ALTER TABLE [dbo].[HtmlRedirect] ADD  CONSTRAINT [DF_HtmlRedirect_HtmlRedirectId]  DEFAULT (newsequentialid()) FOR [HtmlRedirectId]
GO
ALTER TABLE [dbo].[HtmlRedirect] ADD  CONSTRAINT [DF_HtmlRedirect_OldUrl]  DEFAULT ('') FOR [OldUrl]
GO
ALTER TABLE [dbo].[HtmlRedirect] ADD  CONSTRAINT [DF_HtmlRedirect_NewUrl]  DEFAULT ('') FOR [NewUrl]
GO
ALTER TABLE [dbo].[IndexState] ADD  CONSTRAINT [DF_IndexState_IndexStateId]  DEFAULT (newsequentialid()) FOR [IndexStateId]
GO
ALTER TABLE [dbo].[IndexState] ADD  CONSTRAINT [DF_IndexState_ServerName]  DEFAULT ('') FOR [ServerName]
GO
ALTER TABLE [dbo].[IndexState] ADD  CONSTRAINT [DF_IndexState_ServerIndexPath]  DEFAULT ('') FOR [ServerIndexPath]
GO
ALTER TABLE [dbo].[IndexState] ADD  CONSTRAINT [DF_IndexState_StartDateTime]  DEFAULT (getdate()) FOR [StartDateTime]
GO
ALTER TABLE [dbo].[IndexState] ADD  CONSTRAINT [DF_IndexState_EndDateTime]  DEFAULT (NULL) FOR [EndDateTime]
GO
ALTER TABLE [dbo].[IndexState] ADD  CONSTRAINT [DF_IndexState_Succeeded]  DEFAULT ((0)) FOR [Succeeded]
GO
ALTER TABLE [dbo].[IntegrationJob] ADD  CONSTRAINT [DF_IntegrationJob_IntegrationJobId]  DEFAULT (newsequentialid()) FOR [IntegrationJobId]
GO
ALTER TABLE [dbo].[IntegrationJob] ADD  CONSTRAINT [DF_IntegrationJob_Duration]  DEFAULT ((0)) FOR [Duration]
GO
ALTER TABLE [dbo].[IntegrationJob] ADD  CONSTRAINT [DF_IntegrationJob_Status]  DEFAULT ('') FOR [Status]
GO
ALTER TABLE [dbo].[IntegrationJob] ADD  CONSTRAINT [DF_IntegrationJob_RecordCount]  DEFAULT ((0)) FOR [RecordCount]
GO
ALTER TABLE [dbo].[IntegrationJob] ADD  CONSTRAINT [DF_IntegrationJob_Notes]  DEFAULT ('') FOR [Notes]
GO
ALTER TABLE [dbo].[IntegrationJob] ADD  CONSTRAINT [DF_IntegrationJob_DataSize]  DEFAULT ((0)) FOR [DataSize]
GO
ALTER TABLE [dbo].[IntegrationJob] ADD  CONSTRAINT [DF_IntegrationJob_IsRealTime]  DEFAULT ((0)) FOR [IsRealTime]
GO
ALTER TABLE [dbo].[IntegrationJob] ADD  CONSTRAINT [DF_IntegrationJob_ResultData]  DEFAULT ('') FOR [ResultData]
GO
ALTER TABLE [dbo].[IntegrationJob] ADD  CONSTRAINT [DF_IntegrationJob_IsPreview]  DEFAULT ((0)) FOR [IsPreview]
GO
ALTER TABLE [dbo].[IntegrationJob] ADD  CONSTRAINT [DF_IntegrationJob_DeltaDataSetProcessed]  DEFAULT ((0)) FOR [DeltaDataSetProcessed]
GO
ALTER TABLE [dbo].[IntegrationJob] ADD  CONSTRAINT [DF_IntegrationJob_PreviewStepSequence]  DEFAULT ((0)) FOR [PreviewStepSequence]
GO
ALTER TABLE [dbo].[IntegrationJob] ADD  CONSTRAINT [DF_IntegrationJob_InitialData]  DEFAULT ('') FOR [InitialData]
GO
ALTER TABLE [dbo].[IntegrationJob] ADD  CONSTRAINT [DF_IntegrationJob_FileProcessed]  DEFAULT ((0)) FOR [FileProcessed]
GO
ALTER TABLE [dbo].[IntegrationJob] ADD  CONSTRAINT [DF_IntegrationJob_RunStandalone]  DEFAULT ((0)) FOR [RunStandalone]
GO
ALTER TABLE [dbo].[IntegrationJob] ADD  CONSTRAINT [DF_IntegrationJob_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[IntegrationJob] ADD  CONSTRAINT [DF_IntegrationJob_CreatedBy]  DEFAULT ('') FOR [CreatedBy]
GO
ALTER TABLE [dbo].[IntegrationJob] ADD  CONSTRAINT [DF_IntegrationJob_ModifiedOn]  DEFAULT (getdate()) FOR [ModifiedOn]
GO
ALTER TABLE [dbo].[IntegrationJobDefinitionStepFieldMap] ADD  CONSTRAINT [DF_IntegrationJobDefinitionStepFieldMap_IntegrationJobDefinitionStepFieldMapId]  DEFAULT (newsequentialid()) FOR [IntegrationJobDefinitionStepFieldMapId]
GO
ALTER TABLE [dbo].[IntegrationJobDefinitionStepFieldMap] ADD  CONSTRAINT [DF_IntegrationJobDefinitionStepFieldMap_FieldType]  DEFAULT ('') FOR [FieldType]
GO
ALTER TABLE [dbo].[IntegrationJobDefinitionStepFieldMap] ADD  CONSTRAINT [DF_IntegrationJobDefinitionStepFieldMap_FromProperty]  DEFAULT ('') FOR [FromProperty]
GO
ALTER TABLE [dbo].[IntegrationJobDefinitionStepFieldMap] ADD  CONSTRAINT [DF_IntegrationJobDefinitionStepFieldMap_ToProperty]  DEFAULT ('') FOR [ToProperty]
GO
ALTER TABLE [dbo].[IntegrationJobDefinitionStepFieldMap] ADD  CONSTRAINT [DF_IntegrationJobDefinitionStepFieldMap_Overwrite]  DEFAULT ((0)) FOR [Overwrite]
GO
ALTER TABLE [dbo].[IntegrationJobDefinitionStepFieldMap] ADD  CONSTRAINT [DF_IntegrationJobDefinitionStepFieldMap_IsErpKey]  DEFAULT ((0)) FOR [IsErpKey]
GO
ALTER TABLE [dbo].[IntegrationJobDefinitionStepParameter] ADD  CONSTRAINT [DF_IntegrationJobDefinitionStepParameter_IntegrationJobDefinitionStepParameterId]  DEFAULT (newsequentialid()) FOR [IntegrationJobDefinitionStepParameterId]
GO
ALTER TABLE [dbo].[IntegrationJobDefinitionStepParameter] ADD  CONSTRAINT [DF_IntegrationJobDefinitionStepParameter_Sequence]  DEFAULT ((0)) FOR [Sequence]
GO
ALTER TABLE [dbo].[IntegrationJobDefinitionStepParameter] ADD  CONSTRAINT [DF_IntegrationJobDefinitionStepParameter_ValueType]  DEFAULT ('') FOR [ValueType]
GO
ALTER TABLE [dbo].[IntegrationJobDefinitionStepParameter] ADD  CONSTRAINT [DF_IntegrationJobDefinitionStepParameter_DefaultValue]  DEFAULT ('') FOR [DefaultValue]
GO
ALTER TABLE [dbo].[IntegrationJobDefinitionStepParameter] ADD  CONSTRAINT [DF_IntegrationJobDefinitionStepParameter_Prompt]  DEFAULT ('') FOR [Prompt]
GO
ALTER TABLE [dbo].[IntegrationJobDefinitionStepParameter] ADD  CONSTRAINT [DF_IntegrationJobDefinitionStepParameter_Name]  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[IntegrationJobLog] ADD  CONSTRAINT [DF_IntegrationJobLog_IntegrationJobLogId]  DEFAULT (newsequentialid()) FOR [IntegrationJobLogId]
GO
ALTER TABLE [dbo].[IntegrationJobLog] ADD  CONSTRAINT [DF_IntegrationJobLog_Sequence]  DEFAULT ((0)) FOR [Sequence]
GO
ALTER TABLE [dbo].[IntegrationJobLog] ADD  CONSTRAINT [DF_IntegrationJobLog_TypeName]  DEFAULT ('') FOR [TypeName]
GO
ALTER TABLE [dbo].[IntegrationJobLog] ADD  CONSTRAINT [DF_IntegrationJobLog_Message]  DEFAULT ('') FOR [Message]
GO
ALTER TABLE [dbo].[IntegrationJobParameter] ADD  CONSTRAINT [DF_IntegrationJobParameter_IntegrationJobParameterId]  DEFAULT (newsequentialid()) FOR [IntegrationJobParameterId]
GO
ALTER TABLE [dbo].[IntegrationJobParameter] ADD  CONSTRAINT [DF_IntegrationJobParameter_Value]  DEFAULT ('') FOR [Value]
GO
ALTER TABLE [dbo].[InventoryTransaction] ADD  CONSTRAINT [DF_InventoryTransaction_InventoryTransactionId]  DEFAULT (newsequentialid()) FOR [InventoryTransactionId]
GO
ALTER TABLE [dbo].[InventoryTransaction] ADD  CONSTRAINT [DF_InventoryTransaction_TransactionDate]  DEFAULT (getdate()) FOR [TransactionDate]
GO
ALTER TABLE [dbo].[InventoryTransaction] ADD  CONSTRAINT [DF_InventoryTransaction_Description]  DEFAULT ('') FOR [Description]
GO
ALTER TABLE [dbo].[InventoryTransaction] ADD  CONSTRAINT [DF_InventoryTransaction_TransactionQty]  DEFAULT ((0)) FOR [Amount]
GO
ALTER TABLE [dbo].[Invoice] ADD  CONSTRAINT [DF_Invoice_InvoiceId]  DEFAULT (newsequentialid()) FOR [InvoiceId]
GO
ALTER TABLE [dbo].[Invoice] ADD  CONSTRAINT [DF_Invoice_InvoiceDate]  DEFAULT (getdate()) FOR [InvoiceDate]
GO
ALTER TABLE [dbo].[Invoice] ADD  CONSTRAINT [DF_Invoice_TermsCode]  DEFAULT ('') FOR [TermsCode]
GO
ALTER TABLE [dbo].[Invoice] ADD  CONSTRAINT [DF_Invoice_ShipCode]  DEFAULT ('') FOR [ShipCode]
GO
ALTER TABLE [dbo].[Invoice] ADD  CONSTRAINT [DF_Invoice_OrderNumber]  DEFAULT ('') FOR [OrderNumber]
GO
ALTER TABLE [dbo].[Invoice] ADD  CONSTRAINT [DF_Invoice_QuantityOfPackages]  DEFAULT ((0)) FOR [QuantityOfPackages]
GO
ALTER TABLE [dbo].[Invoice] ADD  CONSTRAINT [DF_Invoice_ShipDate]  DEFAULT (getdate()) FOR [ShipDate]
GO
ALTER TABLE [dbo].[Invoice] ADD  CONSTRAINT [DF_Invoice_MiscellaneousCharges]  DEFAULT ((0)) FOR [MiscellaneousCharges]
GO
ALTER TABLE [dbo].[Invoice] ADD  CONSTRAINT [DF_Invoice_PrepaidAmount]  DEFAULT ((0)) FOR [PrepaidAmount]
GO
ALTER TABLE [dbo].[Invoice] ADD  CONSTRAINT [DF_Invoice_Freight]  DEFAULT ((0)) FOR [Freight]
GO
ALTER TABLE [dbo].[Invoice] ADD  CONSTRAINT [DF_Invoice_Cost]  DEFAULT ((0)) FOR [Cost]
GO
ALTER TABLE [dbo].[Invoice] ADD  CONSTRAINT [DF_Invoice_Price]  DEFAULT ((0)) FOR [Price]
GO
ALTER TABLE [dbo].[Invoice] ADD  CONSTRAINT [DF_Invoice_BillType]  DEFAULT ('') FOR [BillType]
GO
ALTER TABLE [dbo].[Invoice] ADD  CONSTRAINT [DF_Invoice_ExchangeRate]  DEFAULT ((0)) FOR [ExchangeRate]
GO
ALTER TABLE [dbo].[Invoice] ADD  CONSTRAINT [DF_Invoice_UseExchangeRate]  DEFAULT ((0)) FOR [UseExchangeRate]
GO
ALTER TABLE [dbo].[Invoice] ADD  CONSTRAINT [DF_Invoice_TaxCode1]  DEFAULT ('') FOR [TaxCode1]
GO
ALTER TABLE [dbo].[Invoice] ADD  CONSTRAINT [DF_Invoice_TaxCode2]  DEFAULT ('') FOR [TaxCode2]
GO
ALTER TABLE [dbo].[Invoice] ADD  CONSTRAINT [DF_Invoice_TaxDate]  DEFAULT (getdate()) FOR [TaxDate]
GO
ALTER TABLE [dbo].[Invoice] ADD  CONSTRAINT [DF_Invoice_ECCode]  DEFAULT ('') FOR [ECCode]
GO
ALTER TABLE [dbo].[Invoice] ADD  CONSTRAINT [DF_Invoice_FreightTaxCode1]  DEFAULT ('') FOR [FreightTaxCode1]
GO
ALTER TABLE [dbo].[Invoice] ADD  CONSTRAINT [DF_Invoice_FreightTaxCode2]  DEFAULT ('') FOR [FreightTaxCode2]
GO
ALTER TABLE [dbo].[Invoice] ADD  CONSTRAINT [DF_Invoice_MiscellaneousTaxCode1]  DEFAULT ('') FOR [MiscellaneousTaxCode1]
GO
ALTER TABLE [dbo].[Invoice] ADD  CONSTRAINT [DF_Invoice_MiscellaneousTaxCode2]  DEFAULT ('') FOR [MiscellaneousTaxCode2]
GO
ALTER TABLE [dbo].[Invoice] ADD  CONSTRAINT [DF_Invoice_Discount]  DEFAULT ((0)) FOR [Discount]
GO
ALTER TABLE [dbo].[Invoice] ADD  CONSTRAINT [DF_Invoice_DONumber]  DEFAULT ('') FOR [DONumber]
GO
ALTER TABLE [dbo].[Invoice] ADD  CONSTRAINT [DF_Invoice_Salesman]  DEFAULT ('') FOR [Salesman]
GO
ALTER TABLE [dbo].[Invoice] ADD  CONSTRAINT [DF_Invoice_State]  DEFAULT ('') FOR [State]
GO
ALTER TABLE [dbo].[Invoice] ADD  CONSTRAINT [DF_Invoice_InvoiceNumber]  DEFAULT ('') FOR [InvoiceNumber]
GO
ALTER TABLE [dbo].[Invoice] ADD  CONSTRAINT [DF_Invoice_InvoiceSequence]  DEFAULT ((0)) FOR [InvoiceSequence]
GO
ALTER TABLE [dbo].[Invoice] ADD  CONSTRAINT [DF_Invoice_CustomerPO]  DEFAULT ('') FOR [CustomerPO]
GO
ALTER TABLE [dbo].[Invoice] ADD  CONSTRAINT [DF_Invoice_Total]  DEFAULT ((0)) FOR [Total]
GO
ALTER TABLE [dbo].[Invoice] ADD  CONSTRAINT [DF_Invoice_OriginalTotal]  DEFAULT ((0)) FOR [OriginalTotal]
GO
ALTER TABLE [dbo].[InvoiceHistory] ADD  CONSTRAINT [DF_InvoiceHistory_InvoiceHistoryId]  DEFAULT (newsequentialid()) FOR [InvoiceHistoryId]
GO
ALTER TABLE [dbo].[InvoiceHistory] ADD  CONSTRAINT [DF_InvoiceHistory_InvoiceNumber]  DEFAULT ('') FOR [InvoiceNumber]
GO
ALTER TABLE [dbo].[InvoiceHistory] ADD  CONSTRAINT [DF_InvoiceHistory_InvoiceDate]  DEFAULT (getdate()) FOR [InvoiceDate]
GO
ALTER TABLE [dbo].[InvoiceHistory] ADD  CONSTRAINT [DF_InvoiceHistory_DueDate]  DEFAULT (getdate()) FOR [DueDate]
GO
ALTER TABLE [dbo].[InvoiceHistory] ADD  CONSTRAINT [DF_InvoiceHistory_InvoiceType]  DEFAULT ('') FOR [InvoiceType]
GO
ALTER TABLE [dbo].[InvoiceHistory] ADD  CONSTRAINT [DF_InvoiceHistory_CustomerNumber]  DEFAULT ('') FOR [CustomerNumber]
GO
ALTER TABLE [dbo].[InvoiceHistory] ADD  CONSTRAINT [DF_InvoiceHistory_CustomerSequence]  DEFAULT ('') FOR [CustomerSequence]
GO
ALTER TABLE [dbo].[InvoiceHistory] ADD  CONSTRAINT [DF_InvoiceHistory_CustomerPO]  DEFAULT ('') FOR [CustomerPO]
GO
ALTER TABLE [dbo].[InvoiceHistory] ADD  CONSTRAINT [DF_InvoiceHistory_Status]  DEFAULT ('') FOR [Status]
GO
ALTER TABLE [dbo].[InvoiceHistory] ADD  CONSTRAINT [DF_InvoiceHistory_IsOpen]  DEFAULT ((0)) FOR [IsOpen]
GO
ALTER TABLE [dbo].[InvoiceHistory] ADD  CONSTRAINT [DF_InvoiceHistory_CurrencyCode]  DEFAULT ('') FOR [CurrencyCode]
GO
ALTER TABLE [dbo].[InvoiceHistory] ADD  CONSTRAINT [DF_InvoiceHistory_Terms]  DEFAULT ('') FOR [Terms]
GO
ALTER TABLE [dbo].[InvoiceHistory] ADD  CONSTRAINT [DF_InvoiceHistory_ShipCode]  DEFAULT ('') FOR [ShipCode]
GO
ALTER TABLE [dbo].[InvoiceHistory] ADD  CONSTRAINT [DF_InvoiceHistory_Salesperson]  DEFAULT ('') FOR [Salesperson]
GO
ALTER TABLE [dbo].[InvoiceHistory] ADD  CONSTRAINT [DF_InvoiceHistory_BTCompanyName]  DEFAULT ('') FOR [BTCompanyName]
GO
ALTER TABLE [dbo].[InvoiceHistory] ADD  CONSTRAINT [DF_InvoiceHistory_BTAddress1]  DEFAULT ('') FOR [BTAddress1]
GO
ALTER TABLE [dbo].[InvoiceHistory] ADD  CONSTRAINT [DF_InvoiceHistory_BTAddress2]  DEFAULT ('') FOR [BTAddress2]
GO
ALTER TABLE [dbo].[InvoiceHistory] ADD  CONSTRAINT [DF_InvoiceHistory_BTCity]  DEFAULT ('') FOR [BTCity]
GO
ALTER TABLE [dbo].[InvoiceHistory] ADD  CONSTRAINT [DF_InvoiceHistory_BTState]  DEFAULT ('') FOR [BTState]
GO
ALTER TABLE [dbo].[InvoiceHistory] ADD  CONSTRAINT [DF_InvoiceHistory_BTPostalCode]  DEFAULT ('') FOR [BTPostalCode]
GO
ALTER TABLE [dbo].[InvoiceHistory] ADD  CONSTRAINT [DF_InvoiceHistory_BTCountry]  DEFAULT ('') FOR [BTCountry]
GO
ALTER TABLE [dbo].[InvoiceHistory] ADD  CONSTRAINT [DF_InvoiceHistory_STCompanyName]  DEFAULT ('') FOR [STCompanyName]
GO
ALTER TABLE [dbo].[InvoiceHistory] ADD  CONSTRAINT [DF_InvoiceHistory_STAddress1]  DEFAULT ('') FOR [STAddress1]
GO
ALTER TABLE [dbo].[InvoiceHistory] ADD  CONSTRAINT [DF_InvoiceHistory_STAddress2]  DEFAULT ('') FOR [STAddress2]
GO
ALTER TABLE [dbo].[InvoiceHistory] ADD  CONSTRAINT [DF_InvoiceHistory_STCity]  DEFAULT ('') FOR [STCity]
GO
ALTER TABLE [dbo].[InvoiceHistory] ADD  CONSTRAINT [DF_InvoiceHistory_STState]  DEFAULT ('') FOR [STState]
GO
ALTER TABLE [dbo].[InvoiceHistory] ADD  CONSTRAINT [DF_InvoiceHistory_STPostalCode]  DEFAULT ('') FOR [STPostalCode]
GO
ALTER TABLE [dbo].[InvoiceHistory] ADD  CONSTRAINT [DF_InvoiceHistory_STCountry]  DEFAULT ('') FOR [STCountry]
GO
ALTER TABLE [dbo].[InvoiceHistory] ADD  CONSTRAINT [DF_InvoiceHistory_Notes]  DEFAULT ('') FOR [Notes]
GO
ALTER TABLE [dbo].[InvoiceHistory] ADD  CONSTRAINT [DF_InvoiceHistory_ProductTotal]  DEFAULT ((0)) FOR [ProductTotal]
GO
ALTER TABLE [dbo].[InvoiceHistory] ADD  CONSTRAINT [DF_InvoiceHistory_DiscountAmount]  DEFAULT ((0)) FOR [DiscountAmount]
GO
ALTER TABLE [dbo].[InvoiceHistory] ADD  CONSTRAINT [DF_InvoiceHistory_ShippingAndHandling]  DEFAULT ((0)) FOR [ShippingAndHandling]
GO
ALTER TABLE [dbo].[InvoiceHistory] ADD  CONSTRAINT [DF_InvoiceHistory_OtherCharges]  DEFAULT ((0)) FOR [OtherCharges]
GO
ALTER TABLE [dbo].[InvoiceHistory] ADD  CONSTRAINT [DF_InvoiceHistory_TaxAmount]  DEFAULT ((0)) FOR [TaxAmount]
GO
ALTER TABLE [dbo].[InvoiceHistory] ADD  CONSTRAINT [DF_InvoiceHistory_InvoiceTotal]  DEFAULT ((0)) FOR [InvoiceTotal]
GO
ALTER TABLE [dbo].[InvoiceHistory] ADD  CONSTRAINT [DF_InvoiceHistory_CurrentBalance]  DEFAULT ((0)) FOR [CurrentBalance]
GO
ALTER TABLE [dbo].[InvoiceHistoryLine] ADD  CONSTRAINT [DF_InvoiceHistoryLine_InvoiceHistoryLineId]  DEFAULT (newsequentialid()) FOR [InvoiceHistoryLineId]
GO
ALTER TABLE [dbo].[InvoiceHistoryLine] ADD  CONSTRAINT [DF_InvoiceHistoryLine_LineType]  DEFAULT ('') FOR [LineType]
GO
ALTER TABLE [dbo].[InvoiceHistoryLine] ADD  CONSTRAINT [DF_InvoiceHistoryLine_ERPOrderNumber]  DEFAULT ('') FOR [ERPOrderNumber]
GO
ALTER TABLE [dbo].[InvoiceHistoryLine] ADD  CONSTRAINT [DF_InvoiceHistoryLine_LineNumber]  DEFAULT ((0)) FOR [LineNumber]
GO
ALTER TABLE [dbo].[InvoiceHistoryLine] ADD  CONSTRAINT [DF_InvoiceHistoryLine_ReleaseNumber]  DEFAULT ((0)) FOR [ReleaseNumber]
GO
ALTER TABLE [dbo].[InvoiceHistoryLine] ADD  CONSTRAINT [DF_InvoiceHistoryLine_ProductERPNumber]  DEFAULT ('') FOR [ProductERPNumber]
GO
ALTER TABLE [dbo].[InvoiceHistoryLine] ADD  CONSTRAINT [DF_InvoiceHistoryLine_CustomerProductNumber]  DEFAULT ('') FOR [CustomerProductNumber]
GO
ALTER TABLE [dbo].[InvoiceHistoryLine] ADD  CONSTRAINT [DF_InvoiceHistoryLine_LinePOReference]  DEFAULT ('') FOR [LinePOReference]
GO
ALTER TABLE [dbo].[InvoiceHistoryLine] ADD  CONSTRAINT [DF_InvoiceHistoryLine_Description]  DEFAULT ('') FOR [Description]
GO
ALTER TABLE [dbo].[InvoiceHistoryLine] ADD  CONSTRAINT [DF_InvoiceHistoryLine_Warehouse]  DEFAULT ('') FOR [Warehouse]
GO
ALTER TABLE [dbo].[InvoiceHistoryLine] ADD  CONSTRAINT [DF_InvoiceHistoryLine_Notes]  DEFAULT ('') FOR [Notes]
GO
ALTER TABLE [dbo].[InvoiceHistoryLine] ADD  CONSTRAINT [DF_InvoiceHistoryLine_QtyInvoiced]  DEFAULT ((0)) FOR [QtyInvoiced]
GO
ALTER TABLE [dbo].[InvoiceHistoryLine] ADD  CONSTRAINT [DF_InvoiceHistoryLine_UnitOfMeasure]  DEFAULT ('') FOR [UnitOfMeasure]
GO
ALTER TABLE [dbo].[InvoiceHistoryLine] ADD  CONSTRAINT [DF_InvoiceHistoryLine_UnitPrice]  DEFAULT ((0)) FOR [UnitPrice]
GO
ALTER TABLE [dbo].[InvoiceHistoryLine] ADD  CONSTRAINT [DF_InvoiceHistoryLine_DiscountPercent]  DEFAULT ((0)) FOR [DiscountPercent]
GO
ALTER TABLE [dbo].[InvoiceHistoryLine] ADD  CONSTRAINT [DF_InvoiceHistoryLine_DiscountAmount]  DEFAULT ((0)) FOR [DiscountAmount]
GO
ALTER TABLE [dbo].[InvoiceHistoryLine] ADD  CONSTRAINT [DF_InvoiceHistoryLine_LineTotal]  DEFAULT ((0)) FOR [LineTotal]
GO
ALTER TABLE [dbo].[InvoiceHistoryLine] ADD  CONSTRAINT [DF_InvoiceHistoryLine_ShipmentNumber]  DEFAULT ('') FOR [ShipmentNumber]
GO
ALTER TABLE [dbo].[InvoiceLine] ADD  CONSTRAINT [DF_InvoiceLine_InvoiceLineId]  DEFAULT (newsequentialid()) FOR [InvoiceLineId]
GO
ALTER TABLE [dbo].[InvoiceLine] ADD  CONSTRAINT [DF_InvoiceLine_InvoiceNumber]  DEFAULT ('') FOR [InvoiceNumber]
GO
ALTER TABLE [dbo].[InvoiceLine] ADD  CONSTRAINT [DF_InvoiceLine_InvoiceSequence]  DEFAULT ((0)) FOR [InvoiceSequence]
GO
ALTER TABLE [dbo].[InvoiceLine] ADD  CONSTRAINT [DF_InvoiceLine_InvoiceLine]  DEFAULT ((0)) FOR [InvoiceLineNumber]
GO
ALTER TABLE [dbo].[InvoiceLine] ADD  CONSTRAINT [DF_InvoiceLine_OrderNumber]  DEFAULT ('') FOR [OrderNumber]
GO
ALTER TABLE [dbo].[InvoiceLine] ADD  CONSTRAINT [DF_InvoiceLine_OrderLine]  DEFAULT ((0)) FOR [OrderLine]
GO
ALTER TABLE [dbo].[InvoiceLine] ADD  CONSTRAINT [DF_InvoiceLine_OrderRelease]  DEFAULT ((0)) FOR [OrderRelease]
GO
ALTER TABLE [dbo].[InvoiceLine] ADD  CONSTRAINT [DF_InvoiceLine_Item]  DEFAULT ('') FOR [ProductName]
GO
ALTER TABLE [dbo].[InvoiceLine] ADD  CONSTRAINT [DF_InvoiceLine_QuantityInvoiced]  DEFAULT ((0)) FOR [QuantityInvoiced]
GO
ALTER TABLE [dbo].[InvoiceLine] ADD  CONSTRAINT [DF_InvoiceLine_Discount]  DEFAULT ((0)) FOR [Discount]
GO
ALTER TABLE [dbo].[InvoiceLine] ADD  CONSTRAINT [DF_InvoiceLine_Cost]  DEFAULT ((0)) FOR [Cost]
GO
ALTER TABLE [dbo].[InvoiceLine] ADD  CONSTRAINT [DF_InvoiceLine_Price]  DEFAULT ((0)) FOR [Price]
GO
ALTER TABLE [dbo].[InvoiceLine] ADD  CONSTRAINT [DF_InvoiceLine_OldPrice]  DEFAULT ((0)) FOR [OldPrice]
GO
ALTER TABLE [dbo].[InvoiceLine] ADD  CONSTRAINT [DF_InvoiceLine_NewPrice]  DEFAULT ((0)) FOR [NewPrice]
GO
ALTER TABLE [dbo].[InvoiceLine] ADD  CONSTRAINT [DF_InvoiceLine_ProcessInd]  DEFAULT ('') FOR [ProcessIdentifier]
GO
ALTER TABLE [dbo].[InvoiceLine] ADD  CONSTRAINT [DF_InvoiceLine_ConsignmentType]  DEFAULT ((0)) FOR [ConsignmentType]
GO
ALTER TABLE [dbo].[InvoiceLine] ADD  CONSTRAINT [DF_InvoiceLine_TaxCode1]  DEFAULT ('') FOR [TaxCode1]
GO
ALTER TABLE [dbo].[InvoiceLine] ADD  CONSTRAINT [DF_InvoiceLine_TaxCode2]  DEFAULT ('') FOR [TaxCode2]
GO
ALTER TABLE [dbo].[InvoiceLine] ADD  CONSTRAINT [DF_InvoiceLine_TaxDate]  DEFAULT (getdate()) FOR [TaxDate]
GO
ALTER TABLE [dbo].[InvoiceLine] ADD  CONSTRAINT [DF_InvoiceLine_CustomerPO]  DEFAULT ('') FOR [CustomerPO]
GO
ALTER TABLE [dbo].[InvoiceLine] ADD  CONSTRAINT [DF_InvoiceLine_RestockFee]  DEFAULT ((0)) FOR [RestockFee]
GO
ALTER TABLE [dbo].[InvoiceLine] ADD  CONSTRAINT [DF_InvoiceLine_DONumber]  DEFAULT ('') FOR [DONumber]
GO
ALTER TABLE [dbo].[InvoiceLine] ADD  CONSTRAINT [DF_InvoiceLine_DOLine]  DEFAULT ((0)) FOR [DOLine]
GO
ALTER TABLE [dbo].[InvoiceLine] ADD  CONSTRAINT [DF_InvoiceLine_DOSequence]  DEFAULT ((0)) FOR [DOSequence]
GO
ALTER TABLE [dbo].[InvoiceLine] ADD  CONSTRAINT [DF_InvoiceLine_OriginalInvoiceNumber]  DEFAULT ('') FOR [OriginalInvoiceNumber]
GO
ALTER TABLE [dbo].[InvoiceLine] ADD  CONSTRAINT [DF_InvoiceLine_ReasonText]  DEFAULT ('') FOR [ReasonText]
GO
ALTER TABLE [dbo].[InvoiceLine] ADD  CONSTRAINT [DF_InvoiceLine_ProductDescription]  DEFAULT ('') FOR [ProductDescription]
GO
ALTER TABLE [dbo].[InvoiceLine] ADD  CONSTRAINT [DF_InvoiceLine_ProductCode]  DEFAULT ('') FOR [ProductCode]
GO
ALTER TABLE [dbo].[InvoiceLine] ADD  CONSTRAINT [DF_InvoiceLine_QuantityOrdered]  DEFAULT ((0)) FOR [QuantityOrdered]
GO
ALTER TABLE [dbo].[ItemCustPrice_Batch] ADD  CONSTRAINT [DF_ItemCustPrice_Batch_brk_qty1]  DEFAULT ((0)) FOR [brk_qty1]
GO
ALTER TABLE [dbo].[ItemCustPrice_Batch] ADD  CONSTRAINT [DF_ItemCustPrice_Batch_brk_qty2]  DEFAULT ((0)) FOR [brk_qty2]
GO
ALTER TABLE [dbo].[ItemCustPrice_Batch] ADD  CONSTRAINT [DF_ItemCustPrice_Batch_brk_qty3]  DEFAULT ((0)) FOR [brk_qty3]
GO
ALTER TABLE [dbo].[ItemCustPrice_Batch] ADD  CONSTRAINT [DF_ItemCustPrice_Batch_brk_qty4]  DEFAULT ((0)) FOR [brk_qty4]
GO
ALTER TABLE [dbo].[ItemCustPrice_Batch] ADD  CONSTRAINT [DF_ItemCustPrice_Batch_brk_qty5]  DEFAULT ((0)) FOR [brk_qty5]
GO
ALTER TABLE [dbo].[ItemCustPrice_Batch] ADD  CONSTRAINT [DF_ItemCustPrice_Batch_brk_price1]  DEFAULT ((0)) FOR [brk_price1]
GO
ALTER TABLE [dbo].[ItemCustPrice_Batch] ADD  CONSTRAINT [DF_ItemCustPrice_Batch_brk_price2]  DEFAULT ((0)) FOR [brk_price2]
GO
ALTER TABLE [dbo].[ItemCustPrice_Batch] ADD  CONSTRAINT [DF_ItemCustPrice_Batch_brk_price3]  DEFAULT ((0)) FOR [brk_price3]
GO
ALTER TABLE [dbo].[ItemCustPrice_Batch] ADD  CONSTRAINT [DF_ItemCustPrice_Batch_brk_price4]  DEFAULT ((0)) FOR [brk_price4]
GO
ALTER TABLE [dbo].[ItemCustPrice_Batch] ADD  CONSTRAINT [DF_ItemCustPrice_Batch_brk_price5]  DEFAULT ((0)) FOR [brk_price5]
GO
ALTER TABLE [dbo].[ItemCustPrice_Batch] ADD  CONSTRAINT [DF_ItemCustPrice_Batch_dol_percent1]  DEFAULT ('P') FOR [dol_percent1]
GO
ALTER TABLE [dbo].[ItemCustPrice_Batch] ADD  CONSTRAINT [DF_ItemCustPrice_Batch_dol_percent2]  DEFAULT ('P') FOR [dol_percent2]
GO
ALTER TABLE [dbo].[ItemCustPrice_Batch] ADD  CONSTRAINT [DF_ItemCustPrice_Batch_dol_percent3]  DEFAULT ('P') FOR [dol_percent3]
GO
ALTER TABLE [dbo].[ItemCustPrice_Batch] ADD  CONSTRAINT [DF_ItemCustPrice_Batch_dol_percent4]  DEFAULT ('P') FOR [dol_percent4]
GO
ALTER TABLE [dbo].[ItemCustPrice_Batch] ADD  CONSTRAINT [DF_ItemCustPrice_Batch_dol_percent5]  DEFAULT ('P') FOR [dol_percent5]
GO
ALTER TABLE [dbo].[ItemCustPrice_Batch] ADD  CONSTRAINT [DF_ItemCustPrice_Batch_cust_item_seq]  DEFAULT ((0)) FOR [cust_item_seq]
GO
ALTER TABLE [dbo].[ItemPrice_Batch] ADD  CONSTRAINT [DF_ItemPrice_Batch_unit_price1]  DEFAULT ((0)) FOR [unit_price1]
GO
ALTER TABLE [dbo].[ItemPrice_Batch] ADD  CONSTRAINT [DF_ItemPrice_Batch_unit_price2]  DEFAULT ((0)) FOR [unit_price2]
GO
ALTER TABLE [dbo].[ItemPrice_Batch] ADD  CONSTRAINT [DF_ItemPrice_Batch_unit_price3]  DEFAULT ((0)) FOR [unit_price3]
GO
ALTER TABLE [dbo].[ItemPrice_Batch] ADD  CONSTRAINT [DF_ItemPrice_Batch_unit_price4]  DEFAULT ((0)) FOR [unit_price4]
GO
ALTER TABLE [dbo].[ItemPrice_Batch] ADD  CONSTRAINT [DF_ItemPrice_Batch_unit_price5]  DEFAULT ((0)) FOR [unit_price5]
GO
ALTER TABLE [dbo].[ItemPrice_Batch] ADD  CONSTRAINT [DF_ItemPrice_Batch_unit_price6]  DEFAULT ((0)) FOR [unit_price6]
GO
ALTER TABLE [dbo].[ItemPrice_Batch] ADD  CONSTRAINT [DF_ItemPrice_Batch_reprice]  DEFAULT ((1)) FOR [reprice]
GO
ALTER TABLE [dbo].[ItemPrice_Batch] ADD  CONSTRAINT [DF_ItemPrice_Batch_brk_qty1]  DEFAULT ((0)) FOR [brk_qty1]
GO
ALTER TABLE [dbo].[ItemPrice_Batch] ADD  CONSTRAINT [DF_ItemPrice_Batch_brk_qty2]  DEFAULT ((0)) FOR [brk_qty2]
GO
ALTER TABLE [dbo].[ItemPrice_Batch] ADD  CONSTRAINT [DF_ItemPrice_Batch_brk_qty3]  DEFAULT ((0)) FOR [brk_qty3]
GO
ALTER TABLE [dbo].[ItemPrice_Batch] ADD  CONSTRAINT [DF_ItemPrice_Batch_brk_qty4]  DEFAULT ((0)) FOR [brk_qty4]
GO
ALTER TABLE [dbo].[ItemPrice_Batch] ADD  CONSTRAINT [DF_ItemPrice_Batch_brk_qty5]  DEFAULT ((0)) FOR [brk_qty5]
GO
ALTER TABLE [dbo].[ItemPrice_Batch] ADD  CONSTRAINT [DF_ItemPrice_Batch_brk_price1]  DEFAULT ((0)) FOR [brk_price1]
GO
ALTER TABLE [dbo].[ItemPrice_Batch] ADD  CONSTRAINT [DF_ItemPrice_Batch_brk_price2]  DEFAULT ((0)) FOR [brk_price2]
GO
ALTER TABLE [dbo].[ItemPrice_Batch] ADD  CONSTRAINT [DF_ItemPrice_Batch_brk_price3]  DEFAULT ((0)) FOR [brk_price3]
GO
ALTER TABLE [dbo].[ItemPrice_Batch] ADD  CONSTRAINT [DF_ItemPrice_Batch_brk_price4]  DEFAULT ((0)) FOR [brk_price4]
GO
ALTER TABLE [dbo].[ItemPrice_Batch] ADD  CONSTRAINT [DF_ItemPrice_Batch_brk_price5]  DEFAULT ((0)) FOR [brk_price5]
GO
ALTER TABLE [dbo].[ItemPrice_Batch] ADD  CONSTRAINT [DF_ItemPrice_Batch_base_code1]  DEFAULT ('P1') FOR [base_code1]
GO
ALTER TABLE [dbo].[ItemPrice_Batch] ADD  CONSTRAINT [DF_ItemPrice_Batch_base_code2]  DEFAULT ('P1') FOR [base_code2]
GO
ALTER TABLE [dbo].[ItemPrice_Batch] ADD  CONSTRAINT [DF_ItemPrice_Batch_base_code3]  DEFAULT ('P1') FOR [base_code3]
GO
ALTER TABLE [dbo].[ItemPrice_Batch] ADD  CONSTRAINT [DF_ItemPrice_Batch_base_code4]  DEFAULT ('P1') FOR [base_code4]
GO
ALTER TABLE [dbo].[ItemPrice_Batch] ADD  CONSTRAINT [DF_ItemPrice_Batch_base_code5]  DEFAULT ('P1') FOR [base_code5]
GO
ALTER TABLE [dbo].[ItemPrice_Batch] ADD  CONSTRAINT [DF_ItemPrice_Batch_dol_percent1]  DEFAULT ('P') FOR [dol_percent1]
GO
ALTER TABLE [dbo].[ItemPrice_Batch] ADD  CONSTRAINT [DF_ItemPrice_Batch_dol_percent2]  DEFAULT ('P') FOR [dol_percent2]
GO
ALTER TABLE [dbo].[ItemPrice_Batch] ADD  CONSTRAINT [DF_ItemPrice_Batch_dol_percent3]  DEFAULT ('P') FOR [dol_percent3]
GO
ALTER TABLE [dbo].[ItemPrice_Batch] ADD  CONSTRAINT [DF_ItemPrice_Batch_dol_percent4]  DEFAULT ('P') FOR [dol_percent4]
GO
ALTER TABLE [dbo].[ItemPrice_Batch] ADD  CONSTRAINT [DF_ItemPrice_Batch_dol_percent5]  DEFAULT ('P') FOR [dol_percent5]
GO
ALTER TABLE [dbo].[LocalTaxRate] ADD  CONSTRAINT [DF_LocalTaxRate_LocalTaxRateId]  DEFAULT (newsequentialid()) FOR [LocalTaxRateId]
GO
ALTER TABLE [dbo].[LocalTaxRate] ADD  CONSTRAINT [DF_LocalTaxRate_PostalCode]  DEFAULT ('') FOR [Zip]
GO
ALTER TABLE [dbo].[LocalTaxRate] ADD  CONSTRAINT [DF_LocalTaxRate_TaxRate]  DEFAULT ((0)) FOR [TaxRate]
GO
ALTER TABLE [dbo].[LocalTaxRate] ADD  CONSTRAINT [DF_LocalTaxRate_TaxCode]  DEFAULT ('') FOR [TaxCode]
GO
ALTER TABLE [dbo].[LocalTaxRate] ADD  CONSTRAINT [DF_LocalTaxRate_TaxFreight]  DEFAULT ((0)) FOR [TaxFreight]
GO
ALTER TABLE [dbo].[Message] ADD  CONSTRAINT [DF_Message_MessageId]  DEFAULT (newsequentialid()) FOR [MessageId]
GO
ALTER TABLE [dbo].[Message] ADD  CONSTRAINT [DF_Message_Subject]  DEFAULT ('') FOR [Subject]
GO
ALTER TABLE [dbo].[Message] ADD  CONSTRAINT [DF_Message_Body]  DEFAULT ('') FOR [Body]
GO
ALTER TABLE [dbo].[Message] ADD  CONSTRAINT [DF_Message_DateToDisplay]  DEFAULT (getdate()) FOR [DateToDisplay]
GO
ALTER TABLE [dbo].[Message] ADD  CONSTRAINT [DF_Message_LanguageCode]  DEFAULT ('') FOR [LanguageCode]
GO
ALTER TABLE [dbo].[MessageAudit] ADD  CONSTRAINT [DF_MessageAudit_MessageAuditId]  DEFAULT (newsequentialid()) FOR [MessageAuditId]
GO
ALTER TABLE [dbo].[MessageAudit] ADD  CONSTRAINT [DF_MessageAudit_Process]  DEFAULT ('') FOR [Process]
GO
ALTER TABLE [dbo].[MessageAudit] ADD  CONSTRAINT [DF_MessageAudit_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[MessageStatus] ADD  CONSTRAINT [DF_MessageStatus_MessageStatusId]  DEFAULT (newsequentialid()) FOR [MessageStatusId]
GO
ALTER TABLE [dbo].[MessageStatus] ADD  CONSTRAINT [DF_MessageStatus_HasRead]  DEFAULT ((0)) FOR [HasRead]
GO
ALTER TABLE [dbo].[MessageTarget] ADD  CONSTRAINT [DF_MessageTarget_MessageTargetId]  DEFAULT (newsequentialid()) FOR [MessageTargetId]
GO
ALTER TABLE [dbo].[MessageTarget] ADD  CONSTRAINT [DF_MessageTarget_TargetType]  DEFAULT ('') FOR [TargetType]
GO
ALTER TABLE [dbo].[MessageTarget] ADD  CONSTRAINT [DF_MessageTarget_TargetKey]  DEFAULT ('') FOR [TargetKey]
GO
ALTER TABLE [dbo].[OrderHistory] ADD  CONSTRAINT [DF_OrderHistory_OrderHistoryId]  DEFAULT (newsequentialid()) FOR [OrderHistoryId]
GO
ALTER TABLE [dbo].[OrderHistory] ADD  CONSTRAINT [DF_OrderHistory_ERPOrderNumber]  DEFAULT ('') FOR [ERPOrderNumber]
GO
ALTER TABLE [dbo].[OrderHistory] ADD  CONSTRAINT [DF_OrderHistory_WebOrderNumber]  DEFAULT ('') FOR [WebOrderNumber]
GO
ALTER TABLE [dbo].[OrderHistory] ADD  CONSTRAINT [DF_OrderHistory_OrderDate]  DEFAULT (getdate()) FOR [OrderDate]
GO
ALTER TABLE [dbo].[OrderHistory] ADD  CONSTRAINT [DF_OrderHistory_Status]  DEFAULT ('') FOR [Status]
GO
ALTER TABLE [dbo].[OrderHistory] ADD  CONSTRAINT [DF_OrderHistory_CustomerNumber]  DEFAULT ('') FOR [CustomerNumber]
GO
ALTER TABLE [dbo].[OrderHistory] ADD  CONSTRAINT [DF_OrderHistory_CustomerSequence]  DEFAULT ('') FOR [CustomerSequence]
GO
ALTER TABLE [dbo].[OrderHistory] ADD  CONSTRAINT [DF_OrderHistory_CustomerPO]  DEFAULT ('') FOR [CustomerPO]
GO
ALTER TABLE [dbo].[OrderHistory] ADD  CONSTRAINT [DF_OrderHistory_CurrencyCode]  DEFAULT ('') FOR [CurrencyCode]
GO
ALTER TABLE [dbo].[OrderHistory] ADD  CONSTRAINT [DF_OrderHistory_Terms]  DEFAULT ('') FOR [Terms]
GO
ALTER TABLE [dbo].[OrderHistory] ADD  CONSTRAINT [DF_OrderHistory_ShipCode]  DEFAULT ('') FOR [ShipCode]
GO
ALTER TABLE [dbo].[OrderHistory] ADD  CONSTRAINT [DF_OrderHistory_Salesperson]  DEFAULT ('') FOR [Salesperson]
GO
ALTER TABLE [dbo].[OrderHistory] ADD  CONSTRAINT [DF_OrderHistory_BTCompanyName]  DEFAULT ('') FOR [BTCompanyName]
GO
ALTER TABLE [dbo].[OrderHistory] ADD  CONSTRAINT [DF_OrderHistory_BTAddress1]  DEFAULT ('') FOR [BTAddress1]
GO
ALTER TABLE [dbo].[OrderHistory] ADD  CONSTRAINT [DF_OrderHistory_BTAddress2]  DEFAULT ('') FOR [BTAddress2]
GO
ALTER TABLE [dbo].[OrderHistory] ADD  CONSTRAINT [DF_OrderHistory_BTCity]  DEFAULT ('') FOR [BTCity]
GO
ALTER TABLE [dbo].[OrderHistory] ADD  CONSTRAINT [DF_OrderHistory_BTState]  DEFAULT ('') FOR [BTState]
GO
ALTER TABLE [dbo].[OrderHistory] ADD  CONSTRAINT [DF_OrderHistory_BTPostalCode]  DEFAULT ('') FOR [BTPostalCode]
GO
ALTER TABLE [dbo].[OrderHistory] ADD  CONSTRAINT [DF_OrderHistory_BTCountry]  DEFAULT ('') FOR [BTCountry]
GO
ALTER TABLE [dbo].[OrderHistory] ADD  CONSTRAINT [DF_OrderHistory_STCompanyName]  DEFAULT ('') FOR [STCompanyName]
GO
ALTER TABLE [dbo].[OrderHistory] ADD  CONSTRAINT [DF_OrderHistory_STAddress1]  DEFAULT ('') FOR [STAddress1]
GO
ALTER TABLE [dbo].[OrderHistory] ADD  CONSTRAINT [DF_OrderHistory_STAddress2]  DEFAULT ('') FOR [STAddress2]
GO
ALTER TABLE [dbo].[OrderHistory] ADD  CONSTRAINT [DF_OrderHistory_STCity]  DEFAULT ('') FOR [STCity]
GO
ALTER TABLE [dbo].[OrderHistory] ADD  CONSTRAINT [DF_OrderHistory_STState]  DEFAULT ('') FOR [STState]
GO
ALTER TABLE [dbo].[OrderHistory] ADD  CONSTRAINT [DF_OrderHistory_STPostalCode]  DEFAULT ('') FOR [STPostalCode]
GO
ALTER TABLE [dbo].[OrderHistory] ADD  CONSTRAINT [DF_OrderHistory_STCountry]  DEFAULT ('') FOR [STCountry]
GO
ALTER TABLE [dbo].[OrderHistory] ADD  CONSTRAINT [DF_OrderHistory_Notes]  DEFAULT ('') FOR [Notes]
GO
ALTER TABLE [dbo].[OrderHistory] ADD  CONSTRAINT [DF_OrderHistory_ProductTotal]  DEFAULT ((0)) FOR [ProductTotal]
GO
ALTER TABLE [dbo].[OrderHistory] ADD  CONSTRAINT [DF_OrderHistory_DiscountAmount]  DEFAULT ((0)) FOR [DiscountAmount]
GO
ALTER TABLE [dbo].[OrderHistory] ADD  CONSTRAINT [DF_OrderHistory_ShippingAndHandling]  DEFAULT ((0)) FOR [ShippingAndHandling]
GO
ALTER TABLE [dbo].[OrderHistory] ADD  CONSTRAINT [DF_OrderHistory_OtherCharges]  DEFAULT ((0)) FOR [OtherCharges]
GO
ALTER TABLE [dbo].[OrderHistory] ADD  CONSTRAINT [DF_OrderHistory_TaxAmount]  DEFAULT ((0)) FOR [TaxAmount]
GO
ALTER TABLE [dbo].[OrderHistory] ADD  CONSTRAINT [DF_OrderHistory_ModifyDate]  DEFAULT (getdate()) FOR [ModifyDate]
GO
ALTER TABLE [dbo].[OrderHistory] ADD  CONSTRAINT [DF_OrderHistory_ConversionRate]  DEFAULT ((0)) FOR [ConversionRate]
GO
ALTER TABLE [dbo].[OrderHistoryLine] ADD  CONSTRAINT [DF_OrderHistoryLine_OrderHistoryLineId]  DEFAULT (newsequentialid()) FOR [OrderHistoryLineId]
GO
ALTER TABLE [dbo].[OrderHistoryLine] ADD  CONSTRAINT [DF_OrderHistoryLine_CustomerNumber]  DEFAULT ('') FOR [CustomerNumber]
GO
ALTER TABLE [dbo].[OrderHistoryLine] ADD  CONSTRAINT [DF_OrderHistoryLine_CustomerSequence]  DEFAULT ('') FOR [CustomerSequence]
GO
ALTER TABLE [dbo].[OrderHistoryLine] ADD  CONSTRAINT [DF_OrderHistoryLine_LineType]  DEFAULT ('') FOR [LineType]
GO
ALTER TABLE [dbo].[OrderHistoryLine] ADD  CONSTRAINT [DF_OrderHistoryLine_Status]  DEFAULT ('') FOR [Status]
GO
ALTER TABLE [dbo].[OrderHistoryLine] ADD  CONSTRAINT [DF_OrderHistoryLine_LineNumber]  DEFAULT ((0)) FOR [LineNumber]
GO
ALTER TABLE [dbo].[OrderHistoryLine] ADD  CONSTRAINT [DF_OrderHistoryLine_ReleaseNumber]  DEFAULT ((0)) FOR [ReleaseNumber]
GO
ALTER TABLE [dbo].[OrderHistoryLine] ADD  CONSTRAINT [DF_OrderHistoryLine_ProductERPNumber]  DEFAULT ('') FOR [ProductERPNumber]
GO
ALTER TABLE [dbo].[OrderHistoryLine] ADD  CONSTRAINT [DF_OrderHistoryLine_CustomerProductNumber]  DEFAULT ('') FOR [CustomerProductNumber]
GO
ALTER TABLE [dbo].[OrderHistoryLine] ADD  CONSTRAINT [DF_OrderHistoryLine_LinePOReference]  DEFAULT ('') FOR [LinePOReference]
GO
ALTER TABLE [dbo].[OrderHistoryLine] ADD  CONSTRAINT [DF_OrderHistoryLine_Description]  DEFAULT ('') FOR [Description]
GO
ALTER TABLE [dbo].[OrderHistoryLine] ADD  CONSTRAINT [DF_OrderHistoryLine_Warehouse]  DEFAULT ('') FOR [Warehouse]
GO
ALTER TABLE [dbo].[OrderHistoryLine] ADD  CONSTRAINT [DF_OrderHistoryLine_Notes]  DEFAULT ('') FOR [Notes]
GO
ALTER TABLE [dbo].[OrderHistoryLine] ADD  CONSTRAINT [DF_OrderHistoryLine_QtyOrdered]  DEFAULT ((0)) FOR [QtyOrdered]
GO
ALTER TABLE [dbo].[OrderHistoryLine] ADD  CONSTRAINT [DF_OrderHistoryLine_QtyShipped]  DEFAULT ((0)) FOR [QtyShipped]
GO
ALTER TABLE [dbo].[OrderHistoryLine] ADD  CONSTRAINT [DF_OrderHistoryLine_UnitOfMeasure]  DEFAULT ('') FOR [UnitOfMeasure]
GO
ALTER TABLE [dbo].[OrderHistoryLine] ADD  CONSTRAINT [DF_OrderHistoryLine_InventoryQtyOrdered]  DEFAULT ((0)) FOR [InventoryQtyOrdered]
GO
ALTER TABLE [dbo].[OrderHistoryLine] ADD  CONSTRAINT [DF_OrderHistoryLine_InventoryQtyShipped]  DEFAULT ((0)) FOR [InventoryQtyShipped]
GO
ALTER TABLE [dbo].[OrderHistoryLine] ADD  CONSTRAINT [DF_OrderHistoryLine_UnitPrice]  DEFAULT ((0)) FOR [UnitPrice]
GO
ALTER TABLE [dbo].[OrderHistoryLine] ADD  CONSTRAINT [DF_OrderHistoryLine_DiscountPercent]  DEFAULT ((0)) FOR [DiscountPercent]
GO
ALTER TABLE [dbo].[OrderHistoryLine] ADD  CONSTRAINT [DF_OrderHistoryLine_DiscountAmount]  DEFAULT ((0)) FOR [DiscountAmount]
GO
ALTER TABLE [dbo].[OrderHistoryLine] ADD  CONSTRAINT [DF_OrderHistoryLine_PromotionAmountApplied]  DEFAULT ((0)) FOR [PromotionAmountApplied]
GO
ALTER TABLE [dbo].[OrderHistoryLine] ADD  CONSTRAINT [DF_OrderHistoryLine_LineTotal]  DEFAULT ((0)) FOR [LineTotal]
GO
ALTER TABLE [dbo].[OrderLineAttribute] ADD  CONSTRAINT [DF_OrderLineAttribute_OrderLineAttributeId]  DEFAULT (newsequentialid()) FOR [OrderLineAttributeId]
GO
ALTER TABLE [dbo].[OrderLineAttribute] ADD  CONSTRAINT [DF_OrderLineAttribute_Name]  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[OrderLineAttribute] ADD  CONSTRAINT [DF_OrderLineAttribute_Value]  DEFAULT ('') FOR [Value]
GO
ALTER TABLE [dbo].[OrderLineAttribute] ADD  CONSTRAINT [DF_OrderLineAttribute_Hidden]  DEFAULT ((0)) FOR [Hidden]
GO
ALTER TABLE [dbo].[OrderLineConfigurationValue] ADD  CONSTRAINT [DF_OrderLineConfigurationValue_OrderLineConfigurationValueId]  DEFAULT (newsequentialid()) FOR [OrderLineConfigurationValueId]
GO
ALTER TABLE [dbo].[OrderLineConfigurationValue] ADD  CONSTRAINT [DF_OrderLineConfigurationValue_PageSequence]  DEFAULT ((1)) FOR [PageSequence]
GO
ALTER TABLE [dbo].[OrderLineConfigurationValue] ADD  CONSTRAINT [DF_OrderLineConfigurationValue_OptionSequence]  DEFAULT ((1)) FOR [OptionSequence]
GO
ALTER TABLE [dbo].[OrderLineConfigurationValue] ADD  CONSTRAINT [DF_OrderLineConfigurationValue_PriceImpact]  DEFAULT ((0)) FOR [PriceImpact]
GO
ALTER TABLE [dbo].[OrderLineRequisition] ADD  CONSTRAINT [DF_OrderLineRequisition_OrderLineRequisitionId]  DEFAULT (newsequentialid()) FOR [OrderLineRequisitionId]
GO
ALTER TABLE [dbo].[OrderLineRequisition] ADD  CONSTRAINT [DF_OrderLineRequisition_QtyOrdered]  DEFAULT ((0)) FOR [QtyOrdered]
GO
ALTER TABLE [dbo].[OrderLineRequisition] ADD  CONSTRAINT [DF_OrderLineRequisition_CostCode]  DEFAULT ('') FOR [CostCode]
GO
ALTER TABLE [dbo].[OrderLineRfq] ADD  CONSTRAINT [DF_OrderLineRfq_OrderLineRfqId]  DEFAULT (newsequentialid()) FOR [OrderLineRfqId]
GO
ALTER TABLE [dbo].[OrderLineRfq] ADD  CONSTRAINT [DF_OrderLineRfq_BreakQty01]  DEFAULT ((0)) FOR [BreakQty01]
GO
ALTER TABLE [dbo].[OrderLineRfq] ADD  CONSTRAINT [DF_OrderLineRfq_BreakQty02]  DEFAULT ((0)) FOR [BreakQty02]
GO
ALTER TABLE [dbo].[OrderLineRfq] ADD  CONSTRAINT [DF_OrderLineRfq_BreakQty03]  DEFAULT ((0)) FOR [BreakQty03]
GO
ALTER TABLE [dbo].[OrderLineRfq] ADD  CONSTRAINT [DF_OrderLineRfq_BreakQty04]  DEFAULT ((0)) FOR [BreakQty04]
GO
ALTER TABLE [dbo].[OrderLineRfq] ADD  CONSTRAINT [DF_OrderLineRfq_BreakQty05]  DEFAULT ((0)) FOR [BreakQty05]
GO
ALTER TABLE [dbo].[OrderLineRfq] ADD  CONSTRAINT [DF_OrderLineRfq_BreakQty06]  DEFAULT ((0)) FOR [BreakQty06]
GO
ALTER TABLE [dbo].[OrderLineRfq] ADD  CONSTRAINT [DF_OrderLineRfq_BreakQty07]  DEFAULT ((0)) FOR [BreakQty07]
GO
ALTER TABLE [dbo].[OrderLineRfq] ADD  CONSTRAINT [DF_OrderLineRfq_BreakQty08]  DEFAULT ((0)) FOR [BreakQty08]
GO
ALTER TABLE [dbo].[OrderLineRfq] ADD  CONSTRAINT [DF_OrderLineRfq_BreakQty09]  DEFAULT ((0)) FOR [BreakQty09]
GO
ALTER TABLE [dbo].[OrderLineRfq] ADD  CONSTRAINT [DF_OrderLineRfq_BreakQty10]  DEFAULT ((0)) FOR [BreakQty10]
GO
ALTER TABLE [dbo].[OrderLineRfq] ADD  CONSTRAINT [DF_OrderLineRfq_BreakQty11]  DEFAULT ((0)) FOR [BreakQty11]
GO
ALTER TABLE [dbo].[OrderLineRfq] ADD  CONSTRAINT [DF_OrderLineRfq_Amount01]  DEFAULT ((0)) FOR [Amount01]
GO
ALTER TABLE [dbo].[OrderLineRfq] ADD  CONSTRAINT [DF_OrderLineRfq_Amount02]  DEFAULT ((0)) FOR [Amount02]
GO
ALTER TABLE [dbo].[OrderLineRfq] ADD  CONSTRAINT [DF_OrderLineRfq_Amount03]  DEFAULT ((0)) FOR [Amount03]
GO
ALTER TABLE [dbo].[OrderLineRfq] ADD  CONSTRAINT [DF_OrderLineRfq_Amount04]  DEFAULT ((0)) FOR [Amount04]
GO
ALTER TABLE [dbo].[OrderLineRfq] ADD  CONSTRAINT [DF_OrderLineRfq_Amount05]  DEFAULT ((0)) FOR [Amount05]
GO
ALTER TABLE [dbo].[OrderLineRfq] ADD  CONSTRAINT [DF_OrderLineRfq_Amount06]  DEFAULT ((0)) FOR [Amount06]
GO
ALTER TABLE [dbo].[OrderLineRfq] ADD  CONSTRAINT [DF_OrderLineRfq_Amount07]  DEFAULT ((0)) FOR [Amount07]
GO
ALTER TABLE [dbo].[OrderLineRfq] ADD  CONSTRAINT [DF_OrderLineRfq_Amount08]  DEFAULT ((0)) FOR [Amount08]
GO
ALTER TABLE [dbo].[OrderLineRfq] ADD  CONSTRAINT [DF_OrderLineRfq_Amount09]  DEFAULT ((0)) FOR [Amount09]
GO
ALTER TABLE [dbo].[OrderLineRfq] ADD  CONSTRAINT [DF_OrderLineRfq_Amount10]  DEFAULT ((0)) FOR [Amount10]
GO
ALTER TABLE [dbo].[OrderLineRfq] ADD  CONSTRAINT [DF_OrderLineRfq_Amount11]  DEFAULT ((0)) FOR [Amount11]
GO
ALTER TABLE [dbo].[OrderLineRfq] ADD  CONSTRAINT [DF_OrderLineRfq_MaxQty]  DEFAULT ((0)) FOR [MaxQty]
GO
ALTER TABLE [dbo].[PackageLine] ADD  CONSTRAINT [DF_PackageLine_PackageLineId]  DEFAULT (newsequentialid()) FOR [PackageLineId]
GO
ALTER TABLE [dbo].[PackageLine] ADD  CONSTRAINT [DF_PackageLine_ProductName]  DEFAULT ('') FOR [ProductName]
GO
ALTER TABLE [dbo].[PackageLine] ADD  CONSTRAINT [DF_PackageLine_ProductDescription]  DEFAULT ('') FOR [ProductDescription]
GO
ALTER TABLE [dbo].[PackageLine] ADD  CONSTRAINT [DF_PackageLine_ProductCode]  DEFAULT ('') FOR [ProductCode]
GO
ALTER TABLE [dbo].[PackageLine] ADD  CONSTRAINT [DF_PackageLine_QuantityOrdered]  DEFAULT ((0)) FOR [QtyOrdered]
GO
ALTER TABLE [dbo].[PackageLine] ADD  CONSTRAINT [DF_PackageLine_QuantityShipped]  DEFAULT ((0)) FOR [QtyShipped]
GO
ALTER TABLE [dbo].[PackageLine] ADD  CONSTRAINT [DF_PackageLine_Price]  DEFAULT ((0)) FOR [Price]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_PriceMatrixId]  DEFAULT (newsequentialid()) FOR [PriceMatrixId]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_RecordType]  DEFAULT ('') FOR [RecordType]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_CurrencyCode]  DEFAULT ('') FOR [CurrencyCode]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_Warehouse]  DEFAULT ('') FOR [Warehouse]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_UnitOfMeasure]  DEFAULT ('') FOR [UnitOfMeasure]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_CustomerKeyPart]  DEFAULT ('') FOR [CustomerKeyPart]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_ProductKeyPart]  DEFAULT ('') FOR [ProductKeyPart]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_CalculationFlags]  DEFAULT ('') FOR [CalculationFlags]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_PriceBasis01]  DEFAULT ('') FOR [PriceBasis01]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_PriceBasis02]  DEFAULT ('') FOR [PriceBasis02]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_PriceBasis03]  DEFAULT ('') FOR [PriceBasis03]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_PriceBasis04]  DEFAULT ('') FOR [PriceBasis04]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_PriceBasis05]  DEFAULT ('') FOR [PriceBasis05]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_PriceBasis06]  DEFAULT ('') FOR [PriceBasis06]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_PriceBasis07]  DEFAULT ('') FOR [PriceBasis07]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_PriceBasis08]  DEFAULT ('') FOR [PriceBasis08]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_PriceBasis09]  DEFAULT ('') FOR [PriceBasis09]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_PriceBasis10]  DEFAULT ('') FOR [PriceBasis10]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_PriceBasis11]  DEFAULT ('') FOR [PriceBasis11]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_AdjustmentType01]  DEFAULT ('') FOR [AdjustmentType01]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_AdjustmentType02]  DEFAULT ('') FOR [AdjustmentType02]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_AdjustmentType03]  DEFAULT ('') FOR [AdjustmentType03]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_AdjustmentType04]  DEFAULT ('') FOR [AdjustmentType04]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_AdjustmentType05]  DEFAULT ('') FOR [AdjustmentType05]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_AdjustmentType06]  DEFAULT ('') FOR [AdjustmentType06]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_AdjustmentType07]  DEFAULT ('') FOR [AdjustmentType07]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_AdjustmentType08]  DEFAULT ('') FOR [AdjustmentType08]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_AdjustmentType09]  DEFAULT ('') FOR [AdjustmentType09]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_AdjustmentType10]  DEFAULT ('') FOR [AdjustmentType10]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_AdjustmentType11]  DEFAULT ('') FOR [AdjustmentType11]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_BreakQty01]  DEFAULT ((0)) FOR [BreakQty01]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_BreakQty02]  DEFAULT ((0)) FOR [BreakQty02]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_BreakQty03]  DEFAULT ((0)) FOR [BreakQty03]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_BreakQty04]  DEFAULT ((0)) FOR [BreakQty04]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_BreakQty05]  DEFAULT ((0)) FOR [BreakQty05]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_BreakQty06]  DEFAULT ((0)) FOR [BreakQty06]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_BreakQty07]  DEFAULT ((0)) FOR [BreakQty07]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_BreakQty08]  DEFAULT ((0)) FOR [BreakQty08]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_BreakQty09]  DEFAULT ((0)) FOR [BreakQty09]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_BreakQty10]  DEFAULT ((0)) FOR [BreakQty10]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_BreakQty11]  DEFAULT ((0)) FOR [BreakQty11]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_Amount01]  DEFAULT ((0)) FOR [Amount01]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_Amount02]  DEFAULT ((0)) FOR [Amount02]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_Amount03]  DEFAULT ((0)) FOR [Amount03]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_Amount04]  DEFAULT ((0)) FOR [Amount04]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_Amount05]  DEFAULT ((0)) FOR [Amount05]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_Amount06]  DEFAULT ((0)) FOR [Amount06]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_Amount07]  DEFAULT ((0)) FOR [Amount07]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_Amount08]  DEFAULT ((0)) FOR [Amount08]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_Amount09]  DEFAULT ((0)) FOR [Amount09]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_Amount10]  DEFAULT ((0)) FOR [Amount10]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_Amount11]  DEFAULT ((0)) FOR [Amount11]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_AltAmount01]  DEFAULT ((0)) FOR [AltAmount01]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_AltAmount02]  DEFAULT ((0)) FOR [AltAmount02]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_AltAmount03]  DEFAULT ((0)) FOR [AltAmount03]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_AltAmount04]  DEFAULT ((0)) FOR [AltAmount04]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_AltAmount05]  DEFAULT ((0)) FOR [AltAmount05]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_AltAmount06]  DEFAULT ((0)) FOR [AltAmount06]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_AltAmount07]  DEFAULT ((0)) FOR [AltAmount07]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_AltAmount08]  DEFAULT ((0)) FOR [AltAmount08]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_AltAmount09]  DEFAULT ((0)) FOR [AltAmount09]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_AltAmount10]  DEFAULT ((0)) FOR [AltAmount10]
GO
ALTER TABLE [dbo].[PriceMatrix] ADD  CONSTRAINT [DF_PriceMatrix_AltAmount11]  DEFAULT ((0)) FOR [AltAmount11]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_PriceMatrixId]  DEFAULT (newsequentialid()) FOR [PriceMatrixId]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_RecordType]  DEFAULT ('') FOR [RecordType]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_CurrencyCode]  DEFAULT ('') FOR [CurrencyCode]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_Warehouse]  DEFAULT ('') FOR [Warehouse]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_UnitOfMeasure]  DEFAULT ('') FOR [UnitOfMeasure]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_CustomerKeyPart]  DEFAULT ('') FOR [CustomerKeyPart]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_ProductKeyPart]  DEFAULT ('') FOR [ProductKeyPart]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_CalculationFlags]  DEFAULT ('') FOR [CalculationFlags]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_PriceBasis01]  DEFAULT ('') FOR [PriceBasis01]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_PriceBasis02]  DEFAULT ('') FOR [PriceBasis02]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_PriceBasis03]  DEFAULT ('') FOR [PriceBasis03]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_PriceBasis04]  DEFAULT ('') FOR [PriceBasis04]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_PriceBasis05]  DEFAULT ('') FOR [PriceBasis05]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_PriceBasis06]  DEFAULT ('') FOR [PriceBasis06]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_PriceBasis07]  DEFAULT ('') FOR [PriceBasis07]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_PriceBasis08]  DEFAULT ('') FOR [PriceBasis08]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_PriceBasis09]  DEFAULT ('') FOR [PriceBasis09]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_PriceBasis10]  DEFAULT ('') FOR [PriceBasis10]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_PriceBasis11]  DEFAULT ('') FOR [PriceBasis11]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_AdjustmentType01]  DEFAULT ('') FOR [AdjustmentType01]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_AdjustmentType02]  DEFAULT ('') FOR [AdjustmentType02]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_AdjustmentType03]  DEFAULT ('') FOR [AdjustmentType03]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_AdjustmentType04]  DEFAULT ('') FOR [AdjustmentType04]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_AdjustmentType05]  DEFAULT ('') FOR [AdjustmentType05]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_AdjustmentType06]  DEFAULT ('') FOR [AdjustmentType06]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_AdjustmentType07]  DEFAULT ('') FOR [AdjustmentType07]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_AdjustmentType08]  DEFAULT ('') FOR [AdjustmentType08]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_AdjustmentType09]  DEFAULT ('') FOR [AdjustmentType09]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_AdjustmentType10]  DEFAULT ('') FOR [AdjustmentType10]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_AdjustmentType11]  DEFAULT ('') FOR [AdjustmentType11]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_BreakQty01]  DEFAULT ((0)) FOR [BreakQty01]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_BreakQty02]  DEFAULT ((0)) FOR [BreakQty02]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_BreakQty03]  DEFAULT ((0)) FOR [BreakQty03]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_BreakQty04]  DEFAULT ((0)) FOR [BreakQty04]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_BreakQty05]  DEFAULT ((0)) FOR [BreakQty05]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_BreakQty06]  DEFAULT ((0)) FOR [BreakQty06]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_BreakQty07]  DEFAULT ((0)) FOR [BreakQty07]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_BreakQty08]  DEFAULT ((0)) FOR [BreakQty08]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_BreakQty09]  DEFAULT ((0)) FOR [BreakQty09]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_BreakQty10]  DEFAULT ((0)) FOR [BreakQty10]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_BreakQty11]  DEFAULT ((0)) FOR [BreakQty11]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_Amount01]  DEFAULT ((0)) FOR [Amount01]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_Amount02]  DEFAULT ((0)) FOR [Amount02]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_Amount03]  DEFAULT ((0)) FOR [Amount03]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_Amount04]  DEFAULT ((0)) FOR [Amount04]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_Amount05]  DEFAULT ((0)) FOR [Amount05]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_Amount06]  DEFAULT ((0)) FOR [Amount06]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_Amount07]  DEFAULT ((0)) FOR [Amount07]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_Amount08]  DEFAULT ((0)) FOR [Amount08]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_Amount09]  DEFAULT ((0)) FOR [Amount09]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_Amount10]  DEFAULT ((0)) FOR [Amount10]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_Amount11]  DEFAULT ((0)) FOR [Amount11]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_AltAmount01]  DEFAULT ((0)) FOR [AltAmount01]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_AltAmount02]  DEFAULT ((0)) FOR [AltAmount02]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_AltAmount03]  DEFAULT ((0)) FOR [AltAmount03]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_AltAmount04]  DEFAULT ((0)) FOR [AltAmount04]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_AltAmount05]  DEFAULT ((0)) FOR [AltAmount05]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_AltAmount06]  DEFAULT ((0)) FOR [AltAmount06]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_AltAmount07]  DEFAULT ((0)) FOR [AltAmount07]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_AltAmount08]  DEFAULT ((0)) FOR [AltAmount08]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_AltAmount09]  DEFAULT ((0)) FOR [AltAmount09]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_AltAmount10]  DEFAULT ((0)) FOR [AltAmount10]
GO
ALTER TABLE [dbo].[PriceMatrix_Batch] ADD  CONSTRAINT [DF_PriceMatrix_Batch_AltAmount11]  DEFAULT ((0)) FOR [AltAmount11]
GO
ALTER TABLE [dbo].[ProductCost] ADD  CONSTRAINT [DF_ProductCost_ProductCostId]  DEFAULT (newsequentialid()) FOR [ProductCostId]
GO
ALTER TABLE [dbo].[ProductCost] ADD  CONSTRAINT [DF_ProductCost_ProductId]  DEFAULT (newid()) FOR [ProductId]
GO
ALTER TABLE [dbo].[ProductCost] ADD  CONSTRAINT [DF_ProductCost_SiteName]  DEFAULT ('') FOR [SiteName]
GO
ALTER TABLE [dbo].[ProductCost] ADD  CONSTRAINT [DF_ProductCost_Cost]  DEFAULT ((0)) FOR [Cost]
GO
ALTER TABLE [dbo].[ProductPrice] ADD  CONSTRAINT [DF_ProductPrice_ProductPriceId]  DEFAULT (newsequentialid()) FOR [ProductPriceId]
GO
ALTER TABLE [dbo].[ProductPrice] ADD  CONSTRAINT [DF_ProductPrice_BreakQty]  DEFAULT ((0)) FOR [BreakQty]
GO
ALTER TABLE [dbo].[ProductPrice] ADD  CONSTRAINT [DF_ProductPrice_Price]  DEFAULT ((0)) FOR [Price]
GO
ALTER TABLE [dbo].[ProductPrice] ADD  CONSTRAINT [DF_ProductPrice_Active]  DEFAULT (getdate()) FOR [Active]
GO
ALTER TABLE [dbo].[ProductPrice] ADD  CONSTRAINT [DF_ProductPrice_PricePerPiece]  DEFAULT ((0)) FOR [PricePerPiece]
GO
ALTER TABLE [dbo].[ProductPrice] ADD  CONSTRAINT [DF_ProductPrice_IsOnSale]  DEFAULT ((0)) FOR [IsOnSale]
GO
ALTER TABLE [dbo].[ProductPrice] ADD  CONSTRAINT [DF_ProductPrice_SalePrice]  DEFAULT ((0)) FOR [SalePrice]
GO
ALTER TABLE [dbo].[ProductPrice] ADD  CONSTRAINT [DF_ProductPrice_RegularMarkup]  DEFAULT ((0)) FOR [RegularMarkup]
GO
ALTER TABLE [dbo].[ProductPrice] ADD  CONSTRAINT [DF_ProductPrice_SaleMarkup]  DEFAULT ((0)) FOR [SaleMarkup]
GO
ALTER TABLE [dbo].[ProductPrice] ADD  CONSTRAINT [DF_ProductPrice_CurrencyCode]  DEFAULT ('') FOR [CurrencyCode]
GO
ALTER TABLE [dbo].[ProductProperty] ADD  CONSTRAINT [DF_ProductProperty_ProductPropertyId]  DEFAULT (newsequentialid()) FOR [ProductPropertyId]
GO
ALTER TABLE [dbo].[ProductProperty] ADD  CONSTRAINT [DF_ProductProperty_Name]  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[ProductProperty] ADD  CONSTRAINT [DF_ProductProperty_Value]  DEFAULT ('') FOR [Value]
GO
ALTER TABLE [dbo].[ProductUnitOfMeasure] ADD  CONSTRAINT [DF_ProductUnitOfMeasure_ProductUnitOfMeasureId]  DEFAULT (newsequentialid()) FOR [ProductUnitOfMeasureId]
GO
ALTER TABLE [dbo].[ProductUnitOfMeasure] ADD  CONSTRAINT [DF_ProductUnitOfMeasure_Description]  DEFAULT ('') FOR [Description]
GO
ALTER TABLE [dbo].[ProductUnitOfMeasure] ADD  CONSTRAINT [DF_ProductUnitOfMeasure_QtyPerBaseUnitOfMeasure]  DEFAULT ((0)) FOR [QtyPerBaseUnitOfMeasure]
GO
ALTER TABLE [dbo].[ProductUnitOfMeasure] ADD  CONSTRAINT [DF_ProductUnitOfMeasure_RoundingRule]  DEFAULT ('') FOR [RoundingRule]
GO
ALTER TABLE [dbo].[ProductUnitOfMeasure] ADD  CONSTRAINT [DF_ProductUnitOfMeasure_IsDefault]  DEFAULT ((0)) FOR [IsDefault]
GO
ALTER TABLE [dbo].[ProductWarehouse] ADD  CONSTRAINT [DF_ProductWarehouse_ProductWarehouseId]  DEFAULT (newsequentialid()) FOR [ProductWarehouseId]
GO
ALTER TABLE [dbo].[ProductWarehouse] ADD  CONSTRAINT [DF_ProductWarehouse_ErpQtyAvailable]  DEFAULT ((0)) FOR [ErpQtyAvailable]
GO
ALTER TABLE [dbo].[ProductWarehouse] ADD  CONSTRAINT [DF_ProductWarehouse_QtyOnOrder]  DEFAULT ((0)) FOR [QtyOnOrder]
GO
ALTER TABLE [dbo].[ProductWarehouse] ADD  CONSTRAINT [DF_ProductWarehouse_SafetyStock]  DEFAULT ((0)) FOR [SafetyStock]
GO
ALTER TABLE [dbo].[ProductWarehouse] ADD  CONSTRAINT [DF_ProductWarehouse_UnitCost]  DEFAULT ((0)) FOR [UnitCost]
GO
ALTER TABLE [dbo].[ProductWarehouse] ADD  CONSTRAINT [DF_ProductWarehouse_IsDiscontinued]  DEFAULT ((0)) FOR [IsDiscontinued]
GO
ALTER TABLE [dbo].[PromotionCode] ADD  CONSTRAINT [DF_PromotionCode_PromotionCodeId]  DEFAULT (newsequentialid()) FOR [PromotionCodeId]
GO
ALTER TABLE [dbo].[PromotionCode] ADD  CONSTRAINT [DF_PromotionCode_Code]  DEFAULT ('') FOR [Code]
GO
ALTER TABLE [dbo].[PunchOutCustomerUserProfileMap] ADD  CONSTRAINT [DF_PunchOutCustomerUserProfileMap_PunchOutCustomerUserProfileMapId]  DEFAULT (newsequentialid()) FOR [PunchOutCustomerUserProfileMapId]
GO
ALTER TABLE [dbo].[PunchOutCustomerUserProfileMap] ADD  CONSTRAINT [DF_PunchOutCustomerUserProfileMap_AddressId]  DEFAULT ('') FOR [AddressId]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_PunchOutOrderRequestId]  DEFAULT (newsequentialid()) FOR [PunchOutOrderRequestId]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_FromIdentity]  DEFAULT ('') FOR [FromIdentity]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_ToIdentity]  DEFAULT ('') FOR [ToIdentity]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_SenderIdentity]  DEFAULT ('') FOR [SenderIdentity]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_FromUserAgent]  DEFAULT ('') FOR [FromUserAgent]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_OrderType]  DEFAULT ('') FOR [OrderType]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_OrderVersion]  DEFAULT ('') FOR [OrderVersion]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_IsInternalVersion]  DEFAULT ('') FOR [IsInternalVersion]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_AgreementId]  DEFAULT ('') FOR [AgreementId]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_Table_2_ParenetAgreementId]  DEFAULT ('') FOR [AgreementPayloadId]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_ParentAgreementId]  DEFAULT ('') FOR [ParentAgreementId]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_RequisitionId]  DEFAULT ('') FOR [RequisitionId]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_ShipComplete]  DEFAULT ('') FOR [ShipComplete]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_ReleaseRequired]  DEFAULT ('') FOR [ReleaseRequired]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_Type]  DEFAULT ('') FOR [Type]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_PunchOutOrderRequestCXml]  DEFAULT ('') FOR [PunchOutOrderRequestCXml]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_Total]  DEFAULT ('') FOR [Total]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_TotalCurrency]  DEFAULT ('') FOR [TotalCurrency]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_Shipping]  DEFAULT ('') FOR [Shipping]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_ShippingCurrency]  DEFAULT ('') FOR [ShippingCurrency]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_ShippingDescription]  DEFAULT ('') FOR [ShippingDescription]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_BillToAddressId]  DEFAULT ('') FOR [BillToAddressId]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_BillToName]  DEFAULT ('') FOR [BillToName]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_BillToStreet]  DEFAULT ('') FOR [BillToStreet]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_BillToCity]  DEFAULT ('') FOR [BillToCity]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_BillToState]  DEFAULT ('') FOR [BillToState]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_BillToPostalCode]  DEFAULT ('') FOR [BillToPostalCode]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_BillToIsoCountryCode]  DEFAULT ('') FOR [BillToIsoCountryCode]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_BillToCountry]  DEFAULT ('') FOR [BillToCountry]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_ShipToAddressId]  DEFAULT ('') FOR [ShipToAddressId]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_ShipToName]  DEFAULT ('') FOR [ShipToName]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_ShipToStreet]  DEFAULT ('') FOR [ShipToStreet]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_ShipToCity]  DEFAULT ('') FOR [ShipToCity]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_ShipToState]  DEFAULT ('') FOR [ShipToState]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_ShipToPostalCode]  DEFAULT ('') FOR [ShipToPostalCode]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_ShipToIsoCountryCode]  DEFAULT ('') FOR [ShipToIsoCountryCode]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_ShipToCountry]  DEFAULT ('') FOR [ShipToCountry]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_BillToDeliver1]  DEFAULT ('') FOR [BillToDeliver1]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_ShipToDeliver1]  DEFAULT ('') FOR [ShipToDeliver1]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_ShipToDeliver2]  DEFAULT ('') FOR [ShipToDeliver2]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_BillToDeliver2]  DEFAULT ('') FOR [BillToDeliver2]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_Customer_Comments]  DEFAULT ('') FOR [Comments]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_BillToEmail]  DEFAULT ('') FOR [BillToEmail]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_ShipToEmail]  DEFAULT ('') FOR [ShipToEmail]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_CustomerOrderId]  DEFAULT (NULL) FOR [CustomerOrderId]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_UserProfileId]  DEFAULT (NULL) FOR [UserProfileId]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_BillToStreet2]  DEFAULT ('') FOR [BillToStreet2]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_BillToStreet3]  DEFAULT ('') FOR [BillToStreet3]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_BillToStreet4]  DEFAULT ('') FOR [BillToStreet4]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_BillToTelephoneNumber]  DEFAULT ('') FOR [BillToTelephoneNumber]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_BillToTelephoneIsoCountryCode]  DEFAULT ('') FOR [BillToTelephoneIsoCountryCode]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_BillToTelephoneAreaOrCityCode]  DEFAULT ('') FOR [BillToTelephoneAreaOrCityCode]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_ShipToStreet2]  DEFAULT ('') FOR [ShipToStreet2]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_ShipToStreet3]  DEFAULT ('') FOR [ShipToStreet3]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_ShipToStreet4]  DEFAULT ('') FOR [ShipToStreet4]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_ShipToTelephoneNumber]  DEFAULT ('') FOR [ShipToTelephoneNumber]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_ShipToTelephoneIsoCountryCode]  DEFAULT ('') FOR [ShipToTelephoneIsoCountryCode]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_ShipToTelephoneAreaOrCityCode]  DEFAULT ('') FOR [ShipToTelephoneAreaOrCityCode]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_PunchOutSessionId]  DEFAULT (NULL) FOR [PunchOutSessionId]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_BillToTelephoneCountryCode]  DEFAULT ('') FOR [BillToTelephoneCountryCode]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_ShipToTelephoneCountryCode]  DEFAULT ('') FOR [ShipToTelephoneCountryCode]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_OrderResponse]  DEFAULT ('') FOR [OrderResponse]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] ADD  CONSTRAINT [DF_PunchOutOrderRequest_CustomerPo]  DEFAULT ('') FOR [CustomerPo]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestExtrinsic] ADD  CONSTRAINT [DF_PunchOutOrderRequestExtrinsic_PunchOutOrderRequestExtrinsicId]  DEFAULT (newsequentialid()) FOR [PunchOutOrderRequestExtrinsicId]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestExtrinsic] ADD  CONSTRAINT [DF_PunchOutOrderRequestExtrinsic_Name]  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestExtrinsic] ADD  CONSTRAINT [DF_PunchOutOrderRequestExtrinsic_Value]  DEFAULT ('') FOR [Value]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut] ADD  CONSTRAINT [DF_PunchOutOrderRequestItemOut_PunchOutOrderRequestItemOutId]  DEFAULT (newsequentialid()) FOR [PunchOutOrderRequestItemOutId]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut] ADD  CONSTRAINT [DF_PunchOutOrderRequestItemOut_SupplierPartId]  DEFAULT ('') FOR [SupplierPartId]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut] ADD  CONSTRAINT [DF_PunchOutOrderRequestItemOut_SupplierPartAuxiliaryId]  DEFAULT ('') FOR [SupplierPartAuxiliaryId]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut] ADD  CONSTRAINT [DF_PunchOutOrderRequestItemOut_Quantity]  DEFAULT ('') FOR [Quantity]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut] ADD  CONSTRAINT [DF_PunchOutOrderRequestItemOut_LineNumber]  DEFAULT ('') FOR [LineNumber]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut] ADD  CONSTRAINT [DF_PunchOutOrderRequestItemOut_RequisitionId]  DEFAULT ('') FOR [RequisitionId]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut] ADD  CONSTRAINT [DF_PunchOutOrderRequestItemOut_AgreementItemNumber]  DEFAULT ('') FOR [AgreementItemNumber]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut] ADD  CONSTRAINT [DF_PunchOutOrderRequestItemOut_RequisitionDelivertDate]  DEFAULT ('') FOR [RequestedDeliveryDate]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut] ADD  CONSTRAINT [DF_PunchOutOrderRequestItemOut_IsAdHoc]  DEFAULT ('') FOR [IsAdHoc]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut] ADD  CONSTRAINT [DF_PunchOutOrderRequestItemOut_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut] ADD  CONSTRAINT [DF_PunchOutOrderRequestItemOut_UnitPrice]  DEFAULT ('') FOR [UnitPrice]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut] ADD  CONSTRAINT [DF_PunchOutOrderRequestItemOut_UnitPriceCurrency]  DEFAULT ('') FOR [UnitPriceCurrency]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut] ADD  CONSTRAINT [DF_PunchOutOrderRequestItemOut_Description]  DEFAULT ('') FOR [Description]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut] ADD  CONSTRAINT [DF_PunchOutOrderRequestItemOut_UnitOfMeasure]  DEFAULT ('') FOR [UnitOfMeasure]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut] ADD  CONSTRAINT [DF_PunchOutOrderRequestItemOut_Classification]  DEFAULT ('') FOR [Classification]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut] ADD  CONSTRAINT [DF_PunchOutOrderRequestItemOut_ClassificationDomain]  DEFAULT ('') FOR [ClassificationDomain]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut] ADD  CONSTRAINT [DF_PunchOutOrderRequestItemOut_ManufacturerPartId]  DEFAULT ('') FOR [ManufacturerPartId]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut] ADD  CONSTRAINT [DF_PunchOutOrderRequestItemOut_ManufacturerName]  DEFAULT ('') FOR [ManufacturerName]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut] ADD  CONSTRAINT [DF_PunchOutOrderRequestItemOut_Url]  DEFAULT ('') FOR [Url]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut] ADD  CONSTRAINT [DF_PunchOutOrderRequestItemOut_BillToAddressId]  DEFAULT ('') FOR [BillToAddressId]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut] ADD  CONSTRAINT [DF_PunchOutOrderRequestItemOut_BillToName]  DEFAULT ('') FOR [BillToName]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut] ADD  CONSTRAINT [DF_PunchOutOrderRequestItemOut_BillToStreet]  DEFAULT ('') FOR [BillToStreet]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut] ADD  CONSTRAINT [DF_PunchOutOrderRequestItemOut_BillToCity]  DEFAULT ('') FOR [BillToCity]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut] ADD  CONSTRAINT [DF_PunchOutOrderRequestItemOut_BillToState]  DEFAULT ('') FOR [BillToState]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut] ADD  CONSTRAINT [DF_PunchOutOrderRequestItemOut_BillToPostalCode]  DEFAULT ('') FOR [BillToPostalCode]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut] ADD  CONSTRAINT [DF_PunchOutOrderRequestItemOut_BillToIsoCountryCode]  DEFAULT ('') FOR [BillToIsoCountryCode]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut] ADD  CONSTRAINT [DF_PunchOutOrderRequestItemOut_BillToCountry]  DEFAULT ('') FOR [BillToCountry]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut] ADD  CONSTRAINT [DF_PunchOutOrderRequestItemOut_BillToDeliver1]  DEFAULT ('') FOR [BillToDeliver1]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut] ADD  CONSTRAINT [DF_PunchOutOrderRequestItemOut_BillToDeliver2]  DEFAULT ('') FOR [BillToDeliver2]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut] ADD  CONSTRAINT [DF_PunchOutOrderRequestItemOutt_ShipToAddressId]  DEFAULT ('') FOR [ShipToAddressId]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut] ADD  CONSTRAINT [DF_PunchOutOrderRequestItemOut_ShipToName]  DEFAULT ('') FOR [ShipToName]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut] ADD  CONSTRAINT [DF_PunchOutOrderRequestItemOut_ShipToStreet]  DEFAULT ('') FOR [ShipToStreet]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut] ADD  CONSTRAINT [DF_PunchOutOrderRequestItemOut_ShipToCity]  DEFAULT ('') FOR [ShipToCity]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut] ADD  CONSTRAINT [DF_PunchOutOrderRequestItemOut_ShipToState]  DEFAULT ('') FOR [ShipToState]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut] ADD  CONSTRAINT [DF_PunchOutOrderRequestItemOut_ShipToPostalCode]  DEFAULT ('') FOR [ShipToPostalCode]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut] ADD  CONSTRAINT [DF_PunchOutOrderRequestItemOut_ShipToIsoCountryCode]  DEFAULT ('') FOR [ShipToIsoCountryCode]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut] ADD  CONSTRAINT [DF_PunchOutOrderRequestItemOut_ShipToCountry]  DEFAULT ('') FOR [ShipToCountry]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut] ADD  CONSTRAINT [DF_PunchOutOrderRequestItemOut_ShipToDeliver1]  DEFAULT ('') FOR [ShipToDeliver1]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut] ADD  CONSTRAINT [DF_PunchOutOrderRequestItemOutt_ShipToDeliver2]  DEFAULT ('') FOR [ShipToDeliver2]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut] ADD  CONSTRAINT [DF_PunchOutOrderRequestItemOut_BillToStreet2]  DEFAULT ('') FOR [BillToStreet2]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut] ADD  CONSTRAINT [DF_PunchOutOrderRequestItemOut_BillToStreet3]  DEFAULT ('') FOR [BillToStreet3]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut] ADD  CONSTRAINT [DF_PunchOutOrderRequestItemOut_BillToStreet4]  DEFAULT ('') FOR [BillToStreet4]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut] ADD  CONSTRAINT [DF_PunchOutOrderRequestItemOut_ShipToStreet2]  DEFAULT ('') FOR [ShipToStreet2]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut] ADD  CONSTRAINT [DF_PunchOutOrderRequestItemOut_ShipToStreet3]  DEFAULT ('') FOR [ShipToStreet3]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut] ADD  CONSTRAINT [DF_PunchOutOrderRequestItemOut_ShipToStreet4]  DEFAULT ('') FOR [ShipToStreet4]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut] ADD  CONSTRAINT [DF_PunchOutOrderRequestItemOut_OrderLineId]  DEFAULT (NULL) FOR [OrderLineId]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut] ADD  CONSTRAINT [DF_PunchOutOrderRequestItemOut_Comments]  DEFAULT ('') FOR [Comments]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestValidationMessage] ADD  CONSTRAINT [DF_PunchOutOrderRequestValidationMessage_PunchOutOrderRequestValidationMessageId]  DEFAULT (newsequentialid()) FOR [PunchOutOrderRequestValidationMessageId]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestValidationMessage] ADD  CONSTRAINT [DF_PunchOutOrderRequestValidationMessage_PunchOutOrderRequestValidationMessageType]  DEFAULT ('Unknown') FOR [PunchOutOrderRequestValidationMessageType]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestValidationMessage] ADD  CONSTRAINT [DF_PunchOutOrderRequestValidationMessage_Message]  DEFAULT ('') FOR [Message]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestValidationMessage] ADD  CONSTRAINT [DF_PunchOutOrderRequestValidationMessage_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[PunchOutSession] ADD  CONSTRAINT [DF_PunchOutSession_PunchOutSessionId]  DEFAULT (newsequentialid()) FOR [PunchOutSessionId]
GO
ALTER TABLE [dbo].[PunchOutSession] ADD  CONSTRAINT [DF_PunchOutSession_FromIdentity]  DEFAULT ('') FOR [FromIdentity]
GO
ALTER TABLE [dbo].[PunchOutSession] ADD  CONSTRAINT [DF_PunchOutSession_ToIdentity]  DEFAULT ('') FOR [ToIdentity]
GO
ALTER TABLE [dbo].[PunchOutSession] ADD  CONSTRAINT [DF_PunchOutSession_SenderIdentity]  DEFAULT ('') FOR [SenderIdentity]
GO
ALTER TABLE [dbo].[PunchOutSession] ADD  CONSTRAINT [DF_PunchOutSession_FromUserAgent]  DEFAULT ('') FOR [FromUserAgent]
GO
ALTER TABLE [dbo].[PunchOutSession] ADD  CONSTRAINT [DF_PunchOutSession_BuyerCookie]  DEFAULT ('') FOR [BuyerCookie]
GO
ALTER TABLE [dbo].[PunchOutSession] ADD  CONSTRAINT [DF_PunchOutSession_BrowserFormPost]  DEFAULT ('') FOR [BrowserFormPost]
GO
ALTER TABLE [dbo].[PunchOutSession] ADD  CONSTRAINT [DF_PunchOutSession_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[PunchOutSession] ADD  CONSTRAINT [DF_PunchOutSession_Domain]  DEFAULT ('') FOR [Domain]
GO
ALTER TABLE [dbo].[PunchOutSession] ADD  CONSTRAINT [DF_PunchOutSession_PunchOutSessionMode]  DEFAULT ('') FOR [PunchOutSessionMode]
GO
ALTER TABLE [dbo].[PunchOutSession] ADD  CONSTRAINT [DF_PunchOutSession_ToIdentityNode]  DEFAULT ('') FOR [ToIdentityNode]
GO
ALTER TABLE [dbo].[PunchOutSession] ADD  CONSTRAINT [DF_PunchOutSession_FromIdentityNode]  DEFAULT ('') FOR [FromIdentityNode]
GO
ALTER TABLE [dbo].[PunchOutSession] ADD  CONSTRAINT [DF_PunchOutSession_SenderIdentityNode]  DEFAULT ('') FOR [SenderIdentityNode]
GO
ALTER TABLE [dbo].[PunchOutSession] ADD  CONSTRAINT [DF_PunchOutSession_ShipToAddressId]  DEFAULT ('') FOR [ShipToAddressId]
GO
ALTER TABLE [dbo].[PunchOutSession] ADD  CONSTRAINT [DF_PunchOutSession_ShipToName]  DEFAULT ('') FOR [ShipToName]
GO
ALTER TABLE [dbo].[PunchOutSession] ADD  CONSTRAINT [DF_PunchOutSession_ShipToDeliverTo]  DEFAULT ('') FOR [ShipToDeliverTo]
GO
ALTER TABLE [dbo].[PunchOutSession] ADD  CONSTRAINT [DF_PunchOutSession_ShipToStreet]  DEFAULT ('') FOR [ShipToStreet]
GO
ALTER TABLE [dbo].[PunchOutSession] ADD  CONSTRAINT [DF_PunchOutSession_ShipToCity]  DEFAULT ('') FOR [ShipToCity]
GO
ALTER TABLE [dbo].[PunchOutSession] ADD  CONSTRAINT [DF_PunchOutSession_ShipToState]  DEFAULT ('') FOR [ShipToState]
GO
ALTER TABLE [dbo].[PunchOutSession] ADD  CONSTRAINT [DF_PunchOutSession_ShipToPostalCode]  DEFAULT ('') FOR [ShipToPostalCode]
GO
ALTER TABLE [dbo].[PunchOutSession] ADD  CONSTRAINT [DF_PunchOutSession_ShipToIsoCountryCode]  DEFAULT ('') FOR [ShipToIsoCountryCode]
GO
ALTER TABLE [dbo].[PunchOutSession] ADD  CONSTRAINT [DF_PunchOutSession_ShipToCountry]  DEFAULT ('') FOR [ShipToCountry]
GO
ALTER TABLE [dbo].[PunchOutSession] ADD  CONSTRAINT [DF_PunchOutSession_ShipAddressIdResolved]  DEFAULT ((0)) FOR [ShipAddressIdResolved]
GO
ALTER TABLE [dbo].[PunchOutSessionAccess] ADD  CONSTRAINT [DF_PunchOutSessionAccess_PunchOutSessionAccessId]  DEFAULT (newsequentialid()) FOR [PunchOutSessionAccessId]
GO
ALTER TABLE [dbo].[PunchOutSessionAccess] ADD  CONSTRAINT [DF_PunchOutSessionAccess_IpAddress]  DEFAULT ('') FOR [IpAddress]
GO
ALTER TABLE [dbo].[PunchOutSessionAccess] ADD  CONSTRAINT [DF_PunchOutSessionAccess_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[PunchOutSessionExtrinsic] ADD  CONSTRAINT [DF_PunchOutSessionExtrinsic_PunchOutSessionExtrinsicId]  DEFAULT (newsequentialid()) FOR [PunchOutSessionExtrinsicId]
GO
ALTER TABLE [dbo].[PunchOutSessionExtrinsic] ADD  CONSTRAINT [DF_PunchOutSessionExtrinsic_Name]  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[PunchOutSessionExtrinsic] ADD  CONSTRAINT [DF_PunchOutSessionExtrinsic_Value]  DEFAULT ('') FOR [Value]
GO
ALTER TABLE [dbo].[PunchOutSessionItemIn] ADD  CONSTRAINT [DF_PunchOutSessionItemIn_PunchOutSessionItemInId]  DEFAULT (newsequentialid()) FOR [PunchOutSessionItemInId]
GO
ALTER TABLE [dbo].[PunchOutSessionItemIn] ADD  CONSTRAINT [DF_PunchOutSessionItemIn_SupplierPartId]  DEFAULT ('') FOR [SupplierPartId]
GO
ALTER TABLE [dbo].[PunchOutSessionItemIn] ADD  CONSTRAINT [DF_PunchOutSessionItemIn_SupplierPartAuxiliaryId]  DEFAULT ('') FOR [SupplierPartAuxiliaryId]
GO
ALTER TABLE [dbo].[PunchOutSetupRequest] ADD  CONSTRAINT [DF_PunchOutSetupRequest_PunchOutSetupRequestId]  DEFAULT (newsequentialid()) FOR [PunchOutSetupRequestId]
GO
ALTER TABLE [dbo].[PunchOutSetupRequest] ADD  CONSTRAINT [DF_PunchOutSetupRequest_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[PunchOutSetupRequest] ADD  CONSTRAINT [DF_PunchOutSetupRequest_PunchOutSetupRequestCXml]  DEFAULT ('') FOR [PunchOutSetupRequestCXml]
GO
ALTER TABLE [dbo].[PunchOutSetupRequest] ADD  CONSTRAINT [DF_PunchOutSetupRequest_IpAddress]  DEFAULT ('') FOR [IpAddress]
GO
ALTER TABLE [dbo].[PunchOutSetupRequest] ADD  CONSTRAINT [DF_PunchOutSetupRequest_SetupRequestResponse]  DEFAULT ('') FOR [SetupRequestResponse]
GO
ALTER TABLE [dbo].[Restriction] ADD  CONSTRAINT [DF_Restriction_RestrictionId]  DEFAULT (newsequentialid()) FOR [RestrictionId]
GO
ALTER TABLE [dbo].[Restriction] ADD  CONSTRAINT [DF_Restriction_IsActive]  DEFAULT ((0)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Restriction] ADD  CONSTRAINT [DF_Restriction_Name]  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[RestrictionGroup] ADD  CONSTRAINT [DF_RestrictionGroup_RestrictionGroupId]  DEFAULT (newsequentialid()) FOR [RestrictionGroupId]
GO
ALTER TABLE [dbo].[RestrictionGroup] ADD  CONSTRAINT [DF_RestrictionGroup_Name]  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[RestrictionGroup] ADD  CONSTRAINT [DF_RestrictionGroup_Description]  DEFAULT ('') FOR [Description]
GO
ALTER TABLE [dbo].[RestrictionGroup] ADD  CONSTRAINT [DF_RestrictionGroup_DefaultCondition]  DEFAULT ('') FOR [DefaultCondition]
GO
ALTER TABLE [dbo].[Review] ADD  CONSTRAINT [DF_Review_ReviewId]  DEFAULT (newsequentialid()) FOR [ReviewId]
GO
ALTER TABLE [dbo].[Review] ADD  CONSTRAINT [DF_Review_Name]  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[Review] ADD  CONSTRAINT [DF_Review_Description]  DEFAULT ('') FOR [Description]
GO
ALTER TABLE [dbo].[Review] ADD  CONSTRAINT [DF_Review_Active]  DEFAULT (getdate()) FOR [Active]
GO
ALTER TABLE [dbo].[Review] ADD  CONSTRAINT [DF_Review_Deactivate]  DEFAULT (((12)/(31))/(9999)) FOR [Deactivate]
GO
ALTER TABLE [dbo].[RuleClause] ADD  CONSTRAINT [DF_RuleClause_RuleClauseId]  DEFAULT (newsequentialid()) FOR [RuleClauseId]
GO
ALTER TABLE [dbo].[RuleClause] ADD  CONSTRAINT [DF_RuleClause_ExecutionGroup]  DEFAULT ((0)) FOR [ExecutionGroup]
GO
ALTER TABLE [dbo].[RuleClause] ADD  CONSTRAINT [DF_RuleClause_ExecutionOrder]  DEFAULT ((0)) FOR [ExecutionOrder]
GO
ALTER TABLE [dbo].[RuleClause] ADD  CONSTRAINT [DF_RuleClause_Condition]  DEFAULT ('') FOR [Condition]
GO
ALTER TABLE [dbo].[RuleClause] ADD  CONSTRAINT [DF_RuleClause_CriteriaType]  DEFAULT ('') FOR [CriteriaType]
GO
ALTER TABLE [dbo].[RuleClause] ADD  CONSTRAINT [DF_RuleClause_CriteriaObject]  DEFAULT ('') FOR [CriteriaObject]
GO
ALTER TABLE [dbo].[RuleClause] ADD  CONSTRAINT [DF_RuleClause_CriteriaProperty]  DEFAULT ('') FOR [CriteriaProperty]
GO
ALTER TABLE [dbo].[RuleClause] ADD  CONSTRAINT [DF_RuleClause_CriteriaValue]  DEFAULT ('') FOR [CriteriaValue]
GO
ALTER TABLE [dbo].[RuleClause] ADD  CONSTRAINT [DF_RuleClause_ComparisonOperator]  DEFAULT ('') FOR [ComparisonOperator]
GO
ALTER TABLE [dbo].[RuleClause] ADD  CONSTRAINT [DF_RuleClause_SimpleValue]  DEFAULT ('') FOR [SimpleValue]
GO
ALTER TABLE [dbo].[RuleClause] ADD  CONSTRAINT [DF_RuleClause_ValueList]  DEFAULT ('') FOR [ValueList]
GO
ALTER TABLE [dbo].[RuleClause] ADD  CONSTRAINT [DF_RuleClause_ValueMinimum]  DEFAULT ('') FOR [ValueMinimum]
GO
ALTER TABLE [dbo].[RuleClause] ADD  CONSTRAINT [DF_RuleClause_ValueMaximum]  DEFAULT ('') FOR [ValueMaximum]
GO
ALTER TABLE [dbo].[RuleManager] ADD  CONSTRAINT [DF_RulesManager_RulesManagerId]  DEFAULT (newsequentialid()) FOR [RuleManagerId]
GO
ALTER TABLE [dbo].[RuleManager] ADD  CONSTRAINT [DF_RuleManager_Name]  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[Salesman] ADD  CONSTRAINT [DF_Salesman_SalesmanId]  DEFAULT (newsequentialid()) FOR [SalesmanId]
GO
ALTER TABLE [dbo].[Salesman] ADD  CONSTRAINT [DF_Salesman_SalesmanNumber]  DEFAULT ('') FOR [SalesmanNumber]
GO
ALTER TABLE [dbo].[Salesman] ADD  CONSTRAINT [DF_Salesman_Salesman]  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[Salesman] ADD  CONSTRAINT [DF_Salesman_SalesClass]  DEFAULT ('') FOR [SalesClass]
GO
ALTER TABLE [dbo].[Salesman] ADD  CONSTRAINT [DF_Salesman_Code]  DEFAULT ('') FOR [Code]
GO
ALTER TABLE [dbo].[Salesman] ADD  CONSTRAINT [DF_Salesman_SalesManager]  DEFAULT ('') FOR [SalesManager]
GO
ALTER TABLE [dbo].[Salesman] ADD  CONSTRAINT [DF_Salesman_ReferenceNumber]  DEFAULT ('') FOR [ReferenceNumber]
GO
ALTER TABLE [dbo].[Salesman] ADD  CONSTRAINT [DF_Salesman_Outside]  DEFAULT ((0)) FOR [Outside]
GO
ALTER TABLE [dbo].[Salesman] ADD  CONSTRAINT [DF_Salesman_SalesPeriodToDate]  DEFAULT ((0)) FOR [SalesPeriodToDate]
GO
ALTER TABLE [dbo].[Salesman] ADD  CONSTRAINT [DF_Salesman_SalesYearToDate]  DEFAULT ((0)) FOR [SalesYearToDate]
GO
ALTER TABLE [dbo].[Salesman] ADD  CONSTRAINT [DF_Salesman_Email]  DEFAULT ('') FOR [Email]
GO
ALTER TABLE [dbo].[Salesman] ADD  CONSTRAINT [DF_Salesman_Phone1]  DEFAULT ('') FOR [Phone1]
GO
ALTER TABLE [dbo].[Salesman] ADD  CONSTRAINT [DF_Salesman_Phone2]  DEFAULT ('') FOR [Phone2]
GO
ALTER TABLE [dbo].[Salesman] ADD  CONSTRAINT [DF_Salesman_Title]  DEFAULT ('') FOR [Title]
GO
ALTER TABLE [dbo].[Salesman] ADD  CONSTRAINT [DF_Salesman_ImagePath]  DEFAULT ('') FOR [ImagePath]
GO
ALTER TABLE [dbo].[Salesman] ADD  CONSTRAINT [DF_Salesman_Description]  DEFAULT ('') FOR [Description]
GO
ALTER TABLE [dbo].[Salesman] ADD  CONSTRAINT [DF_Salesman_MinMarginAllowed]  DEFAULT ((0)) FOR [MinMarginAllowed]
GO
ALTER TABLE [dbo].[Salesman] ADD  CONSTRAINT [DF_Salesman_MaxDiscountPercent]  DEFAULT ((0)) FOR [MaxDiscountPercent]
GO
ALTER TABLE [dbo].[ScheduledTask] ADD  CONSTRAINT [DF_ScheduledTask_ScheduledTaskId]  DEFAULT (newsequentialid()) FOR [ScheduledTaskId]
GO
ALTER TABLE [dbo].[ScheduledTask] ADD  CONSTRAINT [DF_ScheduledTask_Type]  DEFAULT ('') FOR [Type]
GO
ALTER TABLE [dbo].[ScheduledTask] ADD  CONSTRAINT [DF_ScheduledTask_Parameter]  DEFAULT ('') FOR [Parameter]
GO
ALTER TABLE [dbo].[ScheduledTask] ADD  CONSTRAINT [DF_ScheduledTask_MinuteInterval]  DEFAULT ((0)) FOR [MinuteInterval]
GO
ALTER TABLE [dbo].[ScheduledTask] ADD  CONSTRAINT [DF_ScheduledTask_IsRealTime]  DEFAULT ((0)) FOR [IsRealTime]
GO
ALTER TABLE [dbo].[ScheduledTask] ADD  CONSTRAINT [DF_ScheduledTask_ReturnAction]  DEFAULT ((0)) FOR [ReturnAction]
GO
ALTER TABLE [dbo].[ScheduledTask] ADD  CONSTRAINT [DF_ScheduledTask_ResultData]  DEFAULT ('') FOR [ResultData]
GO
ALTER TABLE [dbo].[SearchSynonym] ADD  CONSTRAINT [DF_SearchSynonym_SearchSynonymId]  DEFAULT (newsequentialid()) FOR [SearchSynonymId]
GO
ALTER TABLE [dbo].[SearchSynonym] ADD  CONSTRAINT [DF_SearchSynonym_Word]  DEFAULT ('') FOR [Word]
GO
ALTER TABLE [dbo].[SearchSynonym] ADD  CONSTRAINT [DF_SearchSynonym_Synonym]  DEFAULT ('') FOR [Synonym]
GO
ALTER TABLE [dbo].[SearchSynonym] ADD  CONSTRAINT [DF_SearchSynonym_Bidirectional]  DEFAULT ((1)) FOR [Bidirectional]
GO
ALTER TABLE [dbo].[SearchSynonym] ADD  CONSTRAINT [DF_SearchSynonym_LanguageCode]  DEFAULT ('') FOR [LanguageCode]
GO
ALTER TABLE [dbo].[ShippingClassification] ADD  CONSTRAINT [DF_ShippingClassification_ShippingClassificationId]  DEFAULT (newsequentialid()) FOR [ShippingClassificationId]
GO
ALTER TABLE [dbo].[ShippingClassification] ADD  CONSTRAINT [DF_ShippingClassification_Name]  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[ShippingClassification] ADD  CONSTRAINT [DF_ShippingClassification_Classification]  DEFAULT ('') FOR [Classification]
GO
ALTER TABLE [dbo].[ShippingClassification] ADD  CONSTRAINT [DF_ShippingClassification_Description]  DEFAULT ('') FOR [Description]
GO
ALTER TABLE [dbo].[ShipRate] ADD  CONSTRAINT [DF_ShipRate_ShipRateId]  DEFAULT (newsequentialid()) FOR [ShipRateId]
GO
ALTER TABLE [dbo].[ShipRate] ADD  CONSTRAINT [DF_ShipRate_OrderAmount]  DEFAULT ((0)) FOR [OrderAmount]
GO
ALTER TABLE [dbo].[ShipRate] ADD  CONSTRAINT [DF_ShipRate_PerEach]  DEFAULT ((0)) FOR [PerEach]
GO
ALTER TABLE [dbo].[ShipRule] ADD  CONSTRAINT [DF_ShipRule_ShipRuleId]  DEFAULT (newsequentialid()) FOR [ShipRuleId]
GO
ALTER TABLE [dbo].[ShipRule] ADD  CONSTRAINT [DF_ShipRule_Zip]  DEFAULT ('') FOR [Zip]
GO
ALTER TABLE [dbo].[ShipRule] ADD  CONSTRAINT [DF_ShipRule_MinimumAmount]  DEFAULT ((0)) FOR [MinimumAmount]
GO
ALTER TABLE [dbo].[ShipRule] ADD  CONSTRAINT [DF_ShipRule_MaximumAmount]  DEFAULT ((1000000)) FOR [MaximumAmount]
GO
ALTER TABLE [dbo].[ShipRule] ADD  CONSTRAINT [DF_ShipRule_ZipLowerRange]  DEFAULT ('') FOR [ZipLowerRange]
GO
ALTER TABLE [dbo].[ShipRule] ADD  CONSTRAINT [DF_ShipRule_ZipUpperRange]  DEFAULT ('') FOR [ZipUpperRange]
GO
ALTER TABLE [dbo].[ShipRule] ADD  CONSTRAINT [DF_ShipRule_ShipRuleType]  DEFAULT ('') FOR [ShipRuleType]
GO
ALTER TABLE [dbo].[ShipRule] ADD  CONSTRAINT [DF_ShipRule_ExecutionGroup]  DEFAULT ((0)) FOR [ExecutionGroup]
GO
ALTER TABLE [dbo].[ShipRule] ADD  CONSTRAINT [DF_ShipRule_ExecutionOrder]  DEFAULT ((0)) FOR [ExecutionOrder]
GO
ALTER TABLE [dbo].[ShipRule] ADD  CONSTRAINT [DF_ShipRule_Condition]  DEFAULT ('AND') FOR [Condition]
GO
ALTER TABLE [dbo].[ShipRule] ADD  CONSTRAINT [DF_ShipRule_TermsCode]  DEFAULT ('') FOR [TermsCode]
GO
ALTER TABLE [dbo].[ShipRule] ADD  CONSTRAINT [DF_ShipRule_CustomRuleName]  DEFAULT ('') FOR [CustomRuleName]
GO
ALTER TABLE [dbo].[StyleClass] ADD  CONSTRAINT [DF_StyleClass_StyleClassId]  DEFAULT (newsequentialid()) FOR [StyleClassId]
GO
ALTER TABLE [dbo].[StyleClass] ADD  CONSTRAINT [DF_StyleClass_Name]  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[StyleClass] ADD  CONSTRAINT [DF_StyleClass_Description]  DEFAULT ('') FOR [Description]
GO
ALTER TABLE [dbo].[StyleClass] ADD  CONSTRAINT [DF_StyleClass_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[StyleTrait] ADD  CONSTRAINT [DF_StyleTrait_StyleTraitId]  DEFAULT (newsequentialid()) FOR [StyleTraitId]
GO
ALTER TABLE [dbo].[StyleTrait] ADD  CONSTRAINT [DF_StyleTrait_Name]  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[StyleTrait] ADD  CONSTRAINT [DF_StyleTrait_UnselectedValue]  DEFAULT ('') FOR [UnselectedValue]
GO
ALTER TABLE [dbo].[StyleTrait] ADD  CONSTRAINT [DF_StyleTrait_SortOrder]  DEFAULT ((0)) FOR [SortOrder]
GO
ALTER TABLE [dbo].[StyleTrait] ADD  CONSTRAINT [DF_StyleTrait_Description]  DEFAULT ('') FOR [Description]
GO
ALTER TABLE [dbo].[StyleTraitValue] ADD  CONSTRAINT [DF_StyleTraitValue_StyleTraitValueId]  DEFAULT (newsequentialid()) FOR [StyleTraitValueId]
GO
ALTER TABLE [dbo].[StyleTraitValue] ADD  CONSTRAINT [DF_StyleTraitValue_Value]  DEFAULT ('') FOR [Value]
GO
ALTER TABLE [dbo].[StyleTraitValue] ADD  CONSTRAINT [DF_StyleTraitValue_SortOrder]  DEFAULT ((0)) FOR [SortOrder]
GO
ALTER TABLE [dbo].[StyleTraitValue] ADD  CONSTRAINT [DF_StyleTraitValue_IsDefault]  DEFAULT ((1)) FOR [IsDefault]
GO
ALTER TABLE [dbo].[StyleTraitValue] ADD  CONSTRAINT [DF_StyleTraitValue_Description]  DEFAULT ('') FOR [Description]
GO
ALTER TABLE [dbo].[Subscription] ADD  CONSTRAINT [DF_Subscription_SubscriptionId]  DEFAULT (newsequentialid()) FOR [SubscriptionId]
GO
ALTER TABLE [dbo].[Subscription] ADD  CONSTRAINT [DF_Subscription_Active]  DEFAULT (getdate()) FOR [Active]
GO
ALTER TABLE [dbo].[Subscription] ADD  CONSTRAINT [DF_Subscription_CyclePeriod]  DEFAULT ('') FOR [CyclePeriod]
GO
ALTER TABLE [dbo].[Subscription] ADD  CONSTRAINT [DF_Subscription_PeriodsPerCycle]  DEFAULT ((0)) FOR [PeriodsPerCycle]
GO
ALTER TABLE [dbo].[Subscription] ADD  CONSTRAINT [DF_Subscription_TotalCycles]  DEFAULT ((0)) FOR [TotalCycles]
GO
ALTER TABLE [dbo].[Subscription] ADD  CONSTRAINT [DF_Subscription_FixedPrice]  DEFAULT ((0)) FOR [FixedPrice]
GO
ALTER TABLE [dbo].[Subscription] ADD  CONSTRAINT [DF_Subscription_IncludeInInitialOrder]  DEFAULT ((0)) FOR [IncludeInInitialOrder]
GO
ALTER TABLE [dbo].[Subscription] ADD  CONSTRAINT [DF_Subscription_AllMonths]  DEFAULT ((0)) FOR [AllMonths]
GO
ALTER TABLE [dbo].[Subscription] ADD  CONSTRAINT [DF_Subscription_January]  DEFAULT ((0)) FOR [January]
GO
ALTER TABLE [dbo].[Subscription] ADD  CONSTRAINT [DF_Subscription_February]  DEFAULT ((0)) FOR [February]
GO
ALTER TABLE [dbo].[Subscription] ADD  CONSTRAINT [DF_Subscription_March]  DEFAULT ((0)) FOR [March]
GO
ALTER TABLE [dbo].[Subscription] ADD  CONSTRAINT [DF_Subscription_April]  DEFAULT ((0)) FOR [April]
GO
ALTER TABLE [dbo].[Subscription] ADD  CONSTRAINT [DF_Subscription_May]  DEFAULT ((0)) FOR [May]
GO
ALTER TABLE [dbo].[Subscription] ADD  CONSTRAINT [DF_Subscription_June]  DEFAULT ((0)) FOR [June]
GO
ALTER TABLE [dbo].[Subscription] ADD  CONSTRAINT [DF_Subscription_July]  DEFAULT ((0)) FOR [July]
GO
ALTER TABLE [dbo].[Subscription] ADD  CONSTRAINT [DF_Subscription_August]  DEFAULT ((0)) FOR [August]
GO
ALTER TABLE [dbo].[Subscription] ADD  CONSTRAINT [DF_Subscription_October]  DEFAULT ((0)) FOR [October]
GO
ALTER TABLE [dbo].[Subscription] ADD  CONSTRAINT [DF_Subscription_November]  DEFAULT ((0)) FOR [November]
GO
ALTER TABLE [dbo].[Subscription] ADD  CONSTRAINT [DF_Subscription_December]  DEFAULT ((0)) FOR [December]
GO
ALTER TABLE [dbo].[SubscriptionLine] ADD  CONSTRAINT [DF_SubscriptionLine_SubscriptionLineId]  DEFAULT (newsequentialid()) FOR [SubscriptionLineId]
GO
ALTER TABLE [dbo].[SubscriptionLine] ADD  CONSTRAINT [DF_SubscriptionLine_QtyOrdered]  DEFAULT ((0)) FOR [QtyOrdered]
GO
ALTER TABLE [dbo].[SubscriptionLine] ADD  CONSTRAINT [DF_SubscriptionLine_Price]  DEFAULT ((0)) FOR [Price]
GO
ALTER TABLE [dbo].[SubscriptionProduct] ADD  CONSTRAINT [DF_SubscriptionProduct_SubscriptionProductId]  DEFAULT (newsequentialid()) FOR [SubscriptionProductId]
GO
ALTER TABLE [dbo].[SubscriptionProduct] ADD  CONSTRAINT [DF_SubscriptionProduct_QtyOrdered]  DEFAULT ((0)) FOR [QtyOrdered]
GO
ALTER TABLE [dbo].[TaxExemption] ADD  CONSTRAINT [DF_TaxExemption_TaxExemptionId]  DEFAULT (newsequentialid()) FOR [TaxExemptionId]
GO
ALTER TABLE [dbo].[TaxExemption] ADD  CONSTRAINT [DF_TaxExemption_Name]  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[TaxExemption] ADD  CONSTRAINT [DF_TaxExemption_Description]  DEFAULT ('') FOR [Description]
GO
ALTER TABLE [dbo].[TaxExemption] ADD  CONSTRAINT [DF_TaxExemption_Active]  DEFAULT (getdate()) FOR [Active]
GO
ALTER TABLE [dbo].[tmp_PriceData] ADD  CONSTRAINT [DF_tmp_PriceData_tmp_PriceDataID]  DEFAULT (newsequentialid()) FOR [tmp_PriceDataId]
GO
ALTER TABLE [dbo].[TranslationProperty] ADD  CONSTRAINT [DF_TranslationProperty_TranslationPropertyId]  DEFAULT (newsequentialid()) FOR [TranslationPropertyId]
GO
ALTER TABLE [dbo].[TranslationProperty] ADD  CONSTRAINT [DF_TranslationProperty_ParentTable]  DEFAULT ('') FOR [ParentTable]
GO
ALTER TABLE [dbo].[TranslationProperty] ADD  CONSTRAINT [DF_TranslationProperty_Name]  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[TranslationProperty] ADD  CONSTRAINT [DF_TranslationProperty_LanguageCode]  DEFAULT ('') FOR [LanguageCode]
GO
ALTER TABLE [dbo].[TranslationProperty] ADD  CONSTRAINT [DF_TranslationProperty_TranslatedValue]  DEFAULT ('') FOR [TranslatedValue]
GO
ALTER TABLE [dbo].[UserProfilePassword] ADD  CONSTRAINT [DF_UserProfilePassword_UserProfilePasswordId]  DEFAULT (newsequentialid()) FOR [UserProfilePasswordId]
GO
ALTER TABLE [dbo].[Vendor] ADD  CONSTRAINT [DF_Vendor_VendorId]  DEFAULT (newsequentialid()) FOR [VendorId]
GO
ALTER TABLE [dbo].[Vendor] ADD  CONSTRAINT [DF_Vendor_VendorNumber]  DEFAULT ('') FOR [VendorNumber]
GO
ALTER TABLE [dbo].[Vendor] ADD  CONSTRAINT [DF_Vendor_Name]  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[Vendor] ADD  CONSTRAINT [DF_Vendor_Address1]  DEFAULT ('') FOR [Address1]
GO
ALTER TABLE [dbo].[Vendor] ADD  CONSTRAINT [DF_Vendor_Address2]  DEFAULT ('') FOR [Address2]
GO
ALTER TABLE [dbo].[Vendor] ADD  CONSTRAINT [DF_Vendor_City]  DEFAULT ('') FOR [City]
GO
ALTER TABLE [dbo].[Vendor] ADD  CONSTRAINT [DF_Vendor_State]  DEFAULT ('') FOR [State]
GO
ALTER TABLE [dbo].[Vendor] ADD  CONSTRAINT [DF_Vendor_Zip]  DEFAULT ('') FOR [Zip]
GO
ALTER TABLE [dbo].[Vendor] ADD  CONSTRAINT [DF_Vendor_WebSiteAddress]  DEFAULT ('') FOR [WebSiteAddress]
GO
ALTER TABLE [dbo].[Vendor] ADD  CONSTRAINT [DF_Vendor_ContactName]  DEFAULT ('') FOR [ContactName]
GO
ALTER TABLE [dbo].[Vendor] ADD  CONSTRAINT [DF_Vendor_ContactEmail]  DEFAULT ('') FOR [ContactEmail]
GO
ALTER TABLE [dbo].[Vendor] ADD  CONSTRAINT [DF_Vendor_Phone]  DEFAULT ('') FOR [Phone]
GO
ALTER TABLE [dbo].[Vendor] ADD  CONSTRAINT [DF_Vendor_Ranking]  DEFAULT ((0)) FOR [Ranking]
GO
ALTER TABLE [dbo].[Vendor] ADD  CONSTRAINT [DF_Vendor_RegularMarkup]  DEFAULT ((0)) FOR [RegularMarkup]
GO
ALTER TABLE [dbo].[Vendor] ADD  CONSTRAINT [DF_Vendor_SaleMarkup]  DEFAULT ((0)) FOR [SaleMarkup]
GO
ALTER TABLE [dbo].[Vendor] ADD  CONSTRAINT [DF_Vendor_VendorMessage]  DEFAULT ('') FOR [VendorMessage]
GO
ALTER TABLE [dbo].[Warehouse] ADD  CONSTRAINT [DF_Warehouse_WarehouseId]  DEFAULT (newsequentialid()) FOR [WarehouseId]
GO
ALTER TABLE [dbo].[Warehouse] ADD  CONSTRAINT [DF_Warehouse_Name]  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[Warehouse] ADD  CONSTRAINT [DF_Warehouse_Description]  DEFAULT ('') FOR [Description]
GO
ALTER TABLE [dbo].[Warehouse] ADD  CONSTRAINT [DF_Warehouse_Address1]  DEFAULT ('') FOR [Address1]
GO
ALTER TABLE [dbo].[Warehouse] ADD  CONSTRAINT [DF_Warehouse_Address2]  DEFAULT ('') FOR [Address2]
GO
ALTER TABLE [dbo].[Warehouse] ADD  CONSTRAINT [DF_Warehouse_City]  DEFAULT ('') FOR [City]
GO
ALTER TABLE [dbo].[Warehouse] ADD  CONSTRAINT [DF_Warehouse_State]  DEFAULT ('') FOR [State]
GO
ALTER TABLE [dbo].[Warehouse] ADD  CONSTRAINT [DF_Warehouse_Zip]  DEFAULT ('') FOR [Zip]
GO
ALTER TABLE [dbo].[Warehouse] ADD  CONSTRAINT [DF_Warehouse_ContactName]  DEFAULT ('') FOR [ContactName]
GO
ALTER TABLE [dbo].[Warehouse] ADD  CONSTRAINT [DF_Warehouse_Phone]  DEFAULT ('') FOR [Phone]
GO
ALTER TABLE [dbo].[Warehouse] ADD  CONSTRAINT [DF_Warehouse_ShipSite]  DEFAULT ((0)) FOR [ShipSite]
GO
ALTER TABLE [dbo].[WishList] ADD  CONSTRAINT [DF_WishList_WishListId]  DEFAULT (newsequentialid()) FOR [WishListId]
GO
ALTER TABLE [dbo].[WishList] ADD  CONSTRAINT [DF_WishList_Name]  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[WishListProduct] ADD  CONSTRAINT [DF_WishListProduct_WishListProductId]  DEFAULT (newsequentialid()) FOR [WishListProductId]
GO
ALTER TABLE [dbo].[WishListProduct] ADD  CONSTRAINT [DF_WishListProduct_QtyOrdered]  DEFAULT ((1)) FOR [QtyOrdered]
GO
ALTER TABLE [dbo].[WishListProduct] ADD  CONSTRAINT [DF_WishListProduct_UnitOfMeasure]  DEFAULT ('') FOR [UnitOfMeasure]
GO
ALTER TABLE [dbo].[aspnet_Membership]  WITH CHECK ADD  CONSTRAINT [FK__aspnet_Me__Appli__3C34F16F] FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[aspnet_Applications] ([ApplicationId])
GO
ALTER TABLE [dbo].[aspnet_Membership] CHECK CONSTRAINT [FK__aspnet_Me__Appli__3C34F16F]
GO
ALTER TABLE [dbo].[aspnet_Membership]  WITH CHECK ADD  CONSTRAINT [FK__aspnet_Me__UserI__3D2915A8] FOREIGN KEY([UserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
ALTER TABLE [dbo].[aspnet_Membership] CHECK CONSTRAINT [FK__aspnet_Me__UserI__3D2915A8]
GO
ALTER TABLE [dbo].[aspnet_Paths]  WITH CHECK ADD  CONSTRAINT [FK__aspnet_Pa__Appli__6DCC4D03] FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[aspnet_Applications] ([ApplicationId])
GO
ALTER TABLE [dbo].[aspnet_Paths] CHECK CONSTRAINT [FK__aspnet_Pa__Appli__6DCC4D03]
GO
ALTER TABLE [dbo].[aspnet_PersonalizationAllUsers]  WITH CHECK ADD  CONSTRAINT [FK__aspnet_Pe__PathI__73852659] FOREIGN KEY([PathId])
REFERENCES [dbo].[aspnet_Paths] ([PathId])
GO
ALTER TABLE [dbo].[aspnet_PersonalizationAllUsers] CHECK CONSTRAINT [FK__aspnet_Pe__PathI__73852659]
GO
ALTER TABLE [dbo].[aspnet_PersonalizationPerUser]  WITH CHECK ADD  CONSTRAINT [FK__aspnet_Pe__PathI__7755B73D] FOREIGN KEY([PathId])
REFERENCES [dbo].[aspnet_Paths] ([PathId])
GO
ALTER TABLE [dbo].[aspnet_PersonalizationPerUser] CHECK CONSTRAINT [FK__aspnet_Pe__PathI__7755B73D]
GO
ALTER TABLE [dbo].[aspnet_PersonalizationPerUser]  WITH CHECK ADD  CONSTRAINT [FK__aspnet_Pe__UserI__7849DB76] FOREIGN KEY([UserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
ALTER TABLE [dbo].[aspnet_PersonalizationPerUser] CHECK CONSTRAINT [FK__aspnet_Pe__UserI__7849DB76]
GO
ALTER TABLE [dbo].[aspnet_Profile]  WITH CHECK ADD  CONSTRAINT [FK__aspnet_Pr__UserI__51300E55] FOREIGN KEY([UserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
ALTER TABLE [dbo].[aspnet_Profile] CHECK CONSTRAINT [FK__aspnet_Pr__UserI__51300E55]
GO
ALTER TABLE [dbo].[aspnet_Roles]  WITH CHECK ADD  CONSTRAINT [FK__aspnet_Ro__Appli__5AB9788F] FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[aspnet_Applications] ([ApplicationId])
GO
ALTER TABLE [dbo].[aspnet_Roles] CHECK CONSTRAINT [FK__aspnet_Ro__Appli__5AB9788F]
GO
ALTER TABLE [dbo].[aspnet_Users]  WITH CHECK ADD  CONSTRAINT [FK__aspnet_Us__Appli__2BFE89A6] FOREIGN KEY([ApplicationId])
REFERENCES [dbo].[aspnet_Applications] ([ApplicationId])
GO
ALTER TABLE [dbo].[aspnet_Users] CHECK CONSTRAINT [FK__aspnet_Us__Appli__2BFE89A6]
GO
ALTER TABLE [dbo].[aspnet_UsersInRoles]  WITH CHECK ADD  CONSTRAINT [FK__aspnet_Us__RoleI__5F7E2DAC] FOREIGN KEY([RoleId])
REFERENCES [dbo].[aspnet_Roles] ([RoleId])
GO
ALTER TABLE [dbo].[aspnet_UsersInRoles] CHECK CONSTRAINT [FK__aspnet_Us__RoleI__5F7E2DAC]
GO
ALTER TABLE [dbo].[aspnet_UsersInRoles]  WITH CHECK ADD  CONSTRAINT [FK__aspnet_Us__UserI__5E8A0973] FOREIGN KEY([UserId])
REFERENCES [dbo].[aspnet_Users] ([UserId])
GO
ALTER TABLE [dbo].[aspnet_UsersInRoles] CHECK CONSTRAINT [FK__aspnet_Us__UserI__5E8A0973]
GO
ALTER TABLE [dbo].[BudgetCalendar]  WITH CHECK ADD  CONSTRAINT [FK_BudgetCalendar_Customer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([CustomerId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BudgetCalendar] CHECK CONSTRAINT [FK_BudgetCalendar_Customer]
GO
ALTER TABLE [dbo].[Carrier]  WITH CHECK ADD  CONSTRAINT [FK_Carrier_Carrier] FOREIGN KEY([BackUpCarrierId])
REFERENCES [dbo].[Carrier] ([CarrierId])
GO
ALTER TABLE [dbo].[Carrier] CHECK CONSTRAINT [FK_Carrier_Carrier]
GO
ALTER TABLE [dbo].[Carrier]  WITH CHECK ADD  CONSTRAINT [FK_Carrier_Currency] FOREIGN KEY([CurrencyId])
REFERENCES [dbo].[Currency] ([CurrencyId])
GO
ALTER TABLE [dbo].[Carrier] CHECK CONSTRAINT [FK_Carrier_Currency]
GO
ALTER TABLE [dbo].[CarrierPackage]  WITH CHECK ADD  CONSTRAINT [FK_CarrierPackage_Carrier] FOREIGN KEY([CarrierId])
REFERENCES [dbo].[Carrier] ([CarrierId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CarrierPackage] CHECK CONSTRAINT [FK_CarrierPackage_Carrier]
GO
ALTER TABLE [dbo].[CarrierZone]  WITH CHECK ADD  CONSTRAINT [FK_CarrierZone_Carrier] FOREIGN KEY([CarrierId])
REFERENCES [dbo].[Carrier] ([CarrierId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CarrierZone] CHECK CONSTRAINT [FK_CarrierZone_Carrier]
GO
ALTER TABLE [dbo].[CarrierZoneRate]  WITH CHECK ADD  CONSTRAINT [FK_CarrierZoneRate_CarrierZone] FOREIGN KEY([CarrierZoneId])
REFERENCES [dbo].[CarrierZone] ([CarrierZoneId])
GO
ALTER TABLE [dbo].[CarrierZoneRate] CHECK CONSTRAINT [FK_CarrierZoneRate_CarrierZone]
GO
ALTER TABLE [dbo].[CarrierZoneZipCodeRange]  WITH CHECK ADD  CONSTRAINT [FK_CarrierZoneZipCodeRange_CarrierZone] FOREIGN KEY([CarrierZoneId])
REFERENCES [dbo].[CarrierZone] ([CarrierZoneId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CarrierZoneZipCodeRange] CHECK CONSTRAINT [FK_CarrierZoneZipCodeRange_CarrierZone]
GO
ALTER TABLE [dbo].[Category]  WITH CHECK ADD  CONSTRAINT [FK_Category_DocumentManager] FOREIGN KEY([DocumentManagerId])
REFERENCES [dbo].[DocumentManager] ([DocumentManagerId])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Category] CHECK CONSTRAINT [FK_Category_DocumentManager]
GO
ALTER TABLE [dbo].[Category]  WITH CHECK ADD  CONSTRAINT [FK_Category_RuleManager] FOREIGN KEY([RuleManagerId])
REFERENCES [dbo].[RuleManager] ([RuleManagerId])
GO
ALTER TABLE [dbo].[Category] CHECK CONSTRAINT [FK_Category_RuleManager]
GO
ALTER TABLE [dbo].[Category]  WITH CHECK ADD  CONSTRAINT [FK_Category_WebSite] FOREIGN KEY([WebSiteId])
REFERENCES [dbo].[WebSite] ([WebSiteId])
GO
ALTER TABLE [dbo].[Category] CHECK CONSTRAINT [FK_Category_WebSite]
GO
ALTER TABLE [dbo].[CategoryFilterSection]  WITH CHECK ADD  CONSTRAINT [FK_CategoryFilterSection_Category] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([CategoryId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CategoryFilterSection] CHECK CONSTRAINT [FK_CategoryFilterSection_Category]
GO
ALTER TABLE [dbo].[CategoryFilterSection]  WITH CHECK ADD  CONSTRAINT [FK_CategoryFilterSection_FilterSection] FOREIGN KEY([FilterSectionId])
REFERENCES [dbo].[FilterSection] ([FilterSectionId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CategoryFilterSection] CHECK CONSTRAINT [FK_CategoryFilterSection_FilterSection]
GO
ALTER TABLE [dbo].[CategoryFilterValue]  WITH CHECK ADD  CONSTRAINT [FK_CategoryFilterValue_Category] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([CategoryId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CategoryFilterValue] CHECK CONSTRAINT [FK_CategoryFilterValue_Category]
GO
ALTER TABLE [dbo].[CategoryFilterValue]  WITH CHECK ADD  CONSTRAINT [FK_CategoryFilterValue_FilterValue] FOREIGN KEY([FilterValueId])
REFERENCES [dbo].[FilterValue] ([FilterValueId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CategoryFilterValue] CHECK CONSTRAINT [FK_CategoryFilterValue_FilterValue]
GO
ALTER TABLE [dbo].[CategoryProduct]  WITH CHECK ADD  CONSTRAINT [FK_CategoryProduct_Category] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([CategoryId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CategoryProduct] CHECK CONSTRAINT [FK_CategoryProduct_Category]
GO
ALTER TABLE [dbo].[CategoryProduct]  WITH CHECK ADD  CONSTRAINT [FK_CategoryProduct_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ProductId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CategoryProduct] CHECK CONSTRAINT [FK_CategoryProduct_Product]
GO
ALTER TABLE [dbo].[CategoryProductCrossSell]  WITH CHECK ADD  CONSTRAINT [FK_CategoryProductCrossSell_Category] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([CategoryId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CategoryProductCrossSell] CHECK CONSTRAINT [FK_CategoryProductCrossSell_Category]
GO
ALTER TABLE [dbo].[CategoryProductCrossSell]  WITH CHECK ADD  CONSTRAINT [FK_CategoryProductCrossSell_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ProductId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CategoryProductCrossSell] CHECK CONSTRAINT [FK_CategoryProductCrossSell_Product]
GO
ALTER TABLE [dbo].[CategoryProperty]  WITH CHECK ADD  CONSTRAINT [FK_CategoryProperty_Category] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([CategoryId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CategoryProperty] CHECK CONSTRAINT [FK_CategoryProperty_Category]
GO
ALTER TABLE [dbo].[CategorySpecification]  WITH CHECK ADD  CONSTRAINT [FK_CategorySpecification_Category] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([CategoryId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CategorySpecification] CHECK CONSTRAINT [FK_CategorySpecification_Category]
GO
ALTER TABLE [dbo].[CategorySpecification]  WITH CHECK ADD  CONSTRAINT [FK_CategorySpecification_Specification] FOREIGN KEY([SpecificationId])
REFERENCES [dbo].[Specification] ([SpecificationId])
GO
ALTER TABLE [dbo].[CategorySpecification] CHECK CONSTRAINT [FK_CategorySpecification_Specification]
GO
ALTER TABLE [dbo].[CategoryTaxExemption]  WITH CHECK ADD  CONSTRAINT [FK_CategoryTaxExemption_Category] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([CategoryId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CategoryTaxExemption] CHECK CONSTRAINT [FK_CategoryTaxExemption_Category]
GO
ALTER TABLE [dbo].[CategoryTaxExemption]  WITH CHECK ADD  CONSTRAINT [FK_CategoryTaxExemption_TaxExemption] FOREIGN KEY([TaxExemptionId])
REFERENCES [dbo].[TaxExemption] ([TaxExemptionId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CategoryTaxExemption] CHECK CONSTRAINT [FK_CategoryTaxExemption_TaxExemption]
GO
ALTER TABLE [dbo].[City]  WITH CHECK ADD  CONSTRAINT [FK_City_County] FOREIGN KEY([CountyId])
REFERENCES [dbo].[County] ([CountyId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[City] CHECK CONSTRAINT [FK_City_County]
GO
ALTER TABLE [dbo].[Company]  WITH CHECK ADD  CONSTRAINT [FK_Company_WebSite] FOREIGN KEY([WebSiteId])
REFERENCES [dbo].[WebSite] ([WebSiteId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Company] CHECK CONSTRAINT [FK_Company_WebSite]
GO
ALTER TABLE [dbo].[ConfigurationConditionFilter]  WITH CHECK ADD  CONSTRAINT [FK_ConfigurationConditionFilter_ConfigurationOptionCondition] FOREIGN KEY([ConfigurationOptionConditionId])
REFERENCES [dbo].[ConfigurationOptionCondition] ([ConfigurationOptionConditionId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ConfigurationConditionFilter] CHECK CONSTRAINT [FK_ConfigurationConditionFilter_ConfigurationOptionCondition]
GO
ALTER TABLE [dbo].[ConfigurationOptionCondition]  WITH CHECK ADD  CONSTRAINT [FK_ConfigurationOptionCondition_ConfigurationOption] FOREIGN KEY([ConfigurationOptionId])
REFERENCES [dbo].[ConfigurationOption] ([ConfigurationOptionId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ConfigurationOptionCondition] CHECK CONSTRAINT [FK_ConfigurationOptionCondition_ConfigurationOption]
GO
ALTER TABLE [dbo].[ConfigurationPage]  WITH CHECK ADD  CONSTRAINT [FK_ConfigurationPage_Configuration] FOREIGN KEY([ConfigurationId])
REFERENCES [dbo].[Configuration] ([ConfigurationId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ConfigurationPage] CHECK CONSTRAINT [FK_ConfigurationPage_Configuration]
GO
ALTER TABLE [dbo].[ConfigurationQueryResultField]  WITH CHECK ADD  CONSTRAINT [FK_ConfigurationQueryResultField_ConfigurationQueryResult] FOREIGN KEY([ConfigurationQueryResultId])
REFERENCES [dbo].[ConfigurationQueryResult] ([ConfigurationQueryResultId])
GO
ALTER TABLE [dbo].[ConfigurationQueryResultField] CHECK CONSTRAINT [FK_ConfigurationQueryResultField_ConfigurationQueryResult]
GO
ALTER TABLE [dbo].[ConfigurationQueryResultValue]  WITH CHECK ADD  CONSTRAINT [FK_ConfigurationQueryResultValue_ConfigurationQueryResult] FOREIGN KEY([ConfigurationQueryResultId])
REFERENCES [dbo].[ConfigurationQueryResult] ([ConfigurationQueryResultId])
GO
ALTER TABLE [dbo].[ConfigurationQueryResultValue] CHECK CONSTRAINT [FK_ConfigurationQueryResultValue_ConfigurationQueryResult]
GO
ALTER TABLE [dbo].[Content]  WITH CHECK ADD  CONSTRAINT [FK_Content_ApprovedBy] FOREIGN KEY([ApprovedById])
REFERENCES [dbo].[UserProfile] ([UserProfileId])
GO
ALTER TABLE [dbo].[Content] CHECK CONSTRAINT [FK_Content_ApprovedBy]
GO
ALTER TABLE [dbo].[Content]  WITH CHECK ADD  CONSTRAINT [FK_Content_ContentManager] FOREIGN KEY([ContentManagerId])
REFERENCES [dbo].[ContentManager] ([ContentManagerId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Content] CHECK CONSTRAINT [FK_Content_ContentManager]
GO
ALTER TABLE [dbo].[Content]  WITH CHECK ADD  CONSTRAINT [FK_Content_CreatedBy] FOREIGN KEY([CreatedById])
REFERENCES [dbo].[UserProfile] ([UserProfileId])
GO
ALTER TABLE [dbo].[Content] CHECK CONSTRAINT [FK_Content_CreatedBy]
GO
ALTER TABLE [dbo].[Content]  WITH CHECK ADD  CONSTRAINT [FK_Content_Persona] FOREIGN KEY([PersonaId])
REFERENCES [dbo].[Persona] ([PersonaId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Content] CHECK CONSTRAINT [FK_Content_Persona]
GO
ALTER TABLE [dbo].[ContentItem]  WITH CHECK ADD  CONSTRAINT [FK_ContentItem_UserProfile_ApprovedById] FOREIGN KEY([ApprovedById])
REFERENCES [dbo].[UserProfile] ([UserProfileId])
GO
ALTER TABLE [dbo].[ContentItem] CHECK CONSTRAINT [FK_ContentItem_UserProfile_ApprovedById]
GO
ALTER TABLE [dbo].[ContentItem]  WITH CHECK ADD  CONSTRAINT [FK_ContentItem_UserProfile_CreatedById] FOREIGN KEY([CreatedById])
REFERENCES [dbo].[UserProfile] ([UserProfileId])
GO
ALTER TABLE [dbo].[ContentItem] CHECK CONSTRAINT [FK_ContentItem_UserProfile_CreatedById]
GO
ALTER TABLE [dbo].[ContentItem]  WITH CHECK ADD  CONSTRAINT [FK_ContentItem_WebSite] FOREIGN KEY([WebSiteId])
REFERENCES [dbo].[WebSite] ([WebSiteId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ContentItem] CHECK CONSTRAINT [FK_ContentItem_WebSite]
GO
ALTER TABLE [dbo].[ContentItemField]  WITH CHECK ADD  CONSTRAINT [FK_ContentItemField_Language] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[Language] ([LanguageId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ContentItemField] CHECK CONSTRAINT [FK_ContentItemField_Language]
GO
ALTER TABLE [dbo].[ContentItemField]  WITH CHECK ADD  CONSTRAINT [FK_ContentItemField_Persona] FOREIGN KEY([PersonaId])
REFERENCES [dbo].[Persona] ([PersonaId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ContentItemField] CHECK CONSTRAINT [FK_ContentItemField_Persona]
GO
ALTER TABLE [dbo].[ContentItemField]  WITH CHECK ADD  CONSTRAINT [FK_ContentItemField_UserProfile] FOREIGN KEY([CreatedById])
REFERENCES [dbo].[UserProfile] ([UserProfileId])
GO
ALTER TABLE [dbo].[ContentItemField] CHECK CONSTRAINT [FK_ContentItemField_UserProfile]
GO
ALTER TABLE [dbo].[ContentItemField]  WITH CHECK ADD  CONSTRAINT [FK_ContentItemField_UserProfile1] FOREIGN KEY([ApprovedById])
REFERENCES [dbo].[UserProfile] ([UserProfileId])
GO
ALTER TABLE [dbo].[ContentItemField] CHECK CONSTRAINT [FK_ContentItemField_UserProfile1]
GO
ALTER TABLE [dbo].[ContentPageState]  WITH CHECK ADD  CONSTRAINT [FK_ContentPageState_Language] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[Language] ([LanguageId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ContentPageState] CHECK CONSTRAINT [FK_ContentPageState_Language]
GO
ALTER TABLE [dbo].[ContentPageState]  WITH CHECK ADD  CONSTRAINT [FK_ContentPageState_Persona] FOREIGN KEY([PersonaId])
REFERENCES [dbo].[Persona] ([PersonaId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ContentPageState] CHECK CONSTRAINT [FK_ContentPageState_Persona]
GO
ALTER TABLE [dbo].[ContentPageState]  WITH CHECK ADD  CONSTRAINT [FK_ContentPageState_WebSite] FOREIGN KEY([WebsiteId])
REFERENCES [dbo].[WebSite] ([WebSiteId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ContentPageState] CHECK CONSTRAINT [FK_ContentPageState_WebSite]
GO
ALTER TABLE [dbo].[County]  WITH CHECK ADD  CONSTRAINT [FK_County_State] FOREIGN KEY([StateId])
REFERENCES [dbo].[State] ([StateId])
GO
ALTER TABLE [dbo].[County] CHECK CONSTRAINT [FK_County_State]
GO
ALTER TABLE [dbo].[CreditCardTransaction]  WITH CHECK ADD  CONSTRAINT [FK_CreditCardTransaction_Currency] FOREIGN KEY([CurrencyId])
REFERENCES [dbo].[Currency] ([CurrencyId])
GO
ALTER TABLE [dbo].[CreditCardTransaction] CHECK CONSTRAINT [FK_CreditCardTransaction_Currency]
GO
ALTER TABLE [dbo].[CreditCardTransaction]  WITH CHECK ADD  CONSTRAINT [FK_CreditCardTransaction_CustomerOrder] FOREIGN KEY([CustomerOrderId])
REFERENCES [dbo].[CustomerOrder] ([CustomerOrderId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CreditCardTransaction] CHECK CONSTRAINT [FK_CreditCardTransaction_CustomerOrder]
GO
ALTER TABLE [dbo].[CurrencyRate]  WITH CHECK ADD  CONSTRAINT [FK_CurrencyRate_Currency] FOREIGN KEY([CurrencyId])
REFERENCES [dbo].[Currency] ([CurrencyId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CurrencyRate] CHECK CONSTRAINT [FK_CurrencyRate_Currency]
GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Company1] FOREIGN KEY([CompanyId])
REFERENCES [dbo].[Company] ([CompanyId])
GO
ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [FK_Customer_Company1]
GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Country] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Country] ([CountryId])
GO
ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [FK_Customer_Country]
GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Currency] FOREIGN KEY([CurrencyId])
REFERENCES [dbo].[Currency] ([CurrencyId])
GO
ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [FK_Customer_Currency]
GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Salesman] FOREIGN KEY([PrimarySalesmanId])
REFERENCES [dbo].[Salesman] ([SalesmanId])
GO
ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [FK_Customer_Salesman]
GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_Customer_State] FOREIGN KEY([StateId])
REFERENCES [dbo].[State] ([StateId])
GO
ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [FK_Customer_State]
GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_PricingCustomer_Customer] FOREIGN KEY([PricingCustomerId])
REFERENCES [dbo].[Customer] ([CustomerId])
GO
ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [FK_PricingCustomer_Customer]
GO
ALTER TABLE [dbo].[CustomerBudget]  WITH CHECK ADD  CONSTRAINT [FK_CustomerBudget_Customer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([CustomerId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CustomerBudget] CHECK CONSTRAINT [FK_CustomerBudget_Customer]
GO
ALTER TABLE [dbo].[CustomerBudget]  WITH CHECK ADD  CONSTRAINT [FK_CustomerBudget_ShipToCustomer] FOREIGN KEY([ShipToCustomerId])
REFERENCES [dbo].[Customer] ([CustomerId])
GO
ALTER TABLE [dbo].[CustomerBudget] CHECK CONSTRAINT [FK_CustomerBudget_ShipToCustomer]
GO
ALTER TABLE [dbo].[CustomerBudget]  WITH CHECK ADD  CONSTRAINT [FK_CustomerBudget_UserProfile] FOREIGN KEY([UserProfileId])
REFERENCES [dbo].[UserProfile] ([UserProfileId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CustomerBudget] CHECK CONSTRAINT [FK_CustomerBudget_UserProfile]
GO
ALTER TABLE [dbo].[CustomerCarrier]  WITH CHECK ADD  CONSTRAINT [FK_CustomerCarrier_Carrier] FOREIGN KEY([CarrierId])
REFERENCES [dbo].[Carrier] ([CarrierId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CustomerCarrier] CHECK CONSTRAINT [FK_CustomerCarrier_Carrier]
GO
ALTER TABLE [dbo].[CustomerCarrier]  WITH CHECK ADD  CONSTRAINT [FK_CustomerCarrier_Customer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([CustomerId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CustomerCarrier] CHECK CONSTRAINT [FK_CustomerCarrier_Customer]
GO
ALTER TABLE [dbo].[CustomerCostCode]  WITH CHECK ADD  CONSTRAINT [FK_CustomerCostCode_Customer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([CustomerId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CustomerCostCode] CHECK CONSTRAINT [FK_CustomerCostCode_Customer]
GO
ALTER TABLE [dbo].[CustomerDiscount]  WITH CHECK ADD  CONSTRAINT [FK_CustomerDiscount_Customer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([CustomerId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CustomerDiscount] CHECK CONSTRAINT [FK_CustomerDiscount_Customer]
GO
ALTER TABLE [dbo].[CustomerDiscount]  WITH CHECK ADD  CONSTRAINT [FK_CustomerDiscount_WebSite] FOREIGN KEY([WebSiteId])
REFERENCES [dbo].[WebSite] ([WebSiteId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CustomerDiscount] CHECK CONSTRAINT [FK_CustomerDiscount_WebSite]
GO
ALTER TABLE [dbo].[CustomerOrder]  WITH CHECK ADD  CONSTRAINT [FK_CustomerOrder_Affiliate] FOREIGN KEY([AffiliateId])
REFERENCES [dbo].[Affiliate] ([AffiliateId])
GO
ALTER TABLE [dbo].[CustomerOrder] CHECK CONSTRAINT [FK_CustomerOrder_Affiliate]
GO
ALTER TABLE [dbo].[CustomerOrder]  WITH CHECK ADD  CONSTRAINT [FK_CustomerOrder_ApproverUserProfileId] FOREIGN KEY([ApproverUserProfileId])
REFERENCES [dbo].[UserProfile] ([UserProfileId])
GO
ALTER TABLE [dbo].[CustomerOrder] CHECK CONSTRAINT [FK_CustomerOrder_ApproverUserProfileId]
GO
ALTER TABLE [dbo].[CustomerOrder]  WITH CHECK ADD  CONSTRAINT [FK_CustomerOrder_Currency] FOREIGN KEY([CurrencyId])
REFERENCES [dbo].[Currency] ([CurrencyId])
GO
ALTER TABLE [dbo].[CustomerOrder] CHECK CONSTRAINT [FK_CustomerOrder_Currency]
GO
ALTER TABLE [dbo].[CustomerOrder]  WITH CHECK ADD  CONSTRAINT [FK_CustomerOrder_Customer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([CustomerId])
GO
ALTER TABLE [dbo].[CustomerOrder] CHECK CONSTRAINT [FK_CustomerOrder_Customer]
GO
ALTER TABLE [dbo].[CustomerOrder]  WITH CHECK ADD  CONSTRAINT [FK_CustomerOrder_InitiatedByUserProfileId] FOREIGN KEY([InitiatedByUserProfileId])
REFERENCES [dbo].[UserProfile] ([UserProfileId])
GO
ALTER TABLE [dbo].[CustomerOrder] CHECK CONSTRAINT [FK_CustomerOrder_InitiatedByUserProfileId]
GO
ALTER TABLE [dbo].[CustomerOrder]  WITH CHECK ADD  CONSTRAINT [FK_CustomerOrder_QuotedBy] FOREIGN KEY([QuotedByUserProfileId])
REFERENCES [dbo].[UserProfile] ([UserProfileId])
GO
ALTER TABLE [dbo].[CustomerOrder] CHECK CONSTRAINT [FK_CustomerOrder_QuotedBy]
GO
ALTER TABLE [dbo].[CustomerOrder]  WITH CHECK ADD  CONSTRAINT [FK_CustomerOrder_Salesman] FOREIGN KEY([PrimarySalesmanId])
REFERENCES [dbo].[Salesman] ([SalesmanId])
GO
ALTER TABLE [dbo].[CustomerOrder] CHECK CONSTRAINT [FK_CustomerOrder_Salesman]
GO
ALTER TABLE [dbo].[CustomerOrder]  WITH CHECK ADD  CONSTRAINT [FK_CustomerOrder_ShipTo] FOREIGN KEY([ShipToId])
REFERENCES [dbo].[Customer] ([CustomerId])
GO
ALTER TABLE [dbo].[CustomerOrder] CHECK CONSTRAINT [FK_CustomerOrder_ShipTo]
GO
ALTER TABLE [dbo].[CustomerOrder]  WITH CHECK ADD  CONSTRAINT [FK_CustomerOrder_ShipVia] FOREIGN KEY([ShipViaId])
REFERENCES [dbo].[ShipVia] ([ShipViaId])
GO
ALTER TABLE [dbo].[CustomerOrder] CHECK CONSTRAINT [FK_CustomerOrder_ShipVia]
GO
ALTER TABLE [dbo].[CustomerOrder]  WITH CHECK ADD  CONSTRAINT [FK_CustomerOrder_Subscription] FOREIGN KEY([SubscriptionId])
REFERENCES [dbo].[Subscription] ([SubscriptionId])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[CustomerOrder] CHECK CONSTRAINT [FK_CustomerOrder_Subscription]
GO
ALTER TABLE [dbo].[CustomerOrder]  WITH CHECK ADD  CONSTRAINT [FK_CustomerOrder_WebSite] FOREIGN KEY([WebSiteId])
REFERENCES [dbo].[WebSite] ([WebSiteId])
GO
ALTER TABLE [dbo].[CustomerOrder] CHECK CONSTRAINT [FK_CustomerOrder_WebSite]
GO
ALTER TABLE [dbo].[CustomerOrderGiftCard]  WITH CHECK ADD  CONSTRAINT [FK_CustomerOrderGiftCard_CustomerOrder] FOREIGN KEY([CustomerOrderId])
REFERENCES [dbo].[CustomerOrder] ([CustomerOrderId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CustomerOrderGiftCard] CHECK CONSTRAINT [FK_CustomerOrderGiftCard_CustomerOrder]
GO
ALTER TABLE [dbo].[CustomerOrderGiftCard]  WITH CHECK ADD  CONSTRAINT [FK_CustomerOrderGiftCard_GiftCard] FOREIGN KEY([GiftCardId])
REFERENCES [dbo].[GiftCard] ([GiftCardId])
GO
ALTER TABLE [dbo].[CustomerOrderGiftCard] CHECK CONSTRAINT [FK_CustomerOrderGiftCard_GiftCard]
GO
ALTER TABLE [dbo].[CustomerOrderPromotion]  WITH CHECK ADD  CONSTRAINT [FK_CustomerOrderPromotion_CustomerOrderId] FOREIGN KEY([CustomerOrderId])
REFERENCES [dbo].[CustomerOrder] ([CustomerOrderId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CustomerOrderPromotion] CHECK CONSTRAINT [FK_CustomerOrderPromotion_CustomerOrderId]
GO
ALTER TABLE [dbo].[CustomerOrderPromotion]  WITH CHECK ADD  CONSTRAINT [FK_CustomerOrderPromotion_PromotionId] FOREIGN KEY([PromotionId])
REFERENCES [dbo].[Promotion] ([PromotionId])
GO
ALTER TABLE [dbo].[CustomerOrderPromotion] CHECK CONSTRAINT [FK_CustomerOrderPromotion_PromotionId]
GO
ALTER TABLE [dbo].[CustomerOrderProperty]  WITH CHECK ADD  CONSTRAINT [FK_DCustomerOrderProperty_CustomerOrder] FOREIGN KEY([CustomerOrderId])
REFERENCES [dbo].[CustomerOrder] ([CustomerOrderId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CustomerOrderProperty] CHECK CONSTRAINT [FK_DCustomerOrderProperty_CustomerOrder]
GO
ALTER TABLE [dbo].[CustomerProduct]  WITH CHECK ADD  CONSTRAINT [FK_CustomerProduct_Customer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([CustomerId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CustomerProduct] CHECK CONSTRAINT [FK_CustomerProduct_Customer]
GO
ALTER TABLE [dbo].[CustomerProduct]  WITH CHECK ADD  CONSTRAINT [FK_CustomerProduct_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ProductId])
GO
ALTER TABLE [dbo].[CustomerProduct] CHECK CONSTRAINT [FK_CustomerProduct_Product]
GO
ALTER TABLE [dbo].[CustomerProductPrice]  WITH CHECK ADD  CONSTRAINT [FK_CustomerProductPrice_Customer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([CustomerId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CustomerProductPrice] CHECK CONSTRAINT [FK_CustomerProductPrice_Customer]
GO
ALTER TABLE [dbo].[CustomerProductPrice]  WITH CHECK ADD  CONSTRAINT [FK_CustomerProductPrice_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ProductId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CustomerProductPrice] CHECK CONSTRAINT [FK_CustomerProductPrice_Product]
GO
ALTER TABLE [dbo].[CustomerProductSet]  WITH CHECK ADD  CONSTRAINT [FK_CustomerProductSet_Customer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([CustomerId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CustomerProductSet] CHECK CONSTRAINT [FK_CustomerProductSet_Customer]
GO
ALTER TABLE [dbo].[CustomerProductSetProduct]  WITH CHECK ADD  CONSTRAINT [FK_CustomerProductSetProduct_CustomerProductSet] FOREIGN KEY([CustomerProductSetId])
REFERENCES [dbo].[CustomerProductSet] ([CustomerProductSetId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CustomerProductSetProduct] CHECK CONSTRAINT [FK_CustomerProductSetProduct_CustomerProductSet]
GO
ALTER TABLE [dbo].[CustomerProductSetProduct]  WITH CHECK ADD  CONSTRAINT [FK_CustomerProductSetProduct_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ProductId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CustomerProductSetProduct] CHECK CONSTRAINT [FK_CustomerProductSetProduct_Product]
GO
ALTER TABLE [dbo].[CustomerProperty]  WITH CHECK ADD  CONSTRAINT [FK_CustomerProperty_Customer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([CustomerId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CustomerProperty] CHECK CONSTRAINT [FK_CustomerProperty_Customer]
GO
ALTER TABLE [dbo].[CustomerUserProfile]  WITH CHECK ADD  CONSTRAINT [FK_CustomerUserProfile_CustomerId] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([CustomerId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CustomerUserProfile] CHECK CONSTRAINT [FK_CustomerUserProfile_CustomerId]
GO
ALTER TABLE [dbo].[CustomerUserProfile]  WITH CHECK ADD  CONSTRAINT [FK_CustomerUserProfile_UserProfileId] FOREIGN KEY([UserProfileId])
REFERENCES [dbo].[UserProfile] ([UserProfileId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CustomerUserProfile] CHECK CONSTRAINT [FK_CustomerUserProfile_UserProfileId]
GO
ALTER TABLE [dbo].[DashboardPanelPosition]  WITH CHECK ADD  CONSTRAINT [FK_DashboardPanelPosition_UserProfile] FOREIGN KEY([UserProfileId])
REFERENCES [dbo].[UserProfile] ([UserProfileId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DashboardPanelPosition] CHECK CONSTRAINT [FK_DashboardPanelPosition_UserProfile]
GO
ALTER TABLE [dbo].[DealerCategory]  WITH CHECK ADD  CONSTRAINT [FK_DealerCategory_Category] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([CategoryId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DealerCategory] CHECK CONSTRAINT [FK_DealerCategory_Category]
GO
ALTER TABLE [dbo].[DealerCategory]  WITH CHECK ADD  CONSTRAINT [FK_DealerCategory_Dealer] FOREIGN KEY([DealerId])
REFERENCES [dbo].[Dealer] ([DealerId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DealerCategory] CHECK CONSTRAINT [FK_DealerCategory_Dealer]
GO
ALTER TABLE [dbo].[DealerProduct]  WITH CHECK ADD  CONSTRAINT [FK_DealerProduct_Dealer] FOREIGN KEY([DealerId])
REFERENCES [dbo].[Dealer] ([DealerId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DealerProduct] CHECK CONSTRAINT [FK_DealerProduct_Dealer]
GO
ALTER TABLE [dbo].[DealerProduct]  WITH CHECK ADD  CONSTRAINT [FK_DealerProduct_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ProductId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DealerProduct] CHECK CONSTRAINT [FK_DealerProduct_Product]
GO
ALTER TABLE [dbo].[DealerProperty]  WITH CHECK ADD  CONSTRAINT [FK_DealerProperty_Dealer] FOREIGN KEY([DealerId])
REFERENCES [dbo].[Dealer] ([DealerId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DealerProperty] CHECK CONSTRAINT [FK_DealerProperty_Dealer]
GO
ALTER TABLE [dbo].[DictionaryAttribute]  WITH CHECK ADD  CONSTRAINT [FK_DictionaryAttribute_ApplicationDictionary] FOREIGN KEY([ApplicationDictionaryId])
REFERENCES [dbo].[ApplicationDictionary] ([ApplicationDictionaryId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DictionaryAttribute] CHECK CONSTRAINT [FK_DictionaryAttribute_ApplicationDictionary]
GO
ALTER TABLE [dbo].[DictionaryLabel]  WITH CHECK ADD  CONSTRAINT [FK_DictionaryLabel_ApplicationDictionary] FOREIGN KEY([ApplicationDictionaryId])
REFERENCES [dbo].[ApplicationDictionary] ([ApplicationDictionaryId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DictionaryLabel] CHECK CONSTRAINT [FK_DictionaryLabel_ApplicationDictionary]
GO
ALTER TABLE [dbo].[Document]  WITH CHECK ADD  CONSTRAINT [FK_Document_DocumentManager] FOREIGN KEY([DocumentManagerId])
REFERENCES [dbo].[DocumentManager] ([DocumentManagerId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Document] CHECK CONSTRAINT [FK_Document_DocumentManager]
GO
ALTER TABLE [dbo].[EmailList]  WITH CHECK ADD  CONSTRAINT [FK_EmailList_EmailTemplate] FOREIGN KEY([EmailTemplateId])
REFERENCES [dbo].[EmailTemplate] ([EmailTemplateID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EmailList] CHECK CONSTRAINT [FK_EmailList_EmailTemplate]
GO
ALTER TABLE [dbo].[EmailMessageAddress]  WITH CHECK ADD  CONSTRAINT [FK_EmailMessageAddress_EmailMessage] FOREIGN KEY([EmailMessageId])
REFERENCES [dbo].[EmailMessage] ([EmailMessageId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EmailMessageAddress] CHECK CONSTRAINT [FK_EmailMessageAddress_EmailMessage]
GO
ALTER TABLE [dbo].[EmailMessageDeliveryAttempt]  WITH CHECK ADD  CONSTRAINT [FK_EmailMessageDeliveryAttempt_EmailMessage] FOREIGN KEY([EmailMessageId])
REFERENCES [dbo].[EmailMessage] ([EmailMessageId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EmailMessageDeliveryAttempt] CHECK CONSTRAINT [FK_EmailMessageDeliveryAttempt_EmailMessage]
GO
ALTER TABLE [dbo].[EmailSubscriberEmailList]  WITH CHECK ADD  CONSTRAINT [FK_EmailSubscriberEmailList_EmailList] FOREIGN KEY([EmailListId])
REFERENCES [dbo].[EmailList] ([EmailListId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EmailSubscriberEmailList] CHECK CONSTRAINT [FK_EmailSubscriberEmailList_EmailList]
GO
ALTER TABLE [dbo].[EmailSubscriberEmailList]  WITH CHECK ADD  CONSTRAINT [FK_EmailSubscriberEmailList_EmailSubscriber] FOREIGN KEY([EmailSubscriberId])
REFERENCES [dbo].[EmailSubscriber] ([EmailSubscriberId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EmailSubscriberEmailList] CHECK CONSTRAINT [FK_EmailSubscriberEmailList_EmailSubscriber]
GO
ALTER TABLE [dbo].[EmailTemplate]  WITH CHECK ADD  CONSTRAINT [FK_EmailTemplate_ContentManager] FOREIGN KEY([ContentManagerId])
REFERENCES [dbo].[ContentManager] ([ContentManagerId])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[EmailTemplate] CHECK CONSTRAINT [FK_EmailTemplate_ContentManager]
GO
ALTER TABLE [dbo].[FilterValue]  WITH CHECK ADD  CONSTRAINT [FK_FilterValue_FilterSection] FOREIGN KEY([FilterSectionId])
REFERENCES [dbo].[FilterSection] ([FilterSectionId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FilterValue] CHECK CONSTRAINT [FK_FilterValue_FilterSection]
GO
ALTER TABLE [dbo].[GiftCard]  WITH CHECK ADD  CONSTRAINT [FK_GiftCard_Currency] FOREIGN KEY([CurrencyId])
REFERENCES [dbo].[Currency] ([CurrencyId])
GO
ALTER TABLE [dbo].[GiftCard] CHECK CONSTRAINT [FK_GiftCard_Currency]
GO
ALTER TABLE [dbo].[GiftCard]  WITH CHECK ADD  CONSTRAINT [FK_GiftCard_OrderLine] FOREIGN KEY([OrderLineId])
REFERENCES [dbo].[OrderLine] ([OrderLineId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[GiftCard] CHECK CONSTRAINT [FK_GiftCard_OrderLine]
GO
ALTER TABLE [dbo].[GiftCardTransaction]  WITH CHECK ADD  CONSTRAINT [FK_GiftCardTransaction_GiftCard] FOREIGN KEY([GiftCardId])
REFERENCES [dbo].[GiftCard] ([GiftCardId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[GiftCardTransaction] CHECK CONSTRAINT [FK_GiftCardTransaction_GiftCard]
GO
ALTER TABLE [dbo].[IntegrationJob]  WITH CHECK ADD  CONSTRAINT [FK_IntegrationJob_IntegrationJobDefinition] FOREIGN KEY([IntegrationJobDefinitionId])
REFERENCES [dbo].[IntegrationJobDefinition] ([IntegrationJobDefinitionId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[IntegrationJob] CHECK CONSTRAINT [FK_IntegrationJob_IntegrationJobDefinition]
GO
ALTER TABLE [dbo].[IntegrationJobDefinition]  WITH CHECK ADD  CONSTRAINT [FK_IntegrationJobDefinition_EmailTemplate] FOREIGN KEY([EmailTemplateId])
REFERENCES [dbo].[EmailTemplate] ([EmailTemplateID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[IntegrationJobDefinition] CHECK CONSTRAINT [FK_IntegrationJobDefinition_EmailTemplate]
GO
ALTER TABLE [dbo].[IntegrationJobDefinition]  WITH CHECK ADD  CONSTRAINT [FK_IntegrationJobDefinition_IntegrationConnection] FOREIGN KEY([IntegrationConnectionId])
REFERENCES [dbo].[IntegrationConnection] ([IntegrationConnectionId])
GO
ALTER TABLE [dbo].[IntegrationJobDefinition] CHECK CONSTRAINT [FK_IntegrationJobDefinition_IntegrationConnection]
GO
ALTER TABLE [dbo].[IntegrationJobDefinition]  WITH CHECK ADD  CONSTRAINT [FK_IntegrationJobDefinition_IntegrationJobDefinition] FOREIGN KEY([LinkedJobId])
REFERENCES [dbo].[IntegrationJobDefinition] ([IntegrationJobDefinitionId])
GO
ALTER TABLE [dbo].[IntegrationJobDefinition] CHECK CONSTRAINT [FK_IntegrationJobDefinition_IntegrationJobDefinition]
GO
ALTER TABLE [dbo].[IntegrationJobDefinitionPostprocessorParameter]  WITH CHECK ADD  CONSTRAINT [FK_IntegrationJobDefinitionPostprocessorParameter_IntegrationJobDefinition] FOREIGN KEY([IntegrationJobDefinitionId])
REFERENCES [dbo].[IntegrationJobDefinition] ([IntegrationJobDefinitionId])
GO
ALTER TABLE [dbo].[IntegrationJobDefinitionPostprocessorParameter] CHECK CONSTRAINT [FK_IntegrationJobDefinitionPostprocessorParameter_IntegrationJobDefinition]
GO
ALTER TABLE [dbo].[IntegrationJobDefinitionStep]  WITH CHECK ADD  CONSTRAINT [FK_IntegrationJobDefinitionStep_IntegrationJobDefinition] FOREIGN KEY([IntegrationJobDefinitionId])
REFERENCES [dbo].[IntegrationJobDefinition] ([IntegrationJobDefinitionId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[IntegrationJobDefinitionStep] CHECK CONSTRAINT [FK_IntegrationJobDefinitionStep_IntegrationJobDefinition]
GO
ALTER TABLE [dbo].[IntegrationJobDefinitionStepFieldMap]  WITH CHECK ADD  CONSTRAINT [FK_IntegrationJobDefinitionStepFieldMap_IntegrationJobDefinitionStep] FOREIGN KEY([IntegrationJobDefinitionStepId])
REFERENCES [dbo].[IntegrationJobDefinitionStep] ([IntegrationJobDefinitionStepId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[IntegrationJobDefinitionStepFieldMap] CHECK CONSTRAINT [FK_IntegrationJobDefinitionStepFieldMap_IntegrationJobDefinitionStep]
GO
ALTER TABLE [dbo].[IntegrationJobDefinitionStepParameter]  WITH CHECK ADD  CONSTRAINT [FK_IntegrationJobDefinitionStepParameter_IntegrationJobDefinitionStep] FOREIGN KEY([IntegrationJobDefinitionStepId])
REFERENCES [dbo].[IntegrationJobDefinitionStep] ([IntegrationJobDefinitionStepId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[IntegrationJobDefinitionStepParameter] CHECK CONSTRAINT [FK_IntegrationJobDefinitionStepParameter_IntegrationJobDefinitionStep]
GO
ALTER TABLE [dbo].[IntegrationJobLog]  WITH CHECK ADD  CONSTRAINT [FK_IntegrationJobLog_IntegrationJob] FOREIGN KEY([IntegrationJobId])
REFERENCES [dbo].[IntegrationJob] ([IntegrationJobId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[IntegrationJobLog] CHECK CONSTRAINT [FK_IntegrationJobLog_IntegrationJob]
GO
ALTER TABLE [dbo].[IntegrationJobParameter]  WITH CHECK ADD  CONSTRAINT [FK_IntegrationJobParameter_IntegrationJob] FOREIGN KEY([IntegrationJobId])
REFERENCES [dbo].[IntegrationJob] ([IntegrationJobId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[IntegrationJobParameter] CHECK CONSTRAINT [FK_IntegrationJobParameter_IntegrationJob]
GO
ALTER TABLE [dbo].[IntegrationJobParameter]  WITH CHECK ADD  CONSTRAINT [FK_IntegrationJobParameter_IntegrationJobDefinitionStepParameter] FOREIGN KEY([IntegrationJobDefinitionStepParameterId])
REFERENCES [dbo].[IntegrationJobDefinitionStepParameter] ([IntegrationJobDefinitionStepParameterId])
GO
ALTER TABLE [dbo].[IntegrationJobParameter] CHECK CONSTRAINT [FK_IntegrationJobParameter_IntegrationJobDefinitionStepParameter]
GO
ALTER TABLE [dbo].[InventoryTransaction]  WITH CHECK ADD  CONSTRAINT [FK_InventoryTransaction_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ProductId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[InventoryTransaction] CHECK CONSTRAINT [FK_InventoryTransaction_Product]
GO
ALTER TABLE [dbo].[Invoice]  WITH CHECK ADD  CONSTRAINT [FK_Invoice_Customer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([CustomerId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Invoice] CHECK CONSTRAINT [FK_Invoice_Customer]
GO
ALTER TABLE [dbo].[Invoice]  WITH CHECK ADD  CONSTRAINT [FK_Invoice_Customer1] FOREIGN KEY([ShipToId])
REFERENCES [dbo].[Customer] ([CustomerId])
GO
ALTER TABLE [dbo].[Invoice] CHECK CONSTRAINT [FK_Invoice_Customer1]
GO
ALTER TABLE [dbo].[InvoiceHistoryLine]  WITH CHECK ADD  CONSTRAINT [FK_InvoiceHistoryLine_InvoiceHistory] FOREIGN KEY([InvoiceHistoryId])
REFERENCES [dbo].[InvoiceHistory] ([InvoiceHistoryId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[InvoiceHistoryLine] CHECK CONSTRAINT [FK_InvoiceHistoryLine_InvoiceHistory]
GO
ALTER TABLE [dbo].[InvoiceLine]  WITH CHECK ADD  CONSTRAINT [FK_InvoiceLine_Invoice] FOREIGN KEY([InvoiceId])
REFERENCES [dbo].[Invoice] ([InvoiceId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[InvoiceLine] CHECK CONSTRAINT [FK_InvoiceLine_Invoice]
GO
ALTER TABLE [dbo].[LocalTaxRateTaxExemption]  WITH CHECK ADD  CONSTRAINT [FK_LocalTaxRateTaxExemption_LocalTaxRate] FOREIGN KEY([LocalTaxRateId])
REFERENCES [dbo].[LocalTaxRate] ([LocalTaxRateId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[LocalTaxRateTaxExemption] CHECK CONSTRAINT [FK_LocalTaxRateTaxExemption_LocalTaxRate]
GO
ALTER TABLE [dbo].[LocalTaxRateTaxExemption]  WITH CHECK ADD  CONSTRAINT [FK_LocalTaxRateTaxExemption_TaxExemption] FOREIGN KEY([TaxExemptionId])
REFERENCES [dbo].[TaxExemption] ([TaxExemptionId])
GO
ALTER TABLE [dbo].[LocalTaxRateTaxExemption] CHECK CONSTRAINT [FK_LocalTaxRateTaxExemption_TaxExemption]
GO
ALTER TABLE [dbo].[Menu]  WITH CHECK ADD  CONSTRAINT [FK_Menu_Menu] FOREIGN KEY([ParentId])
REFERENCES [dbo].[Menu] ([MenuId])
GO
ALTER TABLE [dbo].[Menu] CHECK CONSTRAINT [FK_Menu_Menu]
GO
ALTER TABLE [dbo].[MenuRole]  WITH CHECK ADD  CONSTRAINT [FK_MenuRole_Menu] FOREIGN KEY([MenuId])
REFERENCES [dbo].[Menu] ([MenuId])
GO
ALTER TABLE [dbo].[MenuRole] CHECK CONSTRAINT [FK_MenuRole_Menu]
GO
ALTER TABLE [dbo].[MessageAudit]  WITH CHECK ADD  CONSTRAINT [FK_MessageAudit_CustomerOrder] FOREIGN KEY([CustomerOrderId])
REFERENCES [dbo].[CustomerOrder] ([CustomerOrderId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[MessageAudit] CHECK CONSTRAINT [FK_MessageAudit_CustomerOrder]
GO
ALTER TABLE [dbo].[MessageAudit]  WITH CHECK ADD  CONSTRAINT [FK_MessageAudit_FromUserProfile] FOREIGN KEY([FromUserProfileId])
REFERENCES [dbo].[UserProfile] ([UserProfileId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[MessageAudit] CHECK CONSTRAINT [FK_MessageAudit_FromUserProfile]
GO
ALTER TABLE [dbo].[MessageAudit]  WITH CHECK ADD  CONSTRAINT [FK_MessageAudit_Message] FOREIGN KEY([MessageId])
REFERENCES [dbo].[Message] ([MessageId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[MessageAudit] CHECK CONSTRAINT [FK_MessageAudit_Message]
GO
ALTER TABLE [dbo].[MessageAudit]  WITH CHECK ADD  CONSTRAINT [FK_MessageAudit_ToUserProfile] FOREIGN KEY([ToUserProfileId])
REFERENCES [dbo].[UserProfile] ([UserProfileId])
GO
ALTER TABLE [dbo].[MessageAudit] CHECK CONSTRAINT [FK_MessageAudit_ToUserProfile]
GO
ALTER TABLE [dbo].[MessageStatus]  WITH CHECK ADD  CONSTRAINT [FK_MessageStatus_Message] FOREIGN KEY([MessageId])
REFERENCES [dbo].[Message] ([MessageId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[MessageStatus] CHECK CONSTRAINT [FK_MessageStatus_Message]
GO
ALTER TABLE [dbo].[MessageStatus]  WITH CHECK ADD  CONSTRAINT [FK_MessageStatus_UserProfile] FOREIGN KEY([UserProfileId])
REFERENCES [dbo].[UserProfile] ([UserProfileId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[MessageStatus] CHECK CONSTRAINT [FK_MessageStatus_UserProfile]
GO
ALTER TABLE [dbo].[MessageTarget]  WITH CHECK ADD  CONSTRAINT [FK_MessageTarget_Message] FOREIGN KEY([MessageId])
REFERENCES [dbo].[Message] ([MessageId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[MessageTarget] CHECK CONSTRAINT [FK_MessageTarget_Message]
GO
ALTER TABLE [dbo].[MiscellaneousCode]  WITH CHECK ADD  CONSTRAINT [FK_MiscellaneousCode_MiscellaneousCode] FOREIGN KEY([ParentId])
REFERENCES [dbo].[MiscellaneousCode] ([MiscellaneousCodeId])
GO
ALTER TABLE [dbo].[MiscellaneousCode] CHECK CONSTRAINT [FK_MiscellaneousCode_MiscellaneousCode]
GO
ALTER TABLE [dbo].[NewsArticle]  WITH CHECK ADD  CONSTRAINT [FK_NewsArticle_UserProfile] FOREIGN KEY([UserProfileId])
REFERENCES [dbo].[UserProfile] ([UserProfileId])
GO
ALTER TABLE [dbo].[NewsArticle] CHECK CONSTRAINT [FK_NewsArticle_UserProfile]
GO
ALTER TABLE [dbo].[NewsArticle]  WITH CHECK ADD  CONSTRAINT [FK_NewsArticle_WebSite] FOREIGN KEY([WebSiteId])
REFERENCES [dbo].[WebSite] ([WebSiteId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[NewsArticle] CHECK CONSTRAINT [FK_NewsArticle_WebSite]
GO
ALTER TABLE [dbo].[OrderHistoryLine]  WITH CHECK ADD  CONSTRAINT [FK_OrderHistoryLine_OrderHistory] FOREIGN KEY([OrderHistoryId])
REFERENCES [dbo].[OrderHistory] ([OrderHistoryId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderHistoryLine] CHECK CONSTRAINT [FK_OrderHistoryLine_OrderHistory]
GO
ALTER TABLE [dbo].[OrderLine]  WITH CHECK ADD  CONSTRAINT [FK_OrderLine_CustomerOrder] FOREIGN KEY([CustomerOrderId])
REFERENCES [dbo].[CustomerOrder] ([CustomerOrderId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderLine] CHECK CONSTRAINT [FK_OrderLine_CustomerOrder]
GO
ALTER TABLE [dbo].[OrderLine]  WITH CHECK ADD  CONSTRAINT [FK_OrderLine_OrderLine] FOREIGN KEY([OrderLineId])
REFERENCES [dbo].[OrderLine] ([OrderLineId])
GO
ALTER TABLE [dbo].[OrderLine] CHECK CONSTRAINT [FK_OrderLine_OrderLine]
GO
ALTER TABLE [dbo].[OrderLine]  WITH CHECK ADD  CONSTRAINT [FK_OrderLine_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ProductId])
GO
ALTER TABLE [dbo].[OrderLine] CHECK CONSTRAINT [FK_OrderLine_Product]
GO
ALTER TABLE [dbo].[OrderLine]  WITH CHECK ADD  CONSTRAINT [FK_OrderLine_PromotionResult] FOREIGN KEY([PromotionResultId])
REFERENCES [dbo].[PromotionResult] ([PromotionResultId])
GO
ALTER TABLE [dbo].[OrderLine] CHECK CONSTRAINT [FK_OrderLine_PromotionResult]
GO
ALTER TABLE [dbo].[OrderLine]  WITH CHECK ADD  CONSTRAINT [FK_OrderLine_WebSite] FOREIGN KEY([WebSiteId])
REFERENCES [dbo].[WebSite] ([WebSiteId])
GO
ALTER TABLE [dbo].[OrderLine] CHECK CONSTRAINT [FK_OrderLine_WebSite]
GO
ALTER TABLE [dbo].[OrderLineAttribute]  WITH CHECK ADD  CONSTRAINT [FK_OrderLineAttribute_OrderLine] FOREIGN KEY([OrderLineId])
REFERENCES [dbo].[OrderLine] ([OrderLineId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderLineAttribute] CHECK CONSTRAINT [FK_OrderLineAttribute_OrderLine]
GO
ALTER TABLE [dbo].[OrderLineConfigurationValue]  WITH CHECK ADD  CONSTRAINT [FK_OrderLineConfigurationValue_ConfigurationOption] FOREIGN KEY([ConfigurationOptionId])
REFERENCES [dbo].[ConfigurationOption] ([ConfigurationOptionId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderLineConfigurationValue] CHECK CONSTRAINT [FK_OrderLineConfigurationValue_ConfigurationOption]
GO
ALTER TABLE [dbo].[OrderLineConfigurationValue]  WITH CHECK ADD  CONSTRAINT [FK_OrderLineConfigurationValue_OrderLine] FOREIGN KEY([OrderLineId])
REFERENCES [dbo].[OrderLine] ([OrderLineId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderLineConfigurationValue] CHECK CONSTRAINT [FK_OrderLineConfigurationValue_OrderLine]
GO
ALTER TABLE [dbo].[OrderLineRequisition]  WITH CHECK ADD  CONSTRAINT [FK_OrderLineRequisition_OrderLine] FOREIGN KEY([OrderLineId])
REFERENCES [dbo].[OrderLine] ([OrderLineId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderLineRequisition] CHECK CONSTRAINT [FK_OrderLineRequisition_OrderLine]
GO
ALTER TABLE [dbo].[OrderLineRequisition]  WITH CHECK ADD  CONSTRAINT [FK_OrderLineRequisition_OrderLineRequisition] FOREIGN KEY([OrderLineRequisitionId])
REFERENCES [dbo].[OrderLineRequisition] ([OrderLineRequisitionId])
GO
ALTER TABLE [dbo].[OrderLineRequisition] CHECK CONSTRAINT [FK_OrderLineRequisition_OrderLineRequisition]
GO
ALTER TABLE [dbo].[OrderLineRequisition]  WITH CHECK ADD  CONSTRAINT [FK_OrderLineRequisition_OriginalOrderLine] FOREIGN KEY([OriginalOrderLineId])
REFERENCES [dbo].[OrderLine] ([OrderLineId])
GO
ALTER TABLE [dbo].[OrderLineRequisition] CHECK CONSTRAINT [FK_OrderLineRequisition_OriginalOrderLine]
GO
ALTER TABLE [dbo].[OrderLineRequisition]  WITH CHECK ADD  CONSTRAINT [FK_OrderLineRequisition_UserProfile] FOREIGN KEY([UserProfileId])
REFERENCES [dbo].[UserProfile] ([UserProfileId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderLineRequisition] CHECK CONSTRAINT [FK_OrderLineRequisition_UserProfile]
GO
ALTER TABLE [dbo].[OrderLineRfq]  WITH CHECK ADD  CONSTRAINT [FK_OrderLineRfq_OrderLine] FOREIGN KEY([OrderLineId])
REFERENCES [dbo].[OrderLine] ([OrderLineId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderLineRfq] CHECK CONSTRAINT [FK_OrderLineRfq_OrderLine]
GO
ALTER TABLE [dbo].[PackageLine]  WITH CHECK ADD  CONSTRAINT [FK_PackageLine_ShipmentPackage] FOREIGN KEY([ShipmentPackageId])
REFERENCES [dbo].[ShipmentPackage] ([ShipmentPackageId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PackageLine] CHECK CONSTRAINT [FK_PackageLine_ShipmentPackage]
GO
ALTER TABLE [dbo].[Persona]  WITH CHECK ADD  CONSTRAINT [FK_Persona_RuleManager] FOREIGN KEY([RuleManagerId])
REFERENCES [dbo].[RuleManager] ([RuleManagerId])
GO
ALTER TABLE [dbo].[Persona] CHECK CONSTRAINT [FK_Persona_RuleManager]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Configuration] FOREIGN KEY([ConfigurationId])
REFERENCES [dbo].[Configuration] ([ConfigurationId])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Configuration]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_DocumentManager] FOREIGN KEY([DocumentManagerId])
REFERENCES [dbo].[DocumentManager] ([DocumentManagerId])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_DocumentManager]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_ReplacementProduct] FOREIGN KEY([ReplacementProductId])
REFERENCES [dbo].[Product] ([ProductId])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_ReplacementProduct]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_RestrictionGroup] FOREIGN KEY([RestrictionGroupId])
REFERENCES [dbo].[RestrictionGroup] ([RestrictionGroupId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_RestrictionGroup]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_ShipVia] FOREIGN KEY([SubscriptionShipViaId])
REFERENCES [dbo].[ShipVia] ([ShipViaId])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_ShipVia]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_StyleClass] FOREIGN KEY([StyleClassId])
REFERENCES [dbo].[StyleClass] ([StyleClassId])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_StyleClass]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Vendor] FOREIGN KEY([VendorId])
REFERENCES [dbo].[Vendor] ([VendorId])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Vendor]
GO
ALTER TABLE [dbo].[ProductCost]  WITH CHECK ADD  CONSTRAINT [FK_ProductCost_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ProductId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProductCost] CHECK CONSTRAINT [FK_ProductCost_Product]
GO
ALTER TABLE [dbo].[ProductFilterValue]  WITH CHECK ADD  CONSTRAINT [FK_ProductFilterValue_FilterValue] FOREIGN KEY([FilterValueId])
REFERENCES [dbo].[FilterValue] ([FilterValueId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProductFilterValue] CHECK CONSTRAINT [FK_ProductFilterValue_FilterValue]
GO
ALTER TABLE [dbo].[ProductFilterValue]  WITH CHECK ADD  CONSTRAINT [FK_ProductFilterValue_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ProductId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProductFilterValue] CHECK CONSTRAINT [FK_ProductFilterValue_Product]
GO
ALTER TABLE [dbo].[ProductPrice]  WITH CHECK ADD  CONSTRAINT [FK_ProductPrice_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ProductId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProductPrice] CHECK CONSTRAINT [FK_ProductPrice_Product]
GO
ALTER TABLE [dbo].[ProductProductAccessory]  WITH CHECK ADD  CONSTRAINT [ProductProductAccessory_fk] FOREIGN KEY([ProductAccessoryId])
REFERENCES [dbo].[Product] ([ProductId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProductProductAccessory] CHECK CONSTRAINT [ProductProductAccessory_fk]
GO
ALTER TABLE [dbo].[ProductProductCrossSell]  WITH CHECK ADD  CONSTRAINT [FK_ProductProductCrossSell_Product] FOREIGN KEY([CrossSellProductId])
REFERENCES [dbo].[Product] ([ProductId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProductProductCrossSell] CHECK CONSTRAINT [FK_ProductProductCrossSell_Product]
GO
ALTER TABLE [dbo].[ProductProductCrossSell]  WITH CHECK ADD  CONSTRAINT [FK_ProductProductCrossSell_Product1] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ProductId])
GO
ALTER TABLE [dbo].[ProductProductCrossSell] CHECK CONSTRAINT [FK_ProductProductCrossSell_Product1]
GO
ALTER TABLE [dbo].[ProductProperty]  WITH CHECK ADD  CONSTRAINT [FK_ProductProperty_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ProductId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProductProperty] CHECK CONSTRAINT [FK_ProductProperty_Product]
GO
ALTER TABLE [dbo].[ProductSpecification]  WITH CHECK ADD  CONSTRAINT [FK_ProductSpecification_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ProductId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProductSpecification] CHECK CONSTRAINT [FK_ProductSpecification_Product]
GO
ALTER TABLE [dbo].[ProductSpecification]  WITH CHECK ADD  CONSTRAINT [FK_ProductSpecification_Specification] FOREIGN KEY([SpecificationId])
REFERENCES [dbo].[Specification] ([SpecificationId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProductSpecification] CHECK CONSTRAINT [FK_ProductSpecification_Specification]
GO
ALTER TABLE [dbo].[ProductTaxExemption]  WITH CHECK ADD  CONSTRAINT [FK_ProductTaxExemption_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ProductId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProductTaxExemption] CHECK CONSTRAINT [FK_ProductTaxExemption_Product]
GO
ALTER TABLE [dbo].[ProductTaxExemption]  WITH CHECK ADD  CONSTRAINT [FK_ProductTaxExemption_TaxExemption] FOREIGN KEY([TaxExemptionId])
REFERENCES [dbo].[TaxExemption] ([TaxExemptionId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProductTaxExemption] CHECK CONSTRAINT [FK_ProductTaxExemption_TaxExemption]
GO
ALTER TABLE [dbo].[ProductUnitOfMeasure]  WITH CHECK ADD  CONSTRAINT [FK_ProductUnitOfMeasure_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ProductId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProductUnitOfMeasure] CHECK CONSTRAINT [FK_ProductUnitOfMeasure_Product]
GO
ALTER TABLE [dbo].[ProductWarehouse]  WITH CHECK ADD  CONSTRAINT [FK_ProductWarehouse_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ProductId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProductWarehouse] CHECK CONSTRAINT [FK_ProductWarehouse_Product]
GO
ALTER TABLE [dbo].[ProductWarehouse]  WITH CHECK ADD  CONSTRAINT [FK_ProductWarehouse_Warehouse] FOREIGN KEY([WarehouseId])
REFERENCES [dbo].[Warehouse] ([WarehouseId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProductWarehouse] CHECK CONSTRAINT [FK_ProductWarehouse_Warehouse]
GO
ALTER TABLE [dbo].[PromotionCode]  WITH CHECK ADD  CONSTRAINT [FK_PromotionCode_CustomerOrder] FOREIGN KEY([CustomerOrderId])
REFERENCES [dbo].[CustomerOrder] ([CustomerOrderId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PromotionCode] CHECK CONSTRAINT [FK_PromotionCode_CustomerOrder]
GO
ALTER TABLE [dbo].[PromotionResult]  WITH CHECK ADD  CONSTRAINT [FK_PromotionResult_Category] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([CategoryId])
GO
ALTER TABLE [dbo].[PromotionResult] CHECK CONSTRAINT [FK_PromotionResult_Category]
GO
ALTER TABLE [dbo].[PromotionResult]  WITH CHECK ADD  CONSTRAINT [FK_PromotionResult_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ProductId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PromotionResult] CHECK CONSTRAINT [FK_PromotionResult_Product]
GO
ALTER TABLE [dbo].[PromotionResult]  WITH CHECK ADD  CONSTRAINT [FK_PromotionResult_Promotion] FOREIGN KEY([PromotionId])
REFERENCES [dbo].[Promotion] ([PromotionId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PromotionResult] CHECK CONSTRAINT [FK_PromotionResult_Promotion]
GO
ALTER TABLE [dbo].[PromotionResult]  WITH CHECK ADD  CONSTRAINT [FK_PromotionResult_ShipVia] FOREIGN KEY([ShipViaId])
REFERENCES [dbo].[ShipVia] ([ShipViaId])
GO
ALTER TABLE [dbo].[PromotionResult] CHECK CONSTRAINT [FK_PromotionResult_ShipVia]
GO
ALTER TABLE [dbo].[PromotionRule]  WITH CHECK ADD  CONSTRAINT [FK_PromotionRule_Affiliate] FOREIGN KEY([AffiliateId])
REFERENCES [dbo].[Affiliate] ([AffiliateId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PromotionRule] CHECK CONSTRAINT [FK_PromotionRule_Affiliate]
GO
ALTER TABLE [dbo].[PromotionRule]  WITH CHECK ADD  CONSTRAINT [FK_PromotionRule_Category] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([CategoryId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PromotionRule] CHECK CONSTRAINT [FK_PromotionRule_Category]
GO
ALTER TABLE [dbo].[PromotionRule]  WITH CHECK ADD  CONSTRAINT [FK_PromotionRule_ContainedPromotion] FOREIGN KEY([ContainedPromotionId])
REFERENCES [dbo].[Promotion] ([PromotionId])
GO
ALTER TABLE [dbo].[PromotionRule] CHECK CONSTRAINT [FK_PromotionRule_ContainedPromotion]
GO
ALTER TABLE [dbo].[PromotionRule]  WITH CHECK ADD  CONSTRAINT [FK_PromotionRule_Country] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Country] ([CountryId])
GO
ALTER TABLE [dbo].[PromotionRule] CHECK CONSTRAINT [FK_PromotionRule_Country]
GO
ALTER TABLE [dbo].[PromotionRule]  WITH CHECK ADD  CONSTRAINT [FK_PromotionRule_Currency] FOREIGN KEY([CurrencyId])
REFERENCES [dbo].[Currency] ([CurrencyId])
GO
ALTER TABLE [dbo].[PromotionRule] CHECK CONSTRAINT [FK_PromotionRule_Currency]
GO
ALTER TABLE [dbo].[PromotionRule]  WITH CHECK ADD  CONSTRAINT [FK_PromotionRule_Customer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([CustomerId])
GO
ALTER TABLE [dbo].[PromotionRule] CHECK CONSTRAINT [FK_PromotionRule_Customer]
GO
ALTER TABLE [dbo].[PromotionRule]  WITH CHECK ADD  CONSTRAINT [FK_PromotionRule_PaymentTerm] FOREIGN KEY([PaymentTermId])
REFERENCES [dbo].[PaymentTerm] ([PaymentTermId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PromotionRule] CHECK CONSTRAINT [FK_PromotionRule_PaymentTerm]
GO
ALTER TABLE [dbo].[PromotionRule]  WITH CHECK ADD  CONSTRAINT [FK_PromotionRule_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ProductId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PromotionRule] CHECK CONSTRAINT [FK_PromotionRule_Product]
GO
ALTER TABLE [dbo].[PromotionRule]  WITH CHECK ADD  CONSTRAINT [FK_PromotionRule_Promotion] FOREIGN KEY([PromotionId])
REFERENCES [dbo].[Promotion] ([PromotionId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PromotionRule] CHECK CONSTRAINT [FK_PromotionRule_Promotion]
GO
ALTER TABLE [dbo].[PromotionRule]  WITH CHECK ADD  CONSTRAINT [FK_PromotionRule_Salesman] FOREIGN KEY([SalesmanId])
REFERENCES [dbo].[Salesman] ([SalesmanId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PromotionRule] CHECK CONSTRAINT [FK_PromotionRule_Salesman]
GO
ALTER TABLE [dbo].[PromotionRule]  WITH CHECK ADD  CONSTRAINT [FK_PromotionRule_ShipVia] FOREIGN KEY([ShipViaId])
REFERENCES [dbo].[ShipVia] ([ShipViaId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PromotionRule] CHECK CONSTRAINT [FK_PromotionRule_ShipVia]
GO
ALTER TABLE [dbo].[PromotionRule]  WITH CHECK ADD  CONSTRAINT [FK_PromotionRule_State] FOREIGN KEY([StateId])
REFERENCES [dbo].[State] ([StateId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PromotionRule] CHECK CONSTRAINT [FK_PromotionRule_State]
GO
ALTER TABLE [dbo].[PromotionRule]  WITH CHECK ADD  CONSTRAINT [FK_PromotionRule_UserProfile] FOREIGN KEY([UserProfileId])
REFERENCES [dbo].[UserProfile] ([UserProfileId])
GO
ALTER TABLE [dbo].[PromotionRule] CHECK CONSTRAINT [FK_PromotionRule_UserProfile]
GO
ALTER TABLE [dbo].[PromotionRule]  WITH CHECK ADD  CONSTRAINT [FK_PromotionRule_Vendor] FOREIGN KEY([VendorId])
REFERENCES [dbo].[Vendor] ([VendorId])
GO
ALTER TABLE [dbo].[PromotionRule] CHECK CONSTRAINT [FK_PromotionRule_Vendor]
GO
ALTER TABLE [dbo].[PunchOutCustomerUserProfileMap]  WITH CHECK ADD  CONSTRAINT [FK_PunchOutCustomerUserProfileMap_Customer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([CustomerId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PunchOutCustomerUserProfileMap] CHECK CONSTRAINT [FK_PunchOutCustomerUserProfileMap_Customer]
GO
ALTER TABLE [dbo].[PunchOutCustomerUserProfileMap]  WITH CHECK ADD  CONSTRAINT [FK_PunchOutCustomerUserProfileMap_UserProfile] FOREIGN KEY([UserProfileId])
REFERENCES [dbo].[UserProfile] ([UserProfileId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PunchOutCustomerUserProfileMap] CHECK CONSTRAINT [FK_PunchOutCustomerUserProfileMap_UserProfile]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest]  WITH CHECK ADD  CONSTRAINT [FK_PunchOutOrderRequest_CustomerOrder] FOREIGN KEY([CustomerOrderId])
REFERENCES [dbo].[CustomerOrder] ([CustomerOrderId])
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] CHECK CONSTRAINT [FK_PunchOutOrderRequest_CustomerOrder]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest]  WITH CHECK ADD  CONSTRAINT [FK_PunchOutOrderRequest_PunchOutSessionId] FOREIGN KEY([PunchOutSessionId])
REFERENCES [dbo].[PunchOutSession] ([PunchOutSessionId])
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] CHECK CONSTRAINT [FK_PunchOutOrderRequest_PunchOutSessionId]
GO
ALTER TABLE [dbo].[PunchOutOrderRequest]  WITH CHECK ADD  CONSTRAINT [FK_PunchOutOrderRequest_UserProfile] FOREIGN KEY([UserProfileId])
REFERENCES [dbo].[UserProfile] ([UserProfileId])
GO
ALTER TABLE [dbo].[PunchOutOrderRequest] CHECK CONSTRAINT [FK_PunchOutOrderRequest_UserProfile]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestExtrinsic]  WITH CHECK ADD  CONSTRAINT [FK_PunchOutOrderRequestExtrinsic_PunchOutOrderRequest] FOREIGN KEY([PunchOutOrderRequestId])
REFERENCES [dbo].[PunchOutOrderRequest] ([PunchOutOrderRequestId])
GO
ALTER TABLE [dbo].[PunchOutOrderRequestExtrinsic] CHECK CONSTRAINT [FK_PunchOutOrderRequestExtrinsic_PunchOutOrderRequest]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut]  WITH CHECK ADD  CONSTRAINT [FK_PunchOutOrderRequestItemOut_OrderLine] FOREIGN KEY([OrderLineId])
REFERENCES [dbo].[OrderLine] ([OrderLineId])
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut] CHECK CONSTRAINT [FK_PunchOutOrderRequestItemOut_OrderLine]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut]  WITH CHECK ADD  CONSTRAINT [FK_PunchOutOrderRequestItemOut_PunchOutOrderRequest] FOREIGN KEY([PunchOutOrderRequestId])
REFERENCES [dbo].[PunchOutOrderRequest] ([PunchOutOrderRequestId])
GO
ALTER TABLE [dbo].[PunchOutOrderRequestItemOut] CHECK CONSTRAINT [FK_PunchOutOrderRequestItemOut_PunchOutOrderRequest]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestValidationMessage]  WITH CHECK ADD  CONSTRAINT [FK_PunchOutOrderRequestValidationMessage_PunchOutOrderRequest] FOREIGN KEY([PunchOutOrderRequestId])
REFERENCES [dbo].[PunchOutOrderRequest] ([PunchOutOrderRequestId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PunchOutOrderRequestValidationMessage] CHECK CONSTRAINT [FK_PunchOutOrderRequestValidationMessage_PunchOutOrderRequest]
GO
ALTER TABLE [dbo].[PunchOutOrderRequestValidationMessage]  WITH CHECK ADD  CONSTRAINT [FK_PunchOutOrderRequestValidationMessage_PunchOutOrderRequestItemOut] FOREIGN KEY([PunchOutOrderRequestItemOutId])
REFERENCES [dbo].[PunchOutOrderRequestItemOut] ([PunchOutOrderRequestItemOutId])
GO
ALTER TABLE [dbo].[PunchOutOrderRequestValidationMessage] CHECK CONSTRAINT [FK_PunchOutOrderRequestValidationMessage_PunchOutOrderRequestItemOut]
GO
ALTER TABLE [dbo].[PunchOutSession]  WITH CHECK ADD  CONSTRAINT [FK_PunchOutSession_CustomerOrder] FOREIGN KEY([CustomerOrderId])
REFERENCES [dbo].[CustomerOrder] ([CustomerOrderId])
GO
ALTER TABLE [dbo].[PunchOutSession] CHECK CONSTRAINT [FK_PunchOutSession_CustomerOrder]
GO
ALTER TABLE [dbo].[PunchOutSession]  WITH CHECK ADD  CONSTRAINT [FK_PunchOutSession_UserProfile] FOREIGN KEY([UserProfileId])
REFERENCES [dbo].[UserProfile] ([UserProfileId])
GO
ALTER TABLE [dbo].[PunchOutSession] CHECK CONSTRAINT [FK_PunchOutSession_UserProfile]
GO
ALTER TABLE [dbo].[PunchOutSessionAccess]  WITH CHECK ADD  CONSTRAINT [FK_PunchOutSessionAccess_PunchOutSession] FOREIGN KEY([PunchOutSessionId])
REFERENCES [dbo].[PunchOutSession] ([PunchOutSessionId])
GO
ALTER TABLE [dbo].[PunchOutSessionAccess] CHECK CONSTRAINT [FK_PunchOutSessionAccess_PunchOutSession]
GO
ALTER TABLE [dbo].[PunchOutSessionExtrinsic]  WITH CHECK ADD  CONSTRAINT [FK_PunchOutSessionExtrinsic_PunchOutSession] FOREIGN KEY([PunchOutSessionId])
REFERENCES [dbo].[PunchOutSession] ([PunchOutSessionId])
GO
ALTER TABLE [dbo].[PunchOutSessionExtrinsic] CHECK CONSTRAINT [FK_PunchOutSessionExtrinsic_PunchOutSession]
GO
ALTER TABLE [dbo].[PunchOutSessionItemIn]  WITH CHECK ADD  CONSTRAINT [FK_PunchOutSessionItemIn_PunchOutSession] FOREIGN KEY([PunchOutSessionId])
REFERENCES [dbo].[PunchOutSession] ([PunchOutSessionId])
GO
ALTER TABLE [dbo].[PunchOutSessionItemIn] CHECK CONSTRAINT [FK_PunchOutSessionItemIn_PunchOutSession]
GO
ALTER TABLE [dbo].[PunchOutSetupRequest]  WITH CHECK ADD  CONSTRAINT [FK_PunchOutSetupRequest_PunchOutSession] FOREIGN KEY([PunchOutSessionId])
REFERENCES [dbo].[PunchOutSession] ([PunchOutSessionId])
GO
ALTER TABLE [dbo].[PunchOutSetupRequest] CHECK CONSTRAINT [FK_PunchOutSetupRequest_PunchOutSession]
GO
ALTER TABLE [dbo].[Restriction]  WITH CHECK ADD  CONSTRAINT [FK_Restriction_Category] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([CategoryId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Restriction] CHECK CONSTRAINT [FK_Restriction_Category]
GO
ALTER TABLE [dbo].[Restriction]  WITH CHECK ADD  CONSTRAINT [FK_Restriction_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ProductId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Restriction] CHECK CONSTRAINT [FK_Restriction_Product]
GO
ALTER TABLE [dbo].[Restriction]  WITH CHECK ADD  CONSTRAINT [FK_Restriction_State] FOREIGN KEY([StateId])
REFERENCES [dbo].[State] ([StateId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Restriction] CHECK CONSTRAINT [FK_Restriction_State]
GO
ALTER TABLE [dbo].[Review]  WITH CHECK ADD  CONSTRAINT [FK_Review_Category] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([CategoryId])
GO
ALTER TABLE [dbo].[Review] CHECK CONSTRAINT [FK_Review_Category]
GO
ALTER TABLE [dbo].[Review]  WITH CHECK ADD  CONSTRAINT [FK_Review_ContentManager] FOREIGN KEY([ContentManagerId])
REFERENCES [dbo].[ContentManager] ([ContentManagerId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Review] CHECK CONSTRAINT [FK_Review_ContentManager]
GO
ALTER TABLE [dbo].[Review]  WITH CHECK ADD  CONSTRAINT [FK_Review_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ProductId])
GO
ALTER TABLE [dbo].[Review] CHECK CONSTRAINT [FK_Review_Product]
GO
ALTER TABLE [dbo].[Review]  WITH CHECK ADD  CONSTRAINT [FK_Review_UserProfile] FOREIGN KEY([UserProfileId])
REFERENCES [dbo].[UserProfile] ([UserProfileId])
GO
ALTER TABLE [dbo].[Review] CHECK CONSTRAINT [FK_Review_UserProfile]
GO
ALTER TABLE [dbo].[RuleClause]  WITH CHECK ADD  CONSTRAINT [FK_RuleClause_RuleManager] FOREIGN KEY([RuleManagerId])
REFERENCES [dbo].[RuleManager] ([RuleManagerId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RuleClause] CHECK CONSTRAINT [FK_RuleClause_RuleManager]
GO
ALTER TABLE [dbo].[RuleClause]  WITH CHECK ADD  CONSTRAINT [FK_RuleClause_RuleTypeOption] FOREIGN KEY([RuleTypeOptionId])
REFERENCES [dbo].[RuleTypeOption] ([RuleTypeOptionId])
GO
ALTER TABLE [dbo].[RuleClause] CHECK CONSTRAINT [FK_RuleClause_RuleTypeOption]
GO
ALTER TABLE [dbo].[RuleManager]  WITH CHECK ADD  CONSTRAINT [FK_RuleManager_RuleType] FOREIGN KEY([RuleTypeId])
REFERENCES [dbo].[RuleType] ([RuleTypeId])
GO
ALTER TABLE [dbo].[RuleManager] CHECK CONSTRAINT [FK_RuleManager_RuleType]
GO
ALTER TABLE [dbo].[RuleTypeOption]  WITH CHECK ADD  CONSTRAINT [FK_RuleTypeOption_RuleType] FOREIGN KEY([RuleTypeId])
REFERENCES [dbo].[RuleType] ([RuleTypeId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RuleTypeOption] CHECK CONSTRAINT [FK_RuleTypeOption_RuleType]
GO
ALTER TABLE [dbo].[Salesman]  WITH CHECK ADD  CONSTRAINT [FK_Salesman_Salesman] FOREIGN KEY([ParentId])
REFERENCES [dbo].[Salesman] ([SalesmanId])
GO
ALTER TABLE [dbo].[Salesman] CHECK CONSTRAINT [FK_Salesman_Salesman]
GO
ALTER TABLE [dbo].[Salesman]  WITH CHECK ADD  CONSTRAINT [FK_Salesman_UserProfile] FOREIGN KEY([UserProfileId])
REFERENCES [dbo].[UserProfile] ([UserProfileId])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Salesman] CHECK CONSTRAINT [FK_Salesman_UserProfile]
GO
ALTER TABLE [dbo].[ShipCharge]  WITH CHECK ADD  CONSTRAINT [FK_ShipCharge_Carrier] FOREIGN KEY([CarrierId])
REFERENCES [dbo].[Carrier] ([CarrierId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ShipCharge] CHECK CONSTRAINT [FK_ShipCharge_Carrier]
GO
ALTER TABLE [dbo].[ShipCharge]  WITH CHECK ADD  CONSTRAINT [FK_ShipCharge_ShipVia] FOREIGN KEY([ShipViaId])
REFERENCES [dbo].[ShipVia] ([ShipViaId])
GO
ALTER TABLE [dbo].[ShipCharge] CHECK CONSTRAINT [FK_ShipCharge_ShipVia]
GO
ALTER TABLE [dbo].[ShipmentPackage]  WITH CHECK ADD  CONSTRAINT [FK_ShipmentPackage_Shipment] FOREIGN KEY([ShipmentId])
REFERENCES [dbo].[Shipment] ([ShipmentId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ShipmentPackage] CHECK CONSTRAINT [FK_ShipmentPackage_Shipment]
GO
ALTER TABLE [dbo].[ShipRate]  WITH CHECK ADD  CONSTRAINT [FK_ShipRate_ShipVia] FOREIGN KEY([ShipViaId])
REFERENCES [dbo].[ShipVia] ([ShipViaId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ShipRate] CHECK CONSTRAINT [FK_ShipRate_ShipVia]
GO
ALTER TABLE [dbo].[ShipRule]  WITH CHECK ADD  CONSTRAINT [FK_ShipRule_Carrier] FOREIGN KEY([CarrierId])
REFERENCES [dbo].[Carrier] ([CarrierId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ShipRule] CHECK CONSTRAINT [FK_ShipRule_Carrier]
GO
ALTER TABLE [dbo].[ShipRule]  WITH CHECK ADD  CONSTRAINT [FK_ShipRule_Category] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([CategoryId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ShipRule] CHECK CONSTRAINT [FK_ShipRule_Category]
GO
ALTER TABLE [dbo].[ShipRule]  WITH CHECK ADD  CONSTRAINT [FK_ShipRule_Country] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Country] ([CountryId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ShipRule] CHECK CONSTRAINT [FK_ShipRule_Country]
GO
ALTER TABLE [dbo].[ShipRule]  WITH CHECK ADD  CONSTRAINT [FK_ShipRule_Customer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([CustomerId])
GO
ALTER TABLE [dbo].[ShipRule] CHECK CONSTRAINT [FK_ShipRule_Customer]
GO
ALTER TABLE [dbo].[ShipRule]  WITH CHECK ADD  CONSTRAINT [FK_ShipRule_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ProductId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ShipRule] CHECK CONSTRAINT [FK_ShipRule_Product]
GO
ALTER TABLE [dbo].[ShipRule]  WITH CHECK ADD  CONSTRAINT [FK_ShipRule_ShipRate] FOREIGN KEY([ShipRateId])
REFERENCES [dbo].[ShipRate] ([ShipRateId])
GO
ALTER TABLE [dbo].[ShipRule] CHECK CONSTRAINT [FK_ShipRule_ShipRate]
GO
ALTER TABLE [dbo].[ShipRule]  WITH CHECK ADD  CONSTRAINT [FK_ShipRule_ShipVia] FOREIGN KEY([ShipViaId])
REFERENCES [dbo].[ShipVia] ([ShipViaId])
GO
ALTER TABLE [dbo].[ShipRule] CHECK CONSTRAINT [FK_ShipRule_ShipVia]
GO
ALTER TABLE [dbo].[ShipRule]  WITH CHECK ADD  CONSTRAINT [FK_ShipRule_State] FOREIGN KEY([StateId])
REFERENCES [dbo].[State] ([StateId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ShipRule] CHECK CONSTRAINT [FK_ShipRule_State]
GO
ALTER TABLE [dbo].[ShipVia]  WITH CHECK ADD  CONSTRAINT [FK_ShipVia_Carrier] FOREIGN KEY([CarrierId])
REFERENCES [dbo].[Carrier] ([CarrierId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ShipVia] CHECK CONSTRAINT [FK_ShipVia_Carrier]
GO
ALTER TABLE [dbo].[StateTaxExemption]  WITH CHECK ADD  CONSTRAINT [FK_StateTaxExemption_State] FOREIGN KEY([StateId])
REFERENCES [dbo].[State] ([StateId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[StateTaxExemption] CHECK CONSTRAINT [FK_StateTaxExemption_State]
GO
ALTER TABLE [dbo].[StateTaxExemption]  WITH CHECK ADD  CONSTRAINT [FK_StateTaxExemption_TaxExemption] FOREIGN KEY([TaxExemptionId])
REFERENCES [dbo].[TaxExemption] ([TaxExemptionId])
GO
ALTER TABLE [dbo].[StateTaxExemption] CHECK CONSTRAINT [FK_StateTaxExemption_TaxExemption]
GO
ALTER TABLE [dbo].[StyleTrait]  WITH CHECK ADD  CONSTRAINT [FK_StyleTrait_StyleClass] FOREIGN KEY([StyleClassId])
REFERENCES [dbo].[StyleClass] ([StyleClassId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[StyleTrait] CHECK CONSTRAINT [FK_StyleTrait_StyleClass]
GO
ALTER TABLE [dbo].[StyleTraitValue]  WITH CHECK ADD  CONSTRAINT [FK_StyleTraitValue_StyleTrait1] FOREIGN KEY([StyleTraitId])
REFERENCES [dbo].[StyleTrait] ([StyleTraitId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[StyleTraitValue] CHECK CONSTRAINT [FK_StyleTraitValue_StyleTrait1]
GO
ALTER TABLE [dbo].[StyleTraitValueProduct]  WITH CHECK ADD  CONSTRAINT [FK_StyleTraitValueProduct_Product1] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ProductId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[StyleTraitValueProduct] CHECK CONSTRAINT [FK_StyleTraitValueProduct_Product1]
GO
ALTER TABLE [dbo].[StyleTraitValueProduct]  WITH CHECK ADD  CONSTRAINT [FK_StyleTraitValueProduct_StyleTraitValue1] FOREIGN KEY([StyleTraitValueId])
REFERENCES [dbo].[StyleTraitValue] ([StyleTraitValueId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[StyleTraitValueProduct] CHECK CONSTRAINT [FK_StyleTraitValueProduct_StyleTraitValue1]
GO
ALTER TABLE [dbo].[Subscription]  WITH CHECK ADD  CONSTRAINT [FK_Subscription_Customer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([CustomerId])
GO
ALTER TABLE [dbo].[Subscription] CHECK CONSTRAINT [FK_Subscription_Customer]
GO
ALTER TABLE [dbo].[Subscription]  WITH CHECK ADD  CONSTRAINT [FK_Subscription_CustomerOrder] FOREIGN KEY([CustomerOrderId])
REFERENCES [dbo].[CustomerOrder] ([CustomerOrderId])
GO
ALTER TABLE [dbo].[Subscription] CHECK CONSTRAINT [FK_Subscription_CustomerOrder]
GO
ALTER TABLE [dbo].[Subscription]  WITH CHECK ADD  CONSTRAINT [FK_Subscription_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ProductId])
GO
ALTER TABLE [dbo].[Subscription] CHECK CONSTRAINT [FK_Subscription_Product]
GO
ALTER TABLE [dbo].[Subscription]  WITH CHECK ADD  CONSTRAINT [FK_Subscription_ShipTo] FOREIGN KEY([ShipToId])
REFERENCES [dbo].[Customer] ([CustomerId])
GO
ALTER TABLE [dbo].[Subscription] CHECK CONSTRAINT [FK_Subscription_ShipTo]
GO
ALTER TABLE [dbo].[Subscription]  WITH CHECK ADD  CONSTRAINT [FK_Subscription_ShipVia] FOREIGN KEY([ShipViaId])
REFERENCES [dbo].[ShipVia] ([ShipViaId])
GO
ALTER TABLE [dbo].[Subscription] CHECK CONSTRAINT [FK_Subscription_ShipVia]
GO
ALTER TABLE [dbo].[Subscription]  WITH CHECK ADD  CONSTRAINT [FK_Subscription_UserProfile] FOREIGN KEY([UserProfileId])
REFERENCES [dbo].[UserProfile] ([UserProfileId])
GO
ALTER TABLE [dbo].[Subscription] CHECK CONSTRAINT [FK_Subscription_UserProfile]
GO
ALTER TABLE [dbo].[Subscription]  WITH CHECK ADD  CONSTRAINT [FK_Subscription_WebSite] FOREIGN KEY([WebSiteId])
REFERENCES [dbo].[WebSite] ([WebSiteId])
GO
ALTER TABLE [dbo].[Subscription] CHECK CONSTRAINT [FK_Subscription_WebSite]
GO
ALTER TABLE [dbo].[SubscriptionLine]  WITH CHECK ADD  CONSTRAINT [FK_SubscriptionLine_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ProductId])
GO
ALTER TABLE [dbo].[SubscriptionLine] CHECK CONSTRAINT [FK_SubscriptionLine_Product]
GO
ALTER TABLE [dbo].[SubscriptionLine]  WITH CHECK ADD  CONSTRAINT [FK_SubscriptionLine_Subscription] FOREIGN KEY([SubscriptionId])
REFERENCES [dbo].[Subscription] ([SubscriptionId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SubscriptionLine] CHECK CONSTRAINT [FK_SubscriptionLine_Subscription]
GO
ALTER TABLE [dbo].[SubscriptionProduct]  WITH CHECK ADD  CONSTRAINT [FK_SubscriptionProduct_ParentProduct] FOREIGN KEY([ParentProductId])
REFERENCES [dbo].[Product] ([ProductId])
GO
ALTER TABLE [dbo].[SubscriptionProduct] CHECK CONSTRAINT [FK_SubscriptionProduct_ParentProduct]
GO
ALTER TABLE [dbo].[SubscriptionProduct]  WITH CHECK ADD  CONSTRAINT [FK_SubscriptionProduct_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ProductId])
GO
ALTER TABLE [dbo].[SubscriptionProduct] CHECK CONSTRAINT [FK_SubscriptionProduct_Product]
GO
ALTER TABLE [dbo].[UserProfile]  WITH CHECK ADD  CONSTRAINT [FK_UserProfile_ApproverUserProfile] FOREIGN KEY([ApproverUserProfileId])
REFERENCES [dbo].[UserProfile] ([UserProfileId])
GO
ALTER TABLE [dbo].[UserProfile] CHECK CONSTRAINT [FK_UserProfile_ApproverUserProfile]
GO
ALTER TABLE [dbo].[UserProfile]  WITH CHECK ADD  CONSTRAINT [FK_UserProfile_Currency] FOREIGN KEY([CurrencyId])
REFERENCES [dbo].[Currency] ([CurrencyId])
GO
ALTER TABLE [dbo].[UserProfile] CHECK CONSTRAINT [FK_UserProfile_Currency]
GO
ALTER TABLE [dbo].[UserProfile]  WITH CHECK ADD  CONSTRAINT [FK_UserProfile_DefaultCustomer] FOREIGN KEY([DefaultCustomerId])
REFERENCES [dbo].[Customer] ([CustomerId])
GO
ALTER TABLE [dbo].[UserProfile] CHECK CONSTRAINT [FK_UserProfile_DefaultCustomer]
GO
ALTER TABLE [dbo].[UserProfileEmailList]  WITH CHECK ADD  CONSTRAINT [FK_UserProfileEmailList_EmailList] FOREIGN KEY([EmailListId])
REFERENCES [dbo].[EmailList] ([EmailListId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserProfileEmailList] CHECK CONSTRAINT [FK_UserProfileEmailList_EmailList]
GO
ALTER TABLE [dbo].[UserProfileEmailList]  WITH CHECK ADD  CONSTRAINT [FK_UserProfileEmailList_UserProfile] FOREIGN KEY([UserProfileId])
REFERENCES [dbo].[UserProfile] ([UserProfileId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserProfileEmailList] CHECK CONSTRAINT [FK_UserProfileEmailList_UserProfile]
GO
ALTER TABLE [dbo].[UserProfilePassword]  WITH CHECK ADD  CONSTRAINT [FK_UserProfilePassword_UserProfile] FOREIGN KEY([UserProfileId])
REFERENCES [dbo].[UserProfile] ([UserProfileId])
GO
ALTER TABLE [dbo].[UserProfilePassword] CHECK CONSTRAINT [FK_UserProfilePassword_UserProfile]
GO
ALTER TABLE [dbo].[UserProfileProperty]  WITH CHECK ADD  CONSTRAINT [FK_UserProfileProperty_UserProfile] FOREIGN KEY([UserProfileId])
REFERENCES [dbo].[UserProfile] ([UserProfileId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserProfileProperty] CHECK CONSTRAINT [FK_UserProfileProperty_UserProfile]
GO
ALTER TABLE [dbo].[WarehouseAlternate]  WITH CHECK ADD  CONSTRAINT [FK_WarehouseAlternate_AlternateWarehouse] FOREIGN KEY([AlternateWarehouseId])
REFERENCES [dbo].[Warehouse] ([WarehouseId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[WarehouseAlternate] CHECK CONSTRAINT [FK_WarehouseAlternate_AlternateWarehouse]
GO
ALTER TABLE [dbo].[WarehouseAlternate]  WITH CHECK ADD  CONSTRAINT [FK_WarehouseAlternate_Warehouse] FOREIGN KEY([WarehouseId])
REFERENCES [dbo].[Warehouse] ([WarehouseId])
GO
ALTER TABLE [dbo].[WarehouseAlternate] CHECK CONSTRAINT [FK_WarehouseAlternate_Warehouse]
GO
ALTER TABLE [dbo].[WebPage]  WITH CHECK ADD  CONSTRAINT [FK_WebPage_WebSite] FOREIGN KEY([WebSiteId])
REFERENCES [dbo].[WebSite] ([WebSiteId])
GO
ALTER TABLE [dbo].[WebPage] CHECK CONSTRAINT [FK_WebPage_WebSite]
GO
ALTER TABLE [dbo].[WebPageContent]  WITH CHECK ADD  CONSTRAINT [FK_WebPageContent_WebPage] FOREIGN KEY([WebPageId])
REFERENCES [dbo].[WebPage] ([WebPageId])
GO
ALTER TABLE [dbo].[WebPageContent] CHECK CONSTRAINT [FK_WebPageContent_WebPage]
GO
ALTER TABLE [dbo].[WebPageContent]  WITH CHECK ADD  CONSTRAINT [FK_WebPageContent_WebSite] FOREIGN KEY([WebSiteId])
REFERENCES [dbo].[WebSite] ([WebSiteId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[WebPageContent] CHECK CONSTRAINT [FK_WebPageContent_WebSite]
GO
ALTER TABLE [dbo].[WebSite]  WITH CHECK ADD  CONSTRAINT [FK_WebSite_WebSite] FOREIGN KEY([ParentWebSiteId])
REFERENCES [dbo].[WebSite] ([WebSiteId])
GO
ALTER TABLE [dbo].[WebSite] CHECK CONSTRAINT [FK_WebSite_WebSite]
GO
ALTER TABLE [dbo].[WebSiteAllowedCustomers]  WITH CHECK ADD  CONSTRAINT [FK_WebSiteAllowedCustomers_Customer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([CustomerId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[WebSiteAllowedCustomers] CHECK CONSTRAINT [FK_WebSiteAllowedCustomers_Customer]
GO
ALTER TABLE [dbo].[WebSiteAllowedCustomers]  WITH CHECK ADD  CONSTRAINT [FK_WebSiteAllowedCustomers_WebSite] FOREIGN KEY([WebSiteId])
REFERENCES [dbo].[WebSite] ([WebSiteId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[WebSiteAllowedCustomers] CHECK CONSTRAINT [FK_WebSiteAllowedCustomers_WebSite]
GO
ALTER TABLE [dbo].[WebSiteCarrier]  WITH CHECK ADD  CONSTRAINT [FK_WebSiteCarrier_Carrier] FOREIGN KEY([CarrierId])
REFERENCES [dbo].[Carrier] ([CarrierId])
GO
ALTER TABLE [dbo].[WebSiteCarrier] CHECK CONSTRAINT [FK_WebSiteCarrier_Carrier]
GO
ALTER TABLE [dbo].[WebSiteCarrier]  WITH CHECK ADD  CONSTRAINT [FK_WebSiteCarrier_WebSite] FOREIGN KEY([WebSiteId])
REFERENCES [dbo].[WebSite] ([WebSiteId])
GO
ALTER TABLE [dbo].[WebSiteCarrier] CHECK CONSTRAINT [FK_WebSiteCarrier_WebSite]
GO
ALTER TABLE [dbo].[WebSiteConfiguration]  WITH CHECK ADD  CONSTRAINT [FK_WebSiteConfiguration_WebSite] FOREIGN KEY([WebSiteId])
REFERENCES [dbo].[WebSite] ([WebSiteId])
GO
ALTER TABLE [dbo].[WebSiteConfiguration] CHECK CONSTRAINT [FK_WebSiteConfiguration_WebSite]
GO
ALTER TABLE [dbo].[WebSiteCountry]  WITH CHECK ADD  CONSTRAINT [FK_WebSiteCountry_Country] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Country] ([CountryId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[WebSiteCountry] CHECK CONSTRAINT [FK_WebSiteCountry_Country]
GO
ALTER TABLE [dbo].[WebSiteCountry]  WITH CHECK ADD  CONSTRAINT [FK_WebSiteCountry_WebSite] FOREIGN KEY([WebSiteId])
REFERENCES [dbo].[WebSite] ([WebSiteId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[WebSiteCountry] CHECK CONSTRAINT [FK_WebSiteCountry_WebSite]
GO
ALTER TABLE [dbo].[WebSiteCurrency]  WITH CHECK ADD  CONSTRAINT [FK_WebSiteCurrency_Currency] FOREIGN KEY([CurrencyId])
REFERENCES [dbo].[Currency] ([CurrencyId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[WebSiteCurrency] CHECK CONSTRAINT [FK_WebSiteCurrency_Currency]
GO
ALTER TABLE [dbo].[WebSiteCurrency]  WITH CHECK ADD  CONSTRAINT [FK_WebSiteCurrency_WebSite] FOREIGN KEY([WebSiteId])
REFERENCES [dbo].[WebSite] ([WebSiteId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[WebSiteCurrency] CHECK CONSTRAINT [FK_WebSiteCurrency_WebSite]
GO
ALTER TABLE [dbo].[WebSiteDealer]  WITH CHECK ADD  CONSTRAINT [FK_WebSiteDealer_Dealer] FOREIGN KEY([DealerId])
REFERENCES [dbo].[Dealer] ([DealerId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[WebSiteDealer] CHECK CONSTRAINT [FK_WebSiteDealer_Dealer]
GO
ALTER TABLE [dbo].[WebSiteDealer]  WITH CHECK ADD  CONSTRAINT [FK_WebSiteDealer_WebSite] FOREIGN KEY([WebSiteId])
REFERENCES [dbo].[WebSite] ([WebSiteId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[WebSiteDealer] CHECK CONSTRAINT [FK_WebSiteDealer_WebSite]
GO
ALTER TABLE [dbo].[WebSiteLanguage]  WITH CHECK ADD  CONSTRAINT [FK_WebSiteLanguage_Language] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[Language] ([LanguageId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[WebSiteLanguage] CHECK CONSTRAINT [FK_WebSiteLanguage_Language]
GO
ALTER TABLE [dbo].[WebSiteLanguage]  WITH CHECK ADD  CONSTRAINT [FK_WebSiteLanguage_WebSite] FOREIGN KEY([WebSiteId])
REFERENCES [dbo].[WebSite] ([WebSiteId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[WebSiteLanguage] CHECK CONSTRAINT [FK_WebSiteLanguage_WebSite]
GO
ALTER TABLE [dbo].[WebSiteProductCrossSell]  WITH CHECK ADD  CONSTRAINT [FK_WebSiteProductCrossSell_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ProductId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[WebSiteProductCrossSell] CHECK CONSTRAINT [FK_WebSiteProductCrossSell_Product]
GO
ALTER TABLE [dbo].[WebSiteProductCrossSell]  WITH CHECK ADD  CONSTRAINT [FK_WebSiteProductCrossSell_WebSite] FOREIGN KEY([WebSiteId])
REFERENCES [dbo].[WebSite] ([WebSiteId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[WebSiteProductCrossSell] CHECK CONSTRAINT [FK_WebSiteProductCrossSell_WebSite]
GO
ALTER TABLE [dbo].[WebSitePromotion]  WITH CHECK ADD  CONSTRAINT [FK_WebSitePromotion_Promotion] FOREIGN KEY([PromotionId])
REFERENCES [dbo].[Promotion] ([PromotionId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[WebSitePromotion] CHECK CONSTRAINT [FK_WebSitePromotion_Promotion]
GO
ALTER TABLE [dbo].[WebSitePromotion]  WITH CHECK ADD  CONSTRAINT [FK_WebSitePromotion_WebSite] FOREIGN KEY([WebSiteId])
REFERENCES [dbo].[WebSite] ([WebSiteId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[WebSitePromotion] CHECK CONSTRAINT [FK_WebSitePromotion_WebSite]
GO
ALTER TABLE [dbo].[WebSiteState]  WITH CHECK ADD  CONSTRAINT [FK_WebSiteState_State] FOREIGN KEY([StateId])
REFERENCES [dbo].[State] ([StateId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[WebSiteState] CHECK CONSTRAINT [FK_WebSiteState_State]
GO
ALTER TABLE [dbo].[WebSiteState]  WITH CHECK ADD  CONSTRAINT [FK_WebSiteState_WebSite] FOREIGN KEY([WebSiteId])
REFERENCES [dbo].[WebSite] ([WebSiteId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[WebSiteState] CHECK CONSTRAINT [FK_WebSiteState_WebSite]
GO
ALTER TABLE [dbo].[WishList]  WITH CHECK ADD  CONSTRAINT [FK_UserProfileId] FOREIGN KEY([UserProfileId])
REFERENCES [dbo].[UserProfile] ([UserProfileId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[WishList] CHECK CONSTRAINT [FK_UserProfileId]
GO
ALTER TABLE [dbo].[WishList]  WITH CHECK ADD  CONSTRAINT [FK_WishList_Customer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([CustomerId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[WishList] CHECK CONSTRAINT [FK_WishList_Customer]
GO
ALTER TABLE [dbo].[WishListProduct]  WITH CHECK ADD  CONSTRAINT [FK_Product_Id] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ProductId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[WishListProduct] CHECK CONSTRAINT [FK_Product_Id]
GO
ALTER TABLE [dbo].[WishListProduct]  WITH CHECK ADD  CONSTRAINT [FK_WishList_Id] FOREIGN KEY([WishListId])
REFERENCES [dbo].[WishList] ([WishListId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[WishListProduct] CHECK CONSTRAINT [FK_WishList_Id]
GO
ALTER TABLE [dbo].[ApplicationSetting]  WITH NOCHECK ADD  CONSTRAINT [CK_ApplicationSetting_Name] CHECK  ((len([Name])>(0)))
GO
ALTER TABLE [dbo].[ApplicationSetting] CHECK CONSTRAINT [CK_ApplicationSetting_Name]
GO
ALTER TABLE [dbo].[Carrier]  WITH NOCHECK ADD  CONSTRAINT [CK_Carrier_Name] CHECK  ((len([Name])>(0)))
GO
ALTER TABLE [dbo].[Carrier] CHECK CONSTRAINT [CK_Carrier_Name]
GO
ALTER TABLE [dbo].[Category]  WITH NOCHECK ADD  CONSTRAINT [CK_Category_Name] CHECK  ((len([Name])>(0)))
GO
ALTER TABLE [dbo].[Category] CHECK CONSTRAINT [CK_Category_Name]
GO
ALTER TABLE [dbo].[City]  WITH NOCHECK ADD  CONSTRAINT [CK_City_Name] CHECK  ((len([CityName])>(0)))
GO
ALTER TABLE [dbo].[City] CHECK CONSTRAINT [CK_City_Name]
GO
ALTER TABLE [dbo].[Company]  WITH NOCHECK ADD  CONSTRAINT [CK_Company_Name] CHECK  ((len([Name])>(0)))
GO
ALTER TABLE [dbo].[Company] CHECK CONSTRAINT [CK_Company_Name]
GO
ALTER TABLE [dbo].[Country]  WITH NOCHECK ADD  CONSTRAINT [CK_Country_Name] CHECK  ((len([Name])>(0)))
GO
ALTER TABLE [dbo].[Country] CHECK CONSTRAINT [CK_Country_Name]
GO
ALTER TABLE [dbo].[County]  WITH NOCHECK ADD  CONSTRAINT [CK_County_Name] CHECK  ((len([Name])>(0)))
GO
ALTER TABLE [dbo].[County] CHECK CONSTRAINT [CK_County_Name]
GO
ALTER TABLE [dbo].[Customer]  WITH NOCHECK ADD  CONSTRAINT [CK_Customer_Number] CHECK  ((len([CustomerNumber])>(0)))
GO
ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [CK_Customer_Number]
GO
ALTER TABLE [dbo].[Dealer]  WITH NOCHECK ADD  CONSTRAINT [CK_Dealer_Name] CHECK  ((len([Name])>(0)))
GO
ALTER TABLE [dbo].[Dealer] CHECK CONSTRAINT [CK_Dealer_Name]
GO
ALTER TABLE [dbo].[EmailList]  WITH NOCHECK ADD  CONSTRAINT [CK_EmailList_Name] CHECK  ((len([Name])>(0)))
GO
ALTER TABLE [dbo].[EmailList] CHECK CONSTRAINT [CK_EmailList_Name]
GO
ALTER TABLE [dbo].[EmailTemplate]  WITH NOCHECK ADD  CONSTRAINT [CK_EmailTemplate_Name] CHECK  ((len([Name])>(0)))
GO
ALTER TABLE [dbo].[EmailTemplate] CHECK CONSTRAINT [CK_EmailTemplate_Name]
GO
ALTER TABLE [dbo].[FilterSection]  WITH NOCHECK ADD  CONSTRAINT [CK_FilterSection_Name] CHECK  ((len([Name])>(0)))
GO
ALTER TABLE [dbo].[FilterSection] CHECK CONSTRAINT [CK_FilterSection_Name]
GO
ALTER TABLE [dbo].[GiftCard]  WITH NOCHECK ADD  CONSTRAINT [CK_GiftCard_GiftCardNumber] CHECK  ((len([GiftCardNumber])>(0)))
GO
ALTER TABLE [dbo].[GiftCard] CHECK CONSTRAINT [CK_GiftCard_GiftCardNumber]
GO
ALTER TABLE [dbo].[LocalTaxRate]  WITH NOCHECK ADD  CONSTRAINT [CK_LocalTaxRate_Zip] CHECK  ((len([Zip])>(0)))
GO
ALTER TABLE [dbo].[LocalTaxRate] CHECK CONSTRAINT [CK_LocalTaxRate_Zip]
GO
ALTER TABLE [dbo].[PaymentTerm]  WITH NOCHECK ADD  CONSTRAINT [CK_PaymentTerm_TermsCode] CHECK  ((len([TermsCode])>(0)))
GO
ALTER TABLE [dbo].[PaymentTerm] CHECK CONSTRAINT [CK_PaymentTerm_TermsCode]
GO
ALTER TABLE [dbo].[Persona]  WITH CHECK ADD  CONSTRAINT [CK_Persona_Name] CHECK  ((len([Name])>(0)))
GO
ALTER TABLE [dbo].[Persona] CHECK CONSTRAINT [CK_Persona_Name]
GO
ALTER TABLE [dbo].[Product]  WITH NOCHECK ADD  CONSTRAINT [CK_Product_Name] CHECK  ((len([Name])>(0)))
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [CK_Product_Name]
GO
ALTER TABLE [dbo].[Promotion]  WITH NOCHECK ADD  CONSTRAINT [CK_Promotion_Name] CHECK  ((len([Name])>(0)))
GO
ALTER TABLE [dbo].[Promotion] CHECK CONSTRAINT [CK_Promotion_Name]
GO
ALTER TABLE [dbo].[RuleTypeOption]  WITH NOCHECK ADD  CONSTRAINT [CK_RuleTypeOption_Description] CHECK  ((len([Description])>(0)))
GO
ALTER TABLE [dbo].[RuleTypeOption] CHECK CONSTRAINT [CK_RuleTypeOption_Description]
GO
ALTER TABLE [dbo].[Salesman]  WITH NOCHECK ADD  CONSTRAINT [CK_Salesman_SalesmanNumber] CHECK  ((len([SalesmanNumber])>(0)))
GO
ALTER TABLE [dbo].[Salesman] CHECK CONSTRAINT [CK_Salesman_SalesmanNumber]
GO
ALTER TABLE [dbo].[ShipVia]  WITH NOCHECK ADD  CONSTRAINT [CK_ShipVia_ShipCode] CHECK  ((len([ShipCode])>(0)))
GO
ALTER TABLE [dbo].[ShipVia] CHECK CONSTRAINT [CK_ShipVia_ShipCode]
GO
ALTER TABLE [dbo].[State]  WITH NOCHECK ADD  CONSTRAINT [CK_State_Name] CHECK  ((len([Name])>(0)))
GO
ALTER TABLE [dbo].[State] CHECK CONSTRAINT [CK_State_Name]
GO
ALTER TABLE [dbo].[StyleClass]  WITH NOCHECK ADD  CONSTRAINT [CK_StyleClass_Name] CHECK  ((len([Name])>(0)))
GO
ALTER TABLE [dbo].[StyleClass] CHECK CONSTRAINT [CK_StyleClass_Name]
GO
ALTER TABLE [dbo].[WebPage]  WITH NOCHECK ADD  CONSTRAINT [CK_WebPage_Name] CHECK  ((len([Name])>(0)))
GO
ALTER TABLE [dbo].[WebPage] CHECK CONSTRAINT [CK_WebPage_Name]
GO
ALTER TABLE [dbo].[WebPageContent]  WITH NOCHECK ADD  CONSTRAINT [CK_WebPageContent_Name] CHECK  ((len([Name])>(0)))
GO
ALTER TABLE [dbo].[WebPageContent] CHECK CONSTRAINT [CK_WebPageContent_Name]
GO
ALTER TABLE [dbo].[WebSite]  WITH NOCHECK ADD  CONSTRAINT [CK_WebSite_Name] CHECK  ((len([Name])>(0)))
GO
ALTER TABLE [dbo].[WebSite] CHECK CONSTRAINT [CK_WebSite_Name]
GO
ALTER TABLE [dbo].[WishList]  WITH NOCHECK ADD  CONSTRAINT [CK_WishList_Name] CHECK  ((len([Name])>(0)))
GO
ALTER TABLE [dbo].[WishList] CHECK CONSTRAINT [CK_WishList_Name]
GO
/****** Object:  StoredProcedure [dbo].[aspnet_AnyDataInTables]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_AnyDataInTables]
    @TablesToCheck int
AS
BEGIN
    -- Check Membership table if (@TablesToCheck & 1) is set
    IF ((@TablesToCheck & 1) <> 0 AND
        (EXISTS (SELECT name FROM sysobjects WHERE (name = N'vw_aspnet_MembershipUsers') AND (type = 'V'))))
    BEGIN
        IF (EXISTS(SELECT TOP 1 UserId FROM dbo.aspnet_Membership))
        BEGIN
            SELECT N'aspnet_Membership'
            RETURN
        END
    END

    -- Check aspnet_Roles table if (@TablesToCheck & 2) is set
    IF ((@TablesToCheck & 2) <> 0  AND
        (EXISTS (SELECT name FROM sysobjects WHERE (name = N'vw_aspnet_Roles') AND (type = 'V'))) )
    BEGIN
        IF (EXISTS(SELECT TOP 1 RoleId FROM dbo.aspnet_Roles))
        BEGIN
            SELECT N'aspnet_Roles'
            RETURN
        END
    END

    -- Check aspnet_Profile table if (@TablesToCheck & 4) is set
    IF ((@TablesToCheck & 4) <> 0  AND
        (EXISTS (SELECT name FROM sysobjects WHERE (name = N'vw_aspnet_Profiles') AND (type = 'V'))) )
    BEGIN
        IF (EXISTS(SELECT TOP 1 UserId FROM dbo.aspnet_Profile))
        BEGIN
            SELECT N'aspnet_Profile'
            RETURN
        END
    END

    -- Check aspnet_PersonalizationPerUser table if (@TablesToCheck & 8) is set
    IF ((@TablesToCheck & 8) <> 0  AND
        (EXISTS (SELECT name FROM sysobjects WHERE (name = N'vw_aspnet_WebPartState_User') AND (type = 'V'))) )
    BEGIN
        IF (EXISTS(SELECT TOP 1 UserId FROM dbo.aspnet_PersonalizationPerUser))
        BEGIN
            SELECT N'aspnet_PersonalizationPerUser'
            RETURN
        END
    END

    -- Check aspnet_PersonalizationPerUser table if (@TablesToCheck & 16) is set
    IF ((@TablesToCheck & 16) <> 0  AND
        (EXISTS (SELECT name FROM sysobjects WHERE (name = N'aspnet_WebEvent_LogEvent') AND (type = 'P'))) )
    BEGIN
        IF (EXISTS(SELECT TOP 1 * FROM dbo.aspnet_WebEvent_Events))
        BEGIN
            SELECT N'aspnet_WebEvent_Events'
            RETURN
        END
    END

    -- Check aspnet_Users table if (@TablesToCheck & 1,2,4 & 8) are all set
    IF ((@TablesToCheck & 1) <> 0 AND
        (@TablesToCheck & 2) <> 0 AND
        (@TablesToCheck & 4) <> 0 AND
        (@TablesToCheck & 8) <> 0 AND
        (@TablesToCheck & 32) <> 0 AND
        (@TablesToCheck & 128) <> 0 AND
        (@TablesToCheck & 256) <> 0 AND
        (@TablesToCheck & 512) <> 0 AND
        (@TablesToCheck & 1024) <> 0)
    BEGIN
        IF (EXISTS(SELECT TOP 1 UserId FROM dbo.aspnet_Users))
        BEGIN
            SELECT N'aspnet_Users'
            RETURN
        END
        IF (EXISTS(SELECT TOP 1 ApplicationId FROM dbo.aspnet_Applications))
        BEGIN
            SELECT N'aspnet_Applications'
            RETURN
        END
    END
END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_Applications_CreateApplication]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[aspnet_Applications_CreateApplication]
    @ApplicationName      nvarchar(256),
    @ApplicationId        uniqueidentifier OUTPUT
AS
BEGIN
    SELECT  @ApplicationId = ApplicationId FROM dbo.aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName

    IF(@ApplicationId IS NULL)
    BEGIN
        DECLARE @TranStarted   bit
        SET @TranStarted = 0

        IF( @@TRANCOUNT = 0 )
        BEGIN
	        BEGIN TRANSACTION
	        SET @TranStarted = 1
        END
        ELSE
    	    SET @TranStarted = 0

        SELECT  @ApplicationId = ApplicationId
        FROM dbo.aspnet_Applications WITH (UPDLOCK, HOLDLOCK)
        WHERE LOWER(@ApplicationName) = LoweredApplicationName

        IF(@ApplicationId IS NULL)
        BEGIN
            SELECT  @ApplicationId = NEWID()
            INSERT  dbo.aspnet_Applications (ApplicationId, ApplicationName, LoweredApplicationName)
            VALUES  (@ApplicationId, @ApplicationName, LOWER(@ApplicationName))
        END


        IF( @TranStarted = 1 )
        BEGIN
            IF(@@ERROR = 0)
            BEGIN
	        SET @TranStarted = 0
	        COMMIT TRANSACTION
            END
            ELSE
            BEGIN
                SET @TranStarted = 0
                ROLLBACK TRANSACTION
            END
        END
    END
END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_CheckSchemaVersion]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[aspnet_CheckSchemaVersion]
    @Feature                   nvarchar(128),
    @CompatibleSchemaVersion   nvarchar(128)
AS
BEGIN
    IF (EXISTS( SELECT  *
                FROM    dbo.aspnet_SchemaVersions
                WHERE   Feature = LOWER( @Feature ) AND
                        CompatibleSchemaVersion = @CompatibleSchemaVersion ))
        RETURN 0

    RETURN 1
END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_Membership_ChangePasswordQuestionAndAnswer]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Membership_ChangePasswordQuestionAndAnswer]
    @ApplicationName       nvarchar(256),
    @UserName              nvarchar(256),
    @NewPasswordQuestion   nvarchar(256),
    @NewPasswordAnswer     nvarchar(128)
AS
BEGIN
    DECLARE @UserId uniqueidentifier
    SELECT  @UserId = NULL
    SELECT  @UserId = u.UserId
    FROM    dbo.aspnet_Membership m, dbo.aspnet_Users u, dbo.aspnet_Applications a
    WHERE   LoweredUserName = LOWER(@UserName) AND
            u.ApplicationId = a.ApplicationId  AND
            LOWER(@ApplicationName) = a.LoweredApplicationName AND
            u.UserId = m.UserId
    IF (@UserId IS NULL)
    BEGIN
        RETURN(1)
    END

    UPDATE dbo.aspnet_Membership
    SET    PasswordQuestion = @NewPasswordQuestion, PasswordAnswer = @NewPasswordAnswer
    WHERE  UserId=@UserId
    RETURN(0)
END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_Membership_CreateUser]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Membership_CreateUser]
    @ApplicationName                        nvarchar(256),
    @UserName                               nvarchar(256),
    @Password                               nvarchar(128),
    @PasswordSalt                           nvarchar(128),
    @Email                                  nvarchar(256),
    @PasswordQuestion                       nvarchar(256),
    @PasswordAnswer                         nvarchar(128),
    @IsApproved                             bit,
    @CurrentTimeUtc                         datetime,
    @CreateDate                             datetime = NULL,
    @UniqueEmail                            int      = 0,
    @PasswordFormat                         int      = 0,
    @UserId                                 uniqueidentifier OUTPUT
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL

    DECLARE @NewUserId uniqueidentifier
    SELECT @NewUserId = NULL

    DECLARE @IsLockedOut bit
    SET @IsLockedOut = 0

    DECLARE @LastLockoutDate  datetime
    SET @LastLockoutDate = CONVERT( datetime, '17540101', 112 )

    DECLARE @FailedPasswordAttemptCount int
    SET @FailedPasswordAttemptCount = 0

    DECLARE @FailedPasswordAttemptWindowStart  datetime
    SET @FailedPasswordAttemptWindowStart = CONVERT( datetime, '17540101', 112 )

    DECLARE @FailedPasswordAnswerAttemptCount int
    SET @FailedPasswordAnswerAttemptCount = 0

    DECLARE @FailedPasswordAnswerAttemptWindowStart  datetime
    SET @FailedPasswordAnswerAttemptWindowStart = CONVERT( datetime, '17540101', 112 )

    DECLARE @NewUserCreated bit
    DECLARE @ReturnValue   int
    SET @ReturnValue = 0

    DECLARE @ErrorCode     int
    SET @ErrorCode = 0

    DECLARE @TranStarted   bit
    SET @TranStarted = 0

    IF( @@TRANCOUNT = 0 )
    BEGIN
	    BEGIN TRANSACTION
	    SET @TranStarted = 1
    END
    ELSE
    	SET @TranStarted = 0

    EXEC dbo.aspnet_Applications_CreateApplication @ApplicationName, @ApplicationId OUTPUT

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    SET @CreateDate = @CurrentTimeUtc

    SELECT  @NewUserId = UserId FROM dbo.aspnet_Users WHERE LOWER(@UserName) = LoweredUserName AND @ApplicationId = ApplicationId
    IF ( @NewUserId IS NULL )
    BEGIN
        SET @NewUserId = @UserId
        EXEC @ReturnValue = dbo.aspnet_Users_CreateUser @ApplicationId, @UserName, 0, @CreateDate, @NewUserId OUTPUT
        SET @NewUserCreated = 1
    END
    ELSE
    BEGIN
        SET @NewUserCreated = 0
        IF( @NewUserId <> @UserId AND @UserId IS NOT NULL )
        BEGIN
            SET @ErrorCode = 6
            GOTO Cleanup
        END
    END

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    IF( @ReturnValue = -1 )
    BEGIN
        SET @ErrorCode = 10
        GOTO Cleanup
    END

    IF ( EXISTS ( SELECT UserId
                  FROM   dbo.aspnet_Membership
                  WHERE  @NewUserId = UserId ) )
    BEGIN
        SET @ErrorCode = 6
        GOTO Cleanup
    END

    SET @UserId = @NewUserId

    IF (@UniqueEmail = 1)
    BEGIN
        IF (EXISTS (SELECT *
                    FROM  dbo.aspnet_Membership m WITH ( UPDLOCK, HOLDLOCK )
                    WHERE ApplicationId = @ApplicationId AND LoweredEmail = LOWER(@Email)))
        BEGIN
            SET @ErrorCode = 7
            GOTO Cleanup
        END
    END

    IF (@NewUserCreated = 0)
    BEGIN
        UPDATE dbo.aspnet_Users
        SET    LastActivityDate = @CreateDate
        WHERE  @UserId = UserId
        IF( @@ERROR <> 0 )
        BEGIN
            SET @ErrorCode = -1
            GOTO Cleanup
        END
    END

    INSERT INTO dbo.aspnet_Membership
                ( ApplicationId,
                  UserId,
                  Password,
                  PasswordSalt,
                  Email,
                  LoweredEmail,
                  PasswordQuestion,
                  PasswordAnswer,
                  PasswordFormat,
                  IsApproved,
                  IsLockedOut,
                  CreateDate,
                  LastLoginDate,
                  LastPasswordChangedDate,
                  LastLockoutDate,
                  FailedPasswordAttemptCount,
                  FailedPasswordAttemptWindowStart,
                  FailedPasswordAnswerAttemptCount,
                  FailedPasswordAnswerAttemptWindowStart )
         VALUES ( @ApplicationId,
                  @UserId,
                  @Password,
                  @PasswordSalt,
                  @Email,
                  LOWER(@Email),
                  @PasswordQuestion,
                  @PasswordAnswer,
                  @PasswordFormat,
                  @IsApproved,
                  @IsLockedOut,
                  @CreateDate,
                  @CreateDate,
                  @CreateDate,
                  @LastLockoutDate,
                  @FailedPasswordAttemptCount,
                  @FailedPasswordAttemptWindowStart,
                  @FailedPasswordAnswerAttemptCount,
                  @FailedPasswordAnswerAttemptWindowStart )

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    IF( @TranStarted = 1 )
    BEGIN
	    SET @TranStarted = 0
	    COMMIT TRANSACTION
    END

    RETURN 0

Cleanup:

    IF( @TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
    	ROLLBACK TRANSACTION
    END

    RETURN @ErrorCode

END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_Membership_FindUsersByEmail]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Membership_FindUsersByEmail]
    @ApplicationName       nvarchar(256),
    @EmailToMatch          nvarchar(256),
    @PageIndex             int,
    @PageSize              int
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM dbo.aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
        RETURN 0

    -- Set the page bounds
    DECLARE @PageLowerBound int
    DECLARE @PageUpperBound int
    DECLARE @TotalRecords   int
    SET @PageLowerBound = @PageSize * @PageIndex
    SET @PageUpperBound = @PageSize - 1 + @PageLowerBound

    -- Create a temp table TO store the select results
    CREATE TABLE #PageIndexForUsers
    (
        IndexId int IDENTITY (0, 1) NOT NULL,
        UserId uniqueidentifier
    )

    -- Insert into our temp table
    IF( @EmailToMatch IS NULL )
        INSERT INTO #PageIndexForUsers (UserId)
            SELECT u.UserId
            FROM   dbo.aspnet_Users u, dbo.aspnet_Membership m
            WHERE  u.ApplicationId = @ApplicationId AND m.UserId = u.UserId AND m.Email IS NULL
            ORDER BY m.LoweredEmail
    ELSE
        INSERT INTO #PageIndexForUsers (UserId)
            SELECT u.UserId
            FROM   dbo.aspnet_Users u, dbo.aspnet_Membership m
            WHERE  u.ApplicationId = @ApplicationId AND m.UserId = u.UserId AND m.LoweredEmail LIKE LOWER(@EmailToMatch)
            ORDER BY m.LoweredEmail

    SELECT  u.UserName, m.Email, m.PasswordQuestion, m.Comment, m.IsApproved,
            m.CreateDate,
            m.LastLoginDate,
            u.LastActivityDate,
            m.LastPasswordChangedDate,
            u.UserId, m.IsLockedOut,
            m.LastLockoutDate
    FROM   dbo.aspnet_Membership m, dbo.aspnet_Users u, #PageIndexForUsers p
    WHERE  u.UserId = p.UserId AND u.UserId = m.UserId AND
           p.IndexId >= @PageLowerBound AND p.IndexId <= @PageUpperBound
    ORDER BY m.LoweredEmail

    SELECT  @TotalRecords = COUNT(*)
    FROM    #PageIndexForUsers
    RETURN @TotalRecords
END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_Membership_FindUsersByName]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Membership_FindUsersByName]
    @ApplicationName       nvarchar(256),
    @UserNameToMatch       nvarchar(256),
    @PageIndex             int,
    @PageSize              int
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM dbo.aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
        RETURN 0

    -- Set the page bounds
    DECLARE @PageLowerBound int
    DECLARE @PageUpperBound int
    DECLARE @TotalRecords   int
    SET @PageLowerBound = @PageSize * @PageIndex
    SET @PageUpperBound = @PageSize - 1 + @PageLowerBound

    -- Create a temp table TO store the select results
    CREATE TABLE #PageIndexForUsers
    (
        IndexId int IDENTITY (0, 1) NOT NULL,
        UserId uniqueidentifier
    )

    -- Insert into our temp table
    INSERT INTO #PageIndexForUsers (UserId)
        SELECT u.UserId
        FROM   dbo.aspnet_Users u, dbo.aspnet_Membership m
        WHERE  u.ApplicationId = @ApplicationId AND m.UserId = u.UserId AND u.LoweredUserName LIKE LOWER(@UserNameToMatch)
        ORDER BY u.UserName


    SELECT  u.UserName, m.Email, m.PasswordQuestion, m.Comment, m.IsApproved,
            m.CreateDate,
            m.LastLoginDate,
            u.LastActivityDate,
            m.LastPasswordChangedDate,
            u.UserId, m.IsLockedOut,
            m.LastLockoutDate
    FROM   dbo.aspnet_Membership m, dbo.aspnet_Users u, #PageIndexForUsers p
    WHERE  u.UserId = p.UserId AND u.UserId = m.UserId AND
           p.IndexId >= @PageLowerBound AND p.IndexId <= @PageUpperBound
    ORDER BY u.UserName

    SELECT  @TotalRecords = COUNT(*)
    FROM    #PageIndexForUsers
    RETURN @TotalRecords
END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_Membership_GetAllUsers]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Membership_GetAllUsers]
    @ApplicationName       nvarchar(256),
    @PageIndex             int,
    @PageSize              int
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM dbo.aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
        RETURN 0


    -- Set the page bounds
    DECLARE @PageLowerBound int
    DECLARE @PageUpperBound int
    DECLARE @TotalRecords   int
    SET @PageLowerBound = @PageSize * @PageIndex
    SET @PageUpperBound = @PageSize - 1 + @PageLowerBound

    -- Create a temp table TO store the select results
    CREATE TABLE #PageIndexForUsers
    (
        IndexId int IDENTITY (0, 1) NOT NULL,
        UserId uniqueidentifier
    )

    -- Insert into our temp table
    INSERT INTO #PageIndexForUsers (UserId)
    SELECT u.UserId
    FROM   dbo.aspnet_Membership m, dbo.aspnet_Users u
    WHERE  u.ApplicationId = @ApplicationId AND u.UserId = m.UserId
    ORDER BY u.UserName

    SELECT @TotalRecords = @@ROWCOUNT

    SELECT u.UserName, m.Email, m.PasswordQuestion, m.Comment, m.IsApproved,
            m.CreateDate,
            m.LastLoginDate,
            u.LastActivityDate,
            m.LastPasswordChangedDate,
            u.UserId, m.IsLockedOut,
            m.LastLockoutDate
    FROM   dbo.aspnet_Membership m, dbo.aspnet_Users u, #PageIndexForUsers p
    WHERE  u.UserId = p.UserId AND u.UserId = m.UserId AND
           p.IndexId >= @PageLowerBound AND p.IndexId <= @PageUpperBound
    ORDER BY u.UserName
    RETURN @TotalRecords
END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_Membership_GetNumberOfUsersOnline]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Membership_GetNumberOfUsersOnline]
    @ApplicationName            nvarchar(256),
    @MinutesSinceLastInActive   int,
    @CurrentTimeUtc             datetime
AS
BEGIN
    DECLARE @DateActive datetime
    SELECT  @DateActive = DATEADD(minute,  -(@MinutesSinceLastInActive), @CurrentTimeUtc)

    DECLARE @NumOnline int
    SELECT  @NumOnline = COUNT(*)
    FROM    dbo.aspnet_Users u(NOLOCK),
            dbo.aspnet_Applications a(NOLOCK),
            dbo.aspnet_Membership m(NOLOCK)
    WHERE   u.ApplicationId = a.ApplicationId                  AND
            LastActivityDate > @DateActive                     AND
            a.LoweredApplicationName = LOWER(@ApplicationName) AND
            u.UserId = m.UserId
    RETURN(@NumOnline)
END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_Membership_GetPassword]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Membership_GetPassword]
    @ApplicationName                nvarchar(256),
    @UserName                       nvarchar(256),
    @MaxInvalidPasswordAttempts     int,
    @PasswordAttemptWindow          int,
    @CurrentTimeUtc                 datetime,
    @PasswordAnswer                 nvarchar(128) = NULL
AS
BEGIN
    DECLARE @UserId                                 uniqueidentifier
    DECLARE @PasswordFormat                         int
    DECLARE @Password                               nvarchar(128)
    DECLARE @passAns                                nvarchar(128)
    DECLARE @IsLockedOut                            bit
    DECLARE @LastLockoutDate                        datetime
    DECLARE @FailedPasswordAttemptCount             int
    DECLARE @FailedPasswordAttemptWindowStart       datetime
    DECLARE @FailedPasswordAnswerAttemptCount       int
    DECLARE @FailedPasswordAnswerAttemptWindowStart datetime

    DECLARE @ErrorCode     int
    SET @ErrorCode = 0

    DECLARE @TranStarted   bit
    SET @TranStarted = 0

    IF( @@TRANCOUNT = 0 )
    BEGIN
	    BEGIN TRANSACTION
	    SET @TranStarted = 1
    END
    ELSE
    	SET @TranStarted = 0

    SELECT  @UserId = u.UserId,
            @Password = m.Password,
            @passAns = m.PasswordAnswer,
            @PasswordFormat = m.PasswordFormat,
            @IsLockedOut = m.IsLockedOut,
            @LastLockoutDate = m.LastLockoutDate,
            @FailedPasswordAttemptCount = m.FailedPasswordAttemptCount,
            @FailedPasswordAttemptWindowStart = m.FailedPasswordAttemptWindowStart,
            @FailedPasswordAnswerAttemptCount = m.FailedPasswordAnswerAttemptCount,
            @FailedPasswordAnswerAttemptWindowStart = m.FailedPasswordAnswerAttemptWindowStart
    FROM    dbo.aspnet_Applications a, dbo.aspnet_Users u, dbo.aspnet_Membership m WITH ( UPDLOCK )
    WHERE   LOWER(@ApplicationName) = a.LoweredApplicationName AND
            u.ApplicationId = a.ApplicationId    AND
            u.UserId = m.UserId AND
            LOWER(@UserName) = u.LoweredUserName

    IF ( @@rowcount = 0 )
    BEGIN
        SET @ErrorCode = 1
        GOTO Cleanup
    END

    IF( @IsLockedOut = 1 )
    BEGIN
        SET @ErrorCode = 99
        GOTO Cleanup
    END

    IF ( NOT( @PasswordAnswer IS NULL ) )
    BEGIN
        IF( ( @passAns IS NULL ) OR ( LOWER( @passAns ) <> LOWER( @PasswordAnswer ) ) )
        BEGIN
            IF( @CurrentTimeUtc > DATEADD( minute, @PasswordAttemptWindow, @FailedPasswordAnswerAttemptWindowStart ) )
            BEGIN
                SET @FailedPasswordAnswerAttemptWindowStart = @CurrentTimeUtc
                SET @FailedPasswordAnswerAttemptCount = 1
            END
            ELSE
            BEGIN
                SET @FailedPasswordAnswerAttemptCount = @FailedPasswordAnswerAttemptCount + 1
                SET @FailedPasswordAnswerAttemptWindowStart = @CurrentTimeUtc
            END

            BEGIN
                IF( @FailedPasswordAnswerAttemptCount >= @MaxInvalidPasswordAttempts )
                BEGIN
                    SET @IsLockedOut = 1
                    SET @LastLockoutDate = @CurrentTimeUtc
                END
            END

            SET @ErrorCode = 3
        END
        ELSE
        BEGIN
            IF( @FailedPasswordAnswerAttemptCount > 0 )
            BEGIN
                SET @FailedPasswordAnswerAttemptCount = 0
                SET @FailedPasswordAnswerAttemptWindowStart = CONVERT( datetime, '17540101', 112 )
            END
        END

        UPDATE dbo.aspnet_Membership
        SET IsLockedOut = @IsLockedOut, LastLockoutDate = @LastLockoutDate,
            FailedPasswordAttemptCount = @FailedPasswordAttemptCount,
            FailedPasswordAttemptWindowStart = @FailedPasswordAttemptWindowStart,
            FailedPasswordAnswerAttemptCount = @FailedPasswordAnswerAttemptCount,
            FailedPasswordAnswerAttemptWindowStart = @FailedPasswordAnswerAttemptWindowStart
        WHERE @UserId = UserId

        IF( @@ERROR <> 0 )
        BEGIN
            SET @ErrorCode = -1
            GOTO Cleanup
        END
    END

    IF( @TranStarted = 1 )
    BEGIN
	SET @TranStarted = 0
	COMMIT TRANSACTION
    END

    IF( @ErrorCode = 0 )
        SELECT @Password, @PasswordFormat

    RETURN @ErrorCode

Cleanup:

    IF( @TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
    	ROLLBACK TRANSACTION
    END

    RETURN @ErrorCode

END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_Membership_GetPasswordWithFormat]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Membership_GetPasswordWithFormat]
    @ApplicationName                nvarchar(256),
    @UserName                       nvarchar(256),
    @UpdateLastLoginActivityDate    bit,
    @CurrentTimeUtc                 datetime
AS
BEGIN
    DECLARE @IsLockedOut                        bit
    DECLARE @UserId                             uniqueidentifier
    DECLARE @Password                           nvarchar(128)
    DECLARE @PasswordSalt                       nvarchar(128)
    DECLARE @PasswordFormat                     int
    DECLARE @FailedPasswordAttemptCount         int
    DECLARE @FailedPasswordAnswerAttemptCount   int
    DECLARE @IsApproved                         bit
    DECLARE @LastActivityDate                   datetime
    DECLARE @LastLoginDate                      datetime

    SELECT  @UserId          = NULL

    SELECT  @UserId = u.UserId, @IsLockedOut = m.IsLockedOut, @Password=Password, @PasswordFormat=PasswordFormat,
            @PasswordSalt=PasswordSalt, @FailedPasswordAttemptCount=FailedPasswordAttemptCount,
		    @FailedPasswordAnswerAttemptCount=FailedPasswordAnswerAttemptCount, @IsApproved=IsApproved,
            @LastActivityDate = LastActivityDate, @LastLoginDate = LastLoginDate
    FROM    dbo.aspnet_Applications a, dbo.aspnet_Users u, dbo.aspnet_Membership m
    WHERE   LOWER(@ApplicationName) = a.LoweredApplicationName AND
            u.ApplicationId = a.ApplicationId    AND
            u.UserId = m.UserId AND
            LOWER(@UserName) = u.LoweredUserName

    IF (@UserId IS NULL)
        RETURN 1

    IF (@IsLockedOut = 1)
        RETURN 99

    SELECT   @Password, @PasswordFormat, @PasswordSalt, @FailedPasswordAttemptCount,
             @FailedPasswordAnswerAttemptCount, @IsApproved, @LastLoginDate, @LastActivityDate

    IF (@UpdateLastLoginActivityDate = 1 AND @IsApproved = 1)
    BEGIN
        UPDATE  dbo.aspnet_Membership
        SET     LastLoginDate = @CurrentTimeUtc
        WHERE   UserId = @UserId

        UPDATE  dbo.aspnet_Users
        SET     LastActivityDate = @CurrentTimeUtc
        WHERE   @UserId = UserId
    END


    RETURN 0
END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_Membership_GetUserByEmail]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Membership_GetUserByEmail]
    @ApplicationName  nvarchar(256),
    @Email            nvarchar(256)
AS
BEGIN
    IF( @Email IS NULL )
        SELECT  u.UserName
        FROM    dbo.aspnet_Applications a, dbo.aspnet_Users u, dbo.aspnet_Membership m
        WHERE   LOWER(@ApplicationName) = a.LoweredApplicationName AND
                u.ApplicationId = a.ApplicationId    AND
                u.UserId = m.UserId AND
                m.LoweredEmail IS NULL
    ELSE
        SELECT  u.UserName
        FROM    dbo.aspnet_Applications a, dbo.aspnet_Users u, dbo.aspnet_Membership m
        WHERE   LOWER(@ApplicationName) = a.LoweredApplicationName AND
                u.ApplicationId = a.ApplicationId    AND
                u.UserId = m.UserId AND
                LOWER(@Email) = m.LoweredEmail

    IF (@@rowcount = 0)
        RETURN(1)
    RETURN(0)
END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_Membership_GetUserByName]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Membership_GetUserByName]
    @ApplicationName      nvarchar(256),
    @UserName             nvarchar(256),
    @CurrentTimeUtc       datetime,
    @UpdateLastActivity   bit = 0
AS
BEGIN
    DECLARE @UserId uniqueidentifier

    IF (@UpdateLastActivity = 1)
    BEGIN
        SELECT TOP 1 m.Email, m.PasswordQuestion, m.Comment, m.IsApproved,
                m.CreateDate, m.LastLoginDate, @CurrentTimeUtc, m.LastPasswordChangedDate,
                u.UserId, m.IsLockedOut,m.LastLockoutDate
        FROM    dbo.aspnet_Applications a, dbo.aspnet_Users u, dbo.aspnet_Membership m
        WHERE    LOWER(@ApplicationName) = a.LoweredApplicationName AND
                u.ApplicationId = a.ApplicationId    AND
                LOWER(@UserName) = u.LoweredUserName AND u.UserId = m.UserId

        IF (@@ROWCOUNT = 0) -- Username not found
            RETURN -1

        UPDATE   dbo.aspnet_Users
        SET      LastActivityDate = @CurrentTimeUtc
        WHERE    @UserId = UserId
    END
    ELSE
    BEGIN
        SELECT TOP 1 m.Email, m.PasswordQuestion, m.Comment, m.IsApproved,
                m.CreateDate, m.LastLoginDate, u.LastActivityDate, m.LastPasswordChangedDate,
                u.UserId, m.IsLockedOut,m.LastLockoutDate
        FROM    dbo.aspnet_Applications a, dbo.aspnet_Users u, dbo.aspnet_Membership m
        WHERE    LOWER(@ApplicationName) = a.LoweredApplicationName AND
                u.ApplicationId = a.ApplicationId    AND
                LOWER(@UserName) = u.LoweredUserName AND u.UserId = m.UserId

        IF (@@ROWCOUNT = 0) -- Username not found
            RETURN -1
    END

    RETURN 0
END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_Membership_GetUserByUserId]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Membership_GetUserByUserId]
    @UserId               uniqueidentifier,
    @CurrentTimeUtc       datetime,
    @UpdateLastActivity   bit = 0
AS
BEGIN
    IF ( @UpdateLastActivity = 1 )
    BEGIN
        UPDATE   dbo.aspnet_Users
        SET      LastActivityDate = @CurrentTimeUtc
        FROM     dbo.aspnet_Users
        WHERE    @UserId = UserId

        IF ( @@ROWCOUNT = 0 ) -- User ID not found
            RETURN -1
    END

    SELECT  m.Email, m.PasswordQuestion, m.Comment, m.IsApproved,
            m.CreateDate, m.LastLoginDate, u.LastActivityDate,
            m.LastPasswordChangedDate, u.UserName, m.IsLockedOut,
            m.LastLockoutDate
    FROM    dbo.aspnet_Users u, dbo.aspnet_Membership m
    WHERE   @UserId = u.UserId AND u.UserId = m.UserId

    IF ( @@ROWCOUNT = 0 ) -- User ID not found
       RETURN -1

    RETURN 0
END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_Membership_ResetPassword]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Membership_ResetPassword]
    @ApplicationName             nvarchar(256),
    @UserName                    nvarchar(256),
    @NewPassword                 nvarchar(128),
    @MaxInvalidPasswordAttempts  int,
    @PasswordAttemptWindow       int,
    @PasswordSalt                nvarchar(128),
    @CurrentTimeUtc              datetime,
    @PasswordFormat              int = 0,
    @PasswordAnswer              nvarchar(128) = NULL
AS
BEGIN
    DECLARE @IsLockedOut                            bit
    DECLARE @LastLockoutDate                        datetime
    DECLARE @FailedPasswordAttemptCount             int
    DECLARE @FailedPasswordAttemptWindowStart       datetime
    DECLARE @FailedPasswordAnswerAttemptCount       int
    DECLARE @FailedPasswordAnswerAttemptWindowStart datetime

    DECLARE @UserId                                 uniqueidentifier
    SET     @UserId = NULL

    DECLARE @ErrorCode     int
    SET @ErrorCode = 0

    DECLARE @TranStarted   bit
    SET @TranStarted = 0

    IF( @@TRANCOUNT = 0 )
    BEGIN
	    BEGIN TRANSACTION
	    SET @TranStarted = 1
    END
    ELSE
    	SET @TranStarted = 0

    SELECT  @UserId = u.UserId
    FROM    dbo.aspnet_Users u, dbo.aspnet_Applications a, dbo.aspnet_Membership m
    WHERE   LoweredUserName = LOWER(@UserName) AND
            u.ApplicationId = a.ApplicationId  AND
            LOWER(@ApplicationName) = a.LoweredApplicationName AND
            u.UserId = m.UserId

    IF ( @UserId IS NULL )
    BEGIN
        SET @ErrorCode = 1
        GOTO Cleanup
    END

    SELECT @IsLockedOut = IsLockedOut,
           @LastLockoutDate = LastLockoutDate,
           @FailedPasswordAttemptCount = FailedPasswordAttemptCount,
           @FailedPasswordAttemptWindowStart = FailedPasswordAttemptWindowStart,
           @FailedPasswordAnswerAttemptCount = FailedPasswordAnswerAttemptCount,
           @FailedPasswordAnswerAttemptWindowStart = FailedPasswordAnswerAttemptWindowStart
    FROM dbo.aspnet_Membership WITH ( UPDLOCK )
    WHERE @UserId = UserId

    IF( @IsLockedOut = 1 )
    BEGIN
        SET @ErrorCode = 99
        GOTO Cleanup
    END

    UPDATE dbo.aspnet_Membership
    SET    Password = @NewPassword,
           LastPasswordChangedDate = @CurrentTimeUtc,
           PasswordFormat = @PasswordFormat,
           PasswordSalt = @PasswordSalt
    WHERE  @UserId = UserId AND
           ( ( @PasswordAnswer IS NULL ) OR ( LOWER( PasswordAnswer ) = LOWER( @PasswordAnswer ) ) )

    IF ( @@ROWCOUNT = 0 )
        BEGIN
            IF( @CurrentTimeUtc > DATEADD( minute, @PasswordAttemptWindow, @FailedPasswordAnswerAttemptWindowStart ) )
            BEGIN
                SET @FailedPasswordAnswerAttemptWindowStart = @CurrentTimeUtc
                SET @FailedPasswordAnswerAttemptCount = 1
            END
            ELSE
            BEGIN
                SET @FailedPasswordAnswerAttemptWindowStart = @CurrentTimeUtc
                SET @FailedPasswordAnswerAttemptCount = @FailedPasswordAnswerAttemptCount + 1
            END

            BEGIN
                IF( @FailedPasswordAnswerAttemptCount >= @MaxInvalidPasswordAttempts )
                BEGIN
                    SET @IsLockedOut = 1
                    SET @LastLockoutDate = @CurrentTimeUtc
                END
            END

            SET @ErrorCode = 3
        END
    ELSE
        BEGIN
            IF( @FailedPasswordAnswerAttemptCount > 0 )
            BEGIN
                SET @FailedPasswordAnswerAttemptCount = 0
                SET @FailedPasswordAnswerAttemptWindowStart = CONVERT( datetime, '17540101', 112 )
            END
        END

    IF( NOT ( @PasswordAnswer IS NULL ) )
    BEGIN
        UPDATE dbo.aspnet_Membership
        SET IsLockedOut = @IsLockedOut, LastLockoutDate = @LastLockoutDate,
            FailedPasswordAttemptCount = @FailedPasswordAttemptCount,
            FailedPasswordAttemptWindowStart = @FailedPasswordAttemptWindowStart,
            FailedPasswordAnswerAttemptCount = @FailedPasswordAnswerAttemptCount,
            FailedPasswordAnswerAttemptWindowStart = @FailedPasswordAnswerAttemptWindowStart
        WHERE @UserId = UserId

        IF( @@ERROR <> 0 )
        BEGIN
            SET @ErrorCode = -1
            GOTO Cleanup
        END
    END

    IF( @TranStarted = 1 )
    BEGIN
	SET @TranStarted = 0
	COMMIT TRANSACTION
    END

    RETURN @ErrorCode

Cleanup:

    IF( @TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
    	ROLLBACK TRANSACTION
    END

    RETURN @ErrorCode

END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_Membership_SetPassword]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Membership_SetPassword]
    @ApplicationName  nvarchar(256),
    @UserName         nvarchar(256),
    @NewPassword      nvarchar(128),
    @PasswordSalt     nvarchar(128),
    @CurrentTimeUtc   datetime,
    @PasswordFormat   int = 0
AS
BEGIN
    DECLARE @UserId uniqueidentifier
    SELECT  @UserId = NULL
    SELECT  @UserId = u.UserId
    FROM    dbo.aspnet_Users u, dbo.aspnet_Applications a, dbo.aspnet_Membership m
    WHERE   LoweredUserName = LOWER(@UserName) AND
            u.ApplicationId = a.ApplicationId  AND
            LOWER(@ApplicationName) = a.LoweredApplicationName AND
            u.UserId = m.UserId

    IF (@UserId IS NULL)
        RETURN(1)

    UPDATE dbo.aspnet_Membership
    SET Password = @NewPassword, PasswordFormat = @PasswordFormat, PasswordSalt = @PasswordSalt,
        LastPasswordChangedDate = @CurrentTimeUtc
    WHERE @UserId = UserId
    RETURN(0)
END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_Membership_UnlockUser]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Membership_UnlockUser]
    @ApplicationName                         nvarchar(256),
    @UserName                                nvarchar(256)
AS
BEGIN
    DECLARE @UserId uniqueidentifier
    SELECT  @UserId = NULL
    SELECT  @UserId = u.UserId
    FROM    dbo.aspnet_Users u, dbo.aspnet_Applications a, dbo.aspnet_Membership m
    WHERE   LoweredUserName = LOWER(@UserName) AND
            u.ApplicationId = a.ApplicationId  AND
            LOWER(@ApplicationName) = a.LoweredApplicationName AND
            u.UserId = m.UserId

    IF ( @UserId IS NULL )
        RETURN 1

    UPDATE dbo.aspnet_Membership
    SET IsLockedOut = 0,
        FailedPasswordAttemptCount = 0,
        FailedPasswordAttemptWindowStart = CONVERT( datetime, '17540101', 112 ),
        FailedPasswordAnswerAttemptCount = 0,
        FailedPasswordAnswerAttemptWindowStart = CONVERT( datetime, '17540101', 112 ),
        LastLockoutDate = CONVERT( datetime, '17540101', 112 )
    WHERE @UserId = UserId

    RETURN 0
END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_Membership_UpdateUser]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Membership_UpdateUser]
    @ApplicationName      nvarchar(256),
    @UserName             nvarchar(256),
    @Email                nvarchar(256),
    @Comment              ntext,
    @IsApproved           bit,
    @LastLoginDate        datetime,
    @LastActivityDate     datetime,
    @UniqueEmail          int,
    @CurrentTimeUtc       datetime
AS
BEGIN
    DECLARE @UserId uniqueidentifier
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @UserId = NULL
    SELECT  @UserId = u.UserId, @ApplicationId = a.ApplicationId
    FROM    dbo.aspnet_Users u, dbo.aspnet_Applications a, dbo.aspnet_Membership m
    WHERE   LoweredUserName = LOWER(@UserName) AND
            u.ApplicationId = a.ApplicationId  AND
            LOWER(@ApplicationName) = a.LoweredApplicationName AND
            u.UserId = m.UserId

    IF (@UserId IS NULL)
        RETURN(1)

    IF (@UniqueEmail = 1)
    BEGIN
        IF (EXISTS (SELECT *
                    FROM  dbo.aspnet_Membership WITH (UPDLOCK, HOLDLOCK)
                    WHERE ApplicationId = @ApplicationId  AND @UserId <> UserId AND LoweredEmail = LOWER(@Email)))
        BEGIN
            RETURN(7)
        END
    END

    DECLARE @TranStarted   bit
    SET @TranStarted = 0

    IF( @@TRANCOUNT = 0 )
    BEGIN
	    BEGIN TRANSACTION
	    SET @TranStarted = 1
    END
    ELSE
	SET @TranStarted = 0

    UPDATE dbo.aspnet_Users WITH (ROWLOCK)
    SET
         LastActivityDate = @LastActivityDate
    WHERE
       @UserId = UserId

    IF( @@ERROR <> 0 )
        GOTO Cleanup

    UPDATE dbo.aspnet_Membership WITH (ROWLOCK)
    SET
         Email            = @Email,
         LoweredEmail     = LOWER(@Email),
         Comment          = @Comment,
         IsApproved       = @IsApproved,
         LastLoginDate    = @LastLoginDate
    WHERE
       @UserId = UserId

    IF( @@ERROR <> 0 )
        GOTO Cleanup

    IF( @TranStarted = 1 )
    BEGIN
	SET @TranStarted = 0
	COMMIT TRANSACTION
    END

    RETURN 0

Cleanup:

    IF( @TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
    	ROLLBACK TRANSACTION
    END

    RETURN -1
END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_Membership_UpdateUserInfo]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Membership_UpdateUserInfo]
    @ApplicationName                nvarchar(256),
    @UserName                       nvarchar(256),
    @IsPasswordCorrect              bit,
    @UpdateLastLoginActivityDate    bit,
    @MaxInvalidPasswordAttempts     int,
    @PasswordAttemptWindow          int,
    @CurrentTimeUtc                 datetime,
    @LastLoginDate                  datetime,
    @LastActivityDate               datetime
AS
BEGIN
    DECLARE @UserId                                 uniqueidentifier
    DECLARE @IsApproved                             bit
    DECLARE @IsLockedOut                            bit
    DECLARE @LastLockoutDate                        datetime
    DECLARE @FailedPasswordAttemptCount             int
    DECLARE @FailedPasswordAttemptWindowStart       datetime
    DECLARE @FailedPasswordAnswerAttemptCount       int
    DECLARE @FailedPasswordAnswerAttemptWindowStart datetime

    DECLARE @ErrorCode     int
    SET @ErrorCode = 0

    DECLARE @TranStarted   bit
    SET @TranStarted = 0

    IF( @@TRANCOUNT = 0 )
    BEGIN
	    BEGIN TRANSACTION
	    SET @TranStarted = 1
    END
    ELSE
    	SET @TranStarted = 0

    SELECT  @UserId = u.UserId,
            @IsApproved = m.IsApproved,
            @IsLockedOut = m.IsLockedOut,
            @LastLockoutDate = m.LastLockoutDate,
            @FailedPasswordAttemptCount = m.FailedPasswordAttemptCount,
            @FailedPasswordAttemptWindowStart = m.FailedPasswordAttemptWindowStart,
            @FailedPasswordAnswerAttemptCount = m.FailedPasswordAnswerAttemptCount,
            @FailedPasswordAnswerAttemptWindowStart = m.FailedPasswordAnswerAttemptWindowStart
    FROM    dbo.aspnet_Applications a, dbo.aspnet_Users u, dbo.aspnet_Membership m WITH ( UPDLOCK )
    WHERE   LOWER(@ApplicationName) = a.LoweredApplicationName AND
            u.ApplicationId = a.ApplicationId    AND
            u.UserId = m.UserId AND
            LOWER(@UserName) = u.LoweredUserName

    IF ( @@rowcount = 0 )
    BEGIN
        SET @ErrorCode = 1
        GOTO Cleanup
    END

    IF( @IsLockedOut = 1 )
    BEGIN
        GOTO Cleanup
    END

    IF( @IsPasswordCorrect = 0 )
    BEGIN
        IF( @CurrentTimeUtc > DATEADD( minute, @PasswordAttemptWindow, @FailedPasswordAttemptWindowStart ) )
        BEGIN
            SET @FailedPasswordAttemptWindowStart = @CurrentTimeUtc
            SET @FailedPasswordAttemptCount = 1
        END
        ELSE
        BEGIN
            SET @FailedPasswordAttemptWindowStart = @CurrentTimeUtc
            SET @FailedPasswordAttemptCount = @FailedPasswordAttemptCount + 1
        END

        BEGIN
            IF( @FailedPasswordAttemptCount >= @MaxInvalidPasswordAttempts )
            BEGIN
                SET @IsLockedOut = 1
                SET @LastLockoutDate = @CurrentTimeUtc
            END
        END
    END
    ELSE
    BEGIN
        IF( @FailedPasswordAttemptCount > 0 OR @FailedPasswordAnswerAttemptCount > 0 )
        BEGIN
            SET @FailedPasswordAttemptCount = 0
            SET @FailedPasswordAttemptWindowStart = CONVERT( datetime, '17540101', 112 )
            SET @FailedPasswordAnswerAttemptCount = 0
            SET @FailedPasswordAnswerAttemptWindowStart = CONVERT( datetime, '17540101', 112 )
            SET @LastLockoutDate = CONVERT( datetime, '17540101', 112 )
        END
    END

    IF( @UpdateLastLoginActivityDate = 1 )
    BEGIN
        UPDATE  dbo.aspnet_Users
        SET     LastActivityDate = @LastActivityDate
        WHERE   @UserId = UserId

        IF( @@ERROR <> 0 )
        BEGIN
            SET @ErrorCode = -1
            GOTO Cleanup
        END

        UPDATE  dbo.aspnet_Membership
        SET     LastLoginDate = @LastLoginDate
        WHERE   UserId = @UserId

        IF( @@ERROR <> 0 )
        BEGIN
            SET @ErrorCode = -1
            GOTO Cleanup
        END
    END


    UPDATE dbo.aspnet_Membership
    SET IsLockedOut = @IsLockedOut, LastLockoutDate = @LastLockoutDate,
        FailedPasswordAttemptCount = @FailedPasswordAttemptCount,
        FailedPasswordAttemptWindowStart = @FailedPasswordAttemptWindowStart,
        FailedPasswordAnswerAttemptCount = @FailedPasswordAnswerAttemptCount,
        FailedPasswordAnswerAttemptWindowStart = @FailedPasswordAnswerAttemptWindowStart
    WHERE @UserId = UserId

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    IF( @TranStarted = 1 )
    BEGIN
	SET @TranStarted = 0
	COMMIT TRANSACTION
    END

    RETURN @ErrorCode

Cleanup:

    IF( @TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
    	ROLLBACK TRANSACTION
    END

    RETURN @ErrorCode

END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_Paths_CreatePath]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Paths_CreatePath]
    @ApplicationId UNIQUEIDENTIFIER,
    @Path           NVARCHAR(256),
    @PathId         UNIQUEIDENTIFIER OUTPUT
AS
BEGIN
    BEGIN TRANSACTION
    IF (NOT EXISTS(SELECT * FROM dbo.aspnet_Paths WHERE LoweredPath = LOWER(@Path) AND ApplicationId = @ApplicationId))
    BEGIN
        INSERT dbo.aspnet_Paths (ApplicationId, Path, LoweredPath) VALUES (@ApplicationId, @Path, LOWER(@Path))
    END
    COMMIT TRANSACTION
    SELECT @PathId = PathId FROM dbo.aspnet_Paths WHERE LOWER(@Path) = LoweredPath AND ApplicationId = @ApplicationId
END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_Personalization_GetApplicationId]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Personalization_GetApplicationId] (
    @ApplicationName NVARCHAR(256),
    @ApplicationId UNIQUEIDENTIFIER OUT)
AS
BEGIN
    SELECT @ApplicationId = ApplicationId FROM dbo.aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_PersonalizationAdministration_DeleteAllState]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_PersonalizationAdministration_DeleteAllState] (
    @AllUsersScope bit,
    @ApplicationName NVARCHAR(256),
    @Count int OUT)
AS
BEGIN
    DECLARE @ApplicationId UNIQUEIDENTIFIER
    EXEC dbo.aspnet_Personalization_GetApplicationId @ApplicationName, @ApplicationId OUTPUT
    IF (@ApplicationId IS NULL)
        SELECT @Count = 0
    ELSE
    BEGIN
        IF (@AllUsersScope = 1)
            DELETE FROM aspnet_PersonalizationAllUsers
            WHERE PathId IN
               (SELECT Paths.PathId
                FROM dbo.aspnet_Paths Paths
                WHERE Paths.ApplicationId = @ApplicationId)
        ELSE
            DELETE FROM aspnet_PersonalizationPerUser
            WHERE PathId IN
               (SELECT Paths.PathId
                FROM dbo.aspnet_Paths Paths
                WHERE Paths.ApplicationId = @ApplicationId)

        SELECT @Count = @@ROWCOUNT
    END
END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_PersonalizationAdministration_FindState]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_PersonalizationAdministration_FindState] (
    @AllUsersScope bit,
    @ApplicationName NVARCHAR(256),
    @PageIndex              INT,
    @PageSize               INT,
    @Path NVARCHAR(256) = NULL,
    @UserName NVARCHAR(256) = NULL,
    @InactiveSinceDate DATETIME = NULL)
AS
BEGIN
    DECLARE @ApplicationId UNIQUEIDENTIFIER
    EXEC dbo.aspnet_Personalization_GetApplicationId @ApplicationName, @ApplicationId OUTPUT
    IF (@ApplicationId IS NULL)
        RETURN

    -- Set the page bounds
    DECLARE @PageLowerBound INT
    DECLARE @PageUpperBound INT
    DECLARE @TotalRecords   INT
    SET @PageLowerBound = @PageSize * @PageIndex
    SET @PageUpperBound = @PageSize - 1 + @PageLowerBound

    -- Create a temp table to store the selected results
    CREATE TABLE #PageIndex (
        IndexId int IDENTITY (0, 1) NOT NULL,
        ItemId UNIQUEIDENTIFIER
    )

    IF (@AllUsersScope = 1)
    BEGIN
        -- Insert into our temp table
        INSERT INTO #PageIndex (ItemId)
        SELECT Paths.PathId
        FROM dbo.aspnet_Paths Paths,
             ((SELECT Paths.PathId
               FROM dbo.aspnet_PersonalizationAllUsers AllUsers, dbo.aspnet_Paths Paths
               WHERE Paths.ApplicationId = @ApplicationId
                      AND AllUsers.PathId = Paths.PathId
                      AND (@Path IS NULL OR Paths.LoweredPath LIKE LOWER(@Path))
              ) AS SharedDataPerPath
              FULL OUTER JOIN
              (SELECT DISTINCT Paths.PathId
               FROM dbo.aspnet_PersonalizationPerUser PerUser, dbo.aspnet_Paths Paths
               WHERE Paths.ApplicationId = @ApplicationId
                      AND PerUser.PathId = Paths.PathId
                      AND (@Path IS NULL OR Paths.LoweredPath LIKE LOWER(@Path))
              ) AS UserDataPerPath
              ON SharedDataPerPath.PathId = UserDataPerPath.PathId
             )
        WHERE Paths.PathId = SharedDataPerPath.PathId OR Paths.PathId = UserDataPerPath.PathId
        ORDER BY Paths.Path ASC

        SELECT @TotalRecords = @@ROWCOUNT

        SELECT Paths.Path,
               SharedDataPerPath.LastUpdatedDate,
               SharedDataPerPath.SharedDataLength,
               UserDataPerPath.UserDataLength,
               UserDataPerPath.UserCount
        FROM dbo.aspnet_Paths Paths,
             ((SELECT PageIndex.ItemId AS PathId,
                      AllUsers.LastUpdatedDate AS LastUpdatedDate,
                      DATALENGTH(AllUsers.PageSettings) AS SharedDataLength
               FROM dbo.aspnet_PersonalizationAllUsers AllUsers, #PageIndex PageIndex
               WHERE AllUsers.PathId = PageIndex.ItemId
                     AND PageIndex.IndexId >= @PageLowerBound AND PageIndex.IndexId <= @PageUpperBound
              ) AS SharedDataPerPath
              FULL OUTER JOIN
              (SELECT PageIndex.ItemId AS PathId,
                      SUM(DATALENGTH(PerUser.PageSettings)) AS UserDataLength,
                      COUNT(*) AS UserCount
               FROM aspnet_PersonalizationPerUser PerUser, #PageIndex PageIndex
               WHERE PerUser.PathId = PageIndex.ItemId
                     AND PageIndex.IndexId >= @PageLowerBound AND PageIndex.IndexId <= @PageUpperBound
               GROUP BY PageIndex.ItemId
              ) AS UserDataPerPath
              ON SharedDataPerPath.PathId = UserDataPerPath.PathId
             )
        WHERE Paths.PathId = SharedDataPerPath.PathId OR Paths.PathId = UserDataPerPath.PathId
        ORDER BY Paths.Path ASC
    END
    ELSE
    BEGIN
        -- Insert into our temp table
        INSERT INTO #PageIndex (ItemId)
        SELECT PerUser.Id
        FROM dbo.aspnet_PersonalizationPerUser PerUser, dbo.aspnet_Users Users, dbo.aspnet_Paths Paths
        WHERE Paths.ApplicationId = @ApplicationId
              AND PerUser.UserId = Users.UserId
              AND PerUser.PathId = Paths.PathId
              AND (@Path IS NULL OR Paths.LoweredPath LIKE LOWER(@Path))
              AND (@UserName IS NULL OR Users.LoweredUserName LIKE LOWER(@UserName))
              AND (@InactiveSinceDate IS NULL OR Users.LastActivityDate <= @InactiveSinceDate)
        ORDER BY Paths.Path ASC, Users.UserName ASC

        SELECT @TotalRecords = @@ROWCOUNT

        SELECT Paths.Path, PerUser.LastUpdatedDate, DATALENGTH(PerUser.PageSettings), Users.UserName, Users.LastActivityDate
        FROM dbo.aspnet_PersonalizationPerUser PerUser, dbo.aspnet_Users Users, dbo.aspnet_Paths Paths, #PageIndex PageIndex
        WHERE PerUser.Id = PageIndex.ItemId
              AND PerUser.UserId = Users.UserId
              AND PerUser.PathId = Paths.PathId
              AND PageIndex.IndexId >= @PageLowerBound AND PageIndex.IndexId <= @PageUpperBound
        ORDER BY Paths.Path ASC, Users.UserName ASC
    END

    RETURN @TotalRecords
END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_PersonalizationAdministration_GetCountOfState]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_PersonalizationAdministration_GetCountOfState] (
    @Count int OUT,
    @AllUsersScope bit,
    @ApplicationName NVARCHAR(256),
    @Path NVARCHAR(256) = NULL,
    @UserName NVARCHAR(256) = NULL,
    @InactiveSinceDate DATETIME = NULL)
AS
BEGIN

    DECLARE @ApplicationId UNIQUEIDENTIFIER
    EXEC dbo.aspnet_Personalization_GetApplicationId @ApplicationName, @ApplicationId OUTPUT
    IF (@ApplicationId IS NULL)
        SELECT @Count = 0
    ELSE
        IF (@AllUsersScope = 1)
            SELECT @Count = COUNT(*)
            FROM dbo.aspnet_PersonalizationAllUsers AllUsers, dbo.aspnet_Paths Paths
            WHERE Paths.ApplicationId = @ApplicationId
                  AND AllUsers.PathId = Paths.PathId
                  AND (@Path IS NULL OR Paths.LoweredPath LIKE LOWER(@Path))
        ELSE
            SELECT @Count = COUNT(*)
            FROM dbo.aspnet_PersonalizationPerUser PerUser, dbo.aspnet_Users Users, dbo.aspnet_Paths Paths
            WHERE Paths.ApplicationId = @ApplicationId
                  AND PerUser.UserId = Users.UserId
                  AND PerUser.PathId = Paths.PathId
                  AND (@Path IS NULL OR Paths.LoweredPath LIKE LOWER(@Path))
                  AND (@UserName IS NULL OR Users.LoweredUserName LIKE LOWER(@UserName))
                  AND (@InactiveSinceDate IS NULL OR Users.LastActivityDate <= @InactiveSinceDate)
END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_PersonalizationAdministration_ResetSharedState]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_PersonalizationAdministration_ResetSharedState] (
    @Count int OUT,
    @ApplicationName NVARCHAR(256),
    @Path NVARCHAR(256))
AS
BEGIN
    DECLARE @ApplicationId UNIQUEIDENTIFIER
    EXEC dbo.aspnet_Personalization_GetApplicationId @ApplicationName, @ApplicationId OUTPUT
    IF (@ApplicationId IS NULL)
        SELECT @Count = 0
    ELSE
    BEGIN
        DELETE FROM dbo.aspnet_PersonalizationAllUsers
        WHERE PathId IN
            (SELECT AllUsers.PathId
             FROM dbo.aspnet_PersonalizationAllUsers AllUsers, dbo.aspnet_Paths Paths
             WHERE Paths.ApplicationId = @ApplicationId
                   AND AllUsers.PathId = Paths.PathId
                   AND Paths.LoweredPath = LOWER(@Path))

        SELECT @Count = @@ROWCOUNT
    END
END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_PersonalizationAdministration_ResetUserState]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_PersonalizationAdministration_ResetUserState] (
    @Count                  int                 OUT,
    @ApplicationName        NVARCHAR(256),
    @InactiveSinceDate      DATETIME            = NULL,
    @UserName               NVARCHAR(256)       = NULL,
    @Path                   NVARCHAR(256)       = NULL)
AS
BEGIN
    DECLARE @ApplicationId UNIQUEIDENTIFIER
    EXEC dbo.aspnet_Personalization_GetApplicationId @ApplicationName, @ApplicationId OUTPUT
    IF (@ApplicationId IS NULL)
        SELECT @Count = 0
    ELSE
    BEGIN
        DELETE FROM dbo.aspnet_PersonalizationPerUser
        WHERE Id IN (SELECT PerUser.Id
                     FROM dbo.aspnet_PersonalizationPerUser PerUser, dbo.aspnet_Users Users, dbo.aspnet_Paths Paths
                     WHERE Paths.ApplicationId = @ApplicationId
                           AND PerUser.UserId = Users.UserId
                           AND PerUser.PathId = Paths.PathId
                           AND (@InactiveSinceDate IS NULL OR Users.LastActivityDate <= @InactiveSinceDate)
                           AND (@UserName IS NULL OR Users.LoweredUserName = LOWER(@UserName))
                           AND (@Path IS NULL OR Paths.LoweredPath = LOWER(@Path)))

        SELECT @Count = @@ROWCOUNT
    END
END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_PersonalizationAllUsers_GetPageSettings]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_PersonalizationAllUsers_GetPageSettings] (
    @ApplicationName  NVARCHAR(256),
    @Path              NVARCHAR(256))
AS
BEGIN
    DECLARE @ApplicationId UNIQUEIDENTIFIER
    DECLARE @PathId UNIQUEIDENTIFIER

    SELECT @ApplicationId = NULL
    SELECT @PathId = NULL

    EXEC dbo.aspnet_Personalization_GetApplicationId @ApplicationName, @ApplicationId OUTPUT
    IF (@ApplicationId IS NULL)
    BEGIN
        RETURN
    END

    SELECT @PathId = u.PathId FROM dbo.aspnet_Paths u WHERE u.ApplicationId = @ApplicationId AND u.LoweredPath = LOWER(@Path)
    IF (@PathId IS NULL)
    BEGIN
        RETURN
    END

    SELECT p.PageSettings FROM dbo.aspnet_PersonalizationAllUsers p WHERE p.PathId = @PathId
END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_PersonalizationAllUsers_ResetPageSettings]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_PersonalizationAllUsers_ResetPageSettings] (
    @ApplicationName  NVARCHAR(256),
    @Path              NVARCHAR(256))
AS
BEGIN
    DECLARE @ApplicationId UNIQUEIDENTIFIER
    DECLARE @PathId UNIQUEIDENTIFIER

    SELECT @ApplicationId = NULL
    SELECT @PathId = NULL

    EXEC dbo.aspnet_Personalization_GetApplicationId @ApplicationName, @ApplicationId OUTPUT
    IF (@ApplicationId IS NULL)
    BEGIN
        RETURN
    END

    SELECT @PathId = u.PathId FROM dbo.aspnet_Paths u WHERE u.ApplicationId = @ApplicationId AND u.LoweredPath = LOWER(@Path)
    IF (@PathId IS NULL)
    BEGIN
        RETURN
    END

    DELETE FROM dbo.aspnet_PersonalizationAllUsers WHERE PathId = @PathId
    RETURN 0
END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_PersonalizationAllUsers_SetPageSettings]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_PersonalizationAllUsers_SetPageSettings] (
    @ApplicationName  NVARCHAR(256),
    @Path             NVARCHAR(256),
    @PageSettings     IMAGE,
    @CurrentTimeUtc   DATETIME)
AS
BEGIN
    DECLARE @ApplicationId UNIQUEIDENTIFIER
    DECLARE @PathId UNIQUEIDENTIFIER

    SELECT @ApplicationId = NULL
    SELECT @PathId = NULL

    EXEC dbo.aspnet_Applications_CreateApplication @ApplicationName, @ApplicationId OUTPUT

    SELECT @PathId = u.PathId FROM dbo.aspnet_Paths u WHERE u.ApplicationId = @ApplicationId AND u.LoweredPath = LOWER(@Path)
    IF (@PathId IS NULL)
    BEGIN
        EXEC dbo.aspnet_Paths_CreatePath @ApplicationId, @Path, @PathId OUTPUT
    END

    IF (EXISTS(SELECT PathId FROM dbo.aspnet_PersonalizationAllUsers WHERE PathId = @PathId))
        UPDATE dbo.aspnet_PersonalizationAllUsers SET PageSettings = @PageSettings, LastUpdatedDate = @CurrentTimeUtc WHERE PathId = @PathId
    ELSE
        INSERT INTO dbo.aspnet_PersonalizationAllUsers(PathId, PageSettings, LastUpdatedDate) VALUES (@PathId, @PageSettings, @CurrentTimeUtc)
    RETURN 0
END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_PersonalizationPerUser_GetPageSettings]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_PersonalizationPerUser_GetPageSettings] (
    @ApplicationName  NVARCHAR(256),
    @UserName         NVARCHAR(256),
    @Path             NVARCHAR(256),
    @CurrentTimeUtc   DATETIME)
AS
BEGIN
    DECLARE @ApplicationId UNIQUEIDENTIFIER
    DECLARE @PathId UNIQUEIDENTIFIER
    DECLARE @UserId UNIQUEIDENTIFIER

    SELECT @ApplicationId = NULL
    SELECT @PathId = NULL
    SELECT @UserId = NULL

    EXEC dbo.aspnet_Personalization_GetApplicationId @ApplicationName, @ApplicationId OUTPUT
    IF (@ApplicationId IS NULL)
    BEGIN
        RETURN
    END

    SELECT @PathId = u.PathId FROM dbo.aspnet_Paths u WHERE u.ApplicationId = @ApplicationId AND u.LoweredPath = LOWER(@Path)
    IF (@PathId IS NULL)
    BEGIN
        RETURN
    END

    SELECT @UserId = u.UserId FROM dbo.aspnet_Users u WHERE u.ApplicationId = @ApplicationId AND u.LoweredUserName = LOWER(@UserName)
    IF (@UserId IS NULL)
    BEGIN
        RETURN
    END

    UPDATE   dbo.aspnet_Users WITH (ROWLOCK)
    SET      LastActivityDate = @CurrentTimeUtc
    WHERE    UserId = @UserId
    IF (@@ROWCOUNT = 0) -- Username not found
        RETURN

    SELECT p.PageSettings FROM dbo.aspnet_PersonalizationPerUser p WHERE p.PathId = @PathId AND p.UserId = @UserId
END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_PersonalizationPerUser_ResetPageSettings]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_PersonalizationPerUser_ResetPageSettings] (
    @ApplicationName  NVARCHAR(256),
    @UserName         NVARCHAR(256),
    @Path             NVARCHAR(256),
    @CurrentTimeUtc   DATETIME)
AS
BEGIN
    DECLARE @ApplicationId UNIQUEIDENTIFIER
    DECLARE @PathId UNIQUEIDENTIFIER
    DECLARE @UserId UNIQUEIDENTIFIER

    SELECT @ApplicationId = NULL
    SELECT @PathId = NULL
    SELECT @UserId = NULL

    EXEC dbo.aspnet_Personalization_GetApplicationId @ApplicationName, @ApplicationId OUTPUT
    IF (@ApplicationId IS NULL)
    BEGIN
        RETURN
    END

    SELECT @PathId = u.PathId FROM dbo.aspnet_Paths u WHERE u.ApplicationId = @ApplicationId AND u.LoweredPath = LOWER(@Path)
    IF (@PathId IS NULL)
    BEGIN
        RETURN
    END

    SELECT @UserId = u.UserId FROM dbo.aspnet_Users u WHERE u.ApplicationId = @ApplicationId AND u.LoweredUserName = LOWER(@UserName)
    IF (@UserId IS NULL)
    BEGIN
        RETURN
    END

    UPDATE   dbo.aspnet_Users WITH (ROWLOCK)
    SET      LastActivityDate = @CurrentTimeUtc
    WHERE    UserId = @UserId
    IF (@@ROWCOUNT = 0) -- Username not found
        RETURN

    DELETE FROM dbo.aspnet_PersonalizationPerUser WHERE PathId = @PathId AND UserId = @UserId
    RETURN 0
END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_PersonalizationPerUser_SetPageSettings]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_PersonalizationPerUser_SetPageSettings] (
    @ApplicationName  NVARCHAR(256),
    @UserName         NVARCHAR(256),
    @Path             NVARCHAR(256),
    @PageSettings     IMAGE,
    @CurrentTimeUtc   DATETIME)
AS
BEGIN
    DECLARE @ApplicationId UNIQUEIDENTIFIER
    DECLARE @PathId UNIQUEIDENTIFIER
    DECLARE @UserId UNIQUEIDENTIFIER

    SELECT @ApplicationId = NULL
    SELECT @PathId = NULL
    SELECT @UserId = NULL

    EXEC dbo.aspnet_Applications_CreateApplication @ApplicationName, @ApplicationId OUTPUT

    SELECT @PathId = u.PathId FROM dbo.aspnet_Paths u WHERE u.ApplicationId = @ApplicationId AND u.LoweredPath = LOWER(@Path)
    IF (@PathId IS NULL)
    BEGIN
        EXEC dbo.aspnet_Paths_CreatePath @ApplicationId, @Path, @PathId OUTPUT
    END

    SELECT @UserId = u.UserId FROM dbo.aspnet_Users u WHERE u.ApplicationId = @ApplicationId AND u.LoweredUserName = LOWER(@UserName)
    IF (@UserId IS NULL)
    BEGIN
        EXEC dbo.aspnet_Users_CreateUser @ApplicationId, @UserName, 0, @CurrentTimeUtc, @UserId OUTPUT
    END

    UPDATE   dbo.aspnet_Users WITH (ROWLOCK)
    SET      LastActivityDate = @CurrentTimeUtc
    WHERE    UserId = @UserId
    IF (@@ROWCOUNT = 0) -- Username not found
        RETURN

    IF (EXISTS(SELECT PathId FROM dbo.aspnet_PersonalizationPerUser WHERE UserId = @UserId AND PathId = @PathId))
        UPDATE dbo.aspnet_PersonalizationPerUser SET PageSettings = @PageSettings, LastUpdatedDate = @CurrentTimeUtc WHERE UserId = @UserId AND PathId = @PathId
    ELSE
        INSERT INTO dbo.aspnet_PersonalizationPerUser(UserId, PathId, PageSettings, LastUpdatedDate) VALUES (@UserId, @PathId, @PageSettings, @CurrentTimeUtc)
    RETURN 0
END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_Profile_DeleteInactiveProfiles]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[aspnet_Profile_DeleteInactiveProfiles]
    @ApplicationName        nvarchar(256),
    @ProfileAuthOptions     int,
    @InactiveSinceDate      datetime
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
    BEGIN
        SELECT  0
        RETURN
    END

    DELETE
    FROM    dbo.aspnet_Profile
    WHERE   UserId IN
            (   SELECT  UserId
                FROM    dbo.aspnet_Users u
                WHERE   ApplicationId = @ApplicationId
                        AND (LastActivityDate <= @InactiveSinceDate)
                        AND (
                                (@ProfileAuthOptions = 2)
                             OR (@ProfileAuthOptions = 0 AND IsAnonymous = 1)
                             OR (@ProfileAuthOptions = 1 AND IsAnonymous = 0)
                            )
            )

    SELECT  @@ROWCOUNT
END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_Profile_DeleteProfiles]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[aspnet_Profile_DeleteProfiles]
    @ApplicationName        nvarchar(256),
    @UserNames              nvarchar(4000)
AS
BEGIN
    DECLARE @UserName     nvarchar(256)
    DECLARE @CurrentPos   int
    DECLARE @NextPos      int
    DECLARE @NumDeleted   int
    DECLARE @DeletedUser  int
    DECLARE @TranStarted  bit
    DECLARE @ErrorCode    int

    SET @ErrorCode = 0
    SET @CurrentPos = 1
    SET @NumDeleted = 0
    SET @TranStarted = 0

    IF( @@TRANCOUNT = 0 )
    BEGIN
        BEGIN TRANSACTION
        SET @TranStarted = 1
    END
    ELSE
    	SET @TranStarted = 0

    WHILE (@CurrentPos <= LEN(@UserNames))
    BEGIN
        SELECT @NextPos = CHARINDEX(N',', @UserNames,  @CurrentPos)
        IF (@NextPos = 0 OR @NextPos IS NULL)
            SELECT @NextPos = LEN(@UserNames) + 1

        SELECT @UserName = SUBSTRING(@UserNames, @CurrentPos, @NextPos - @CurrentPos)
        SELECT @CurrentPos = @NextPos+1

        IF (LEN(@UserName) > 0)
        BEGIN
            SELECT @DeletedUser = 0
            EXEC dbo.aspnet_Users_DeleteUser @ApplicationName, @UserName, 4, @DeletedUser OUTPUT
            IF( @@ERROR <> 0 )
            BEGIN
                SET @ErrorCode = -1
                GOTO Cleanup
            END
            IF (@DeletedUser <> 0)
                SELECT @NumDeleted = @NumDeleted + 1
        END
    END
    SELECT @NumDeleted
    IF (@TranStarted = 1)
    BEGIN
    	SET @TranStarted = 0
    	COMMIT TRANSACTION
    END
    SET @TranStarted = 0

    RETURN 0

Cleanup:
    IF (@TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
    	ROLLBACK TRANSACTION
    END
    RETURN @ErrorCode
END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_Profile_GetNumberOfInactiveProfiles]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[aspnet_Profile_GetNumberOfInactiveProfiles]
    @ApplicationName        nvarchar(256),
    @ProfileAuthOptions     int,
    @InactiveSinceDate      datetime
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
    BEGIN
        SELECT 0
        RETURN
    END

    SELECT  COUNT(*)
    FROM    dbo.aspnet_Users u, dbo.aspnet_Profile p
    WHERE   ApplicationId = @ApplicationId
        AND u.UserId = p.UserId
        AND (LastActivityDate <= @InactiveSinceDate)
        AND (
                (@ProfileAuthOptions = 2)
                OR (@ProfileAuthOptions = 0 AND IsAnonymous = 1)
                OR (@ProfileAuthOptions = 1 AND IsAnonymous = 0)
            )
END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_Profile_GetProfiles]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[aspnet_Profile_GetProfiles]
    @ApplicationName        nvarchar(256),
    @ProfileAuthOptions     int,
    @PageIndex              int,
    @PageSize               int,
    @UserNameToMatch        nvarchar(256) = NULL,
    @InactiveSinceDate      datetime      = NULL
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
        RETURN

    -- Set the page bounds
    DECLARE @PageLowerBound int
    DECLARE @PageUpperBound int
    DECLARE @TotalRecords   int
    SET @PageLowerBound = @PageSize * @PageIndex
    SET @PageUpperBound = @PageSize - 1 + @PageLowerBound

    -- Create a temp table TO store the select results
    CREATE TABLE #PageIndexForUsers
    (
        IndexId int IDENTITY (0, 1) NOT NULL,
        UserId uniqueidentifier
    )

    -- Insert into our temp table
    INSERT INTO #PageIndexForUsers (UserId)
        SELECT  u.UserId
        FROM    dbo.aspnet_Users u, dbo.aspnet_Profile p
        WHERE   ApplicationId = @ApplicationId
            AND u.UserId = p.UserId
            AND (@InactiveSinceDate IS NULL OR LastActivityDate <= @InactiveSinceDate)
            AND (     (@ProfileAuthOptions = 2)
                   OR (@ProfileAuthOptions = 0 AND IsAnonymous = 1)
                   OR (@ProfileAuthOptions = 1 AND IsAnonymous = 0)
                 )
            AND (@UserNameToMatch IS NULL OR LoweredUserName LIKE LOWER(@UserNameToMatch))
        ORDER BY UserName

    SELECT  u.UserName, u.IsAnonymous, u.LastActivityDate, p.LastUpdatedDate,
            DATALENGTH(p.PropertyNames) + DATALENGTH(p.PropertyValuesString) + DATALENGTH(p.PropertyValuesBinary)
    FROM    dbo.aspnet_Users u, dbo.aspnet_Profile p, #PageIndexForUsers i
    WHERE   u.UserId = p.UserId AND p.UserId = i.UserId AND i.IndexId >= @PageLowerBound AND i.IndexId <= @PageUpperBound

    SELECT COUNT(*)
    FROM   #PageIndexForUsers

    DROP TABLE #PageIndexForUsers
END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_Profile_GetProperties]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[aspnet_Profile_GetProperties]
    @ApplicationName      nvarchar(256),
    @UserName             nvarchar(256),
    @CurrentTimeUtc       datetime
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM dbo.aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
        RETURN

    DECLARE @UserId uniqueidentifier
    SELECT  @UserId = NULL

    SELECT @UserId = UserId
    FROM   dbo.aspnet_Users
    WHERE  ApplicationId = @ApplicationId AND LoweredUserName = LOWER(@UserName)

    IF (@UserId IS NULL)
        RETURN
    SELECT TOP 1 PropertyNames, PropertyValuesString, PropertyValuesBinary
    FROM         dbo.aspnet_Profile
    WHERE        UserId = @UserId

    IF (@@ROWCOUNT > 0)
    BEGIN
        UPDATE dbo.aspnet_Users
        SET    LastActivityDate=@CurrentTimeUtc
        WHERE  UserId = @UserId
    END
END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_Profile_SetProperties]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[aspnet_Profile_SetProperties]
    @ApplicationName        nvarchar(256),
    @PropertyNames          ntext,
    @PropertyValuesString   ntext,
    @PropertyValuesBinary   image,
    @UserName               nvarchar(256),
    @IsUserAnonymous        bit,
    @CurrentTimeUtc         datetime
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL

    DECLARE @ErrorCode     int
    SET @ErrorCode = 0

    DECLARE @TranStarted   bit
    SET @TranStarted = 0

    IF( @@TRANCOUNT = 0 )
    BEGIN
       BEGIN TRANSACTION
       SET @TranStarted = 1
    END
    ELSE
    	SET @TranStarted = 0

    EXEC dbo.aspnet_Applications_CreateApplication @ApplicationName, @ApplicationId OUTPUT

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    DECLARE @UserId uniqueidentifier
    DECLARE @LastActivityDate datetime
    SELECT  @UserId = NULL
    SELECT  @LastActivityDate = @CurrentTimeUtc

    SELECT @UserId = UserId
    FROM   dbo.aspnet_Users
    WHERE  ApplicationId = @ApplicationId AND LoweredUserName = LOWER(@UserName)
    IF (@UserId IS NULL)
        EXEC dbo.aspnet_Users_CreateUser @ApplicationId, @UserName, @IsUserAnonymous, @LastActivityDate, @UserId OUTPUT

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    UPDATE dbo.aspnet_Users
    SET    LastActivityDate=@CurrentTimeUtc
    WHERE  UserId = @UserId

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    IF (EXISTS( SELECT *
               FROM   dbo.aspnet_Profile
               WHERE  UserId = @UserId))
        UPDATE dbo.aspnet_Profile
        SET    PropertyNames=@PropertyNames, PropertyValuesString = @PropertyValuesString,
               PropertyValuesBinary = @PropertyValuesBinary, LastUpdatedDate=@CurrentTimeUtc
        WHERE  UserId = @UserId
    ELSE
        INSERT INTO dbo.aspnet_Profile(UserId, PropertyNames, PropertyValuesString, PropertyValuesBinary, LastUpdatedDate)
             VALUES (@UserId, @PropertyNames, @PropertyValuesString, @PropertyValuesBinary, @CurrentTimeUtc)

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    IF( @TranStarted = 1 )
    BEGIN
    	SET @TranStarted = 0
    	COMMIT TRANSACTION
    END

    RETURN 0

Cleanup:

    IF( @TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
    	ROLLBACK TRANSACTION
    END

    RETURN @ErrorCode

END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_RegisterSchemaVersion]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[aspnet_RegisterSchemaVersion]
    @Feature                   nvarchar(128),
    @CompatibleSchemaVersion   nvarchar(128),
    @IsCurrentVersion          bit,
    @RemoveIncompatibleSchema  bit
AS
BEGIN
    IF( @RemoveIncompatibleSchema = 1 )
    BEGIN
        DELETE FROM dbo.aspnet_SchemaVersions WHERE Feature = LOWER( @Feature )
    END
    ELSE
    BEGIN
        IF( @IsCurrentVersion = 1 )
        BEGIN
            UPDATE dbo.aspnet_SchemaVersions
            SET IsCurrentVersion = 0
            WHERE Feature = LOWER( @Feature )
        END
    END

    INSERT  dbo.aspnet_SchemaVersions( Feature, CompatibleSchemaVersion, IsCurrentVersion )
    VALUES( LOWER( @Feature ), @CompatibleSchemaVersion, @IsCurrentVersion )
END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_Roles_CreateRole]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Roles_CreateRole]
    @ApplicationName  nvarchar(256),
    @RoleName         nvarchar(256)
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL

    DECLARE @ErrorCode     int
    SET @ErrorCode = 0

    DECLARE @TranStarted   bit
    SET @TranStarted = 0

    IF( @@TRANCOUNT = 0 )
    BEGIN
        BEGIN TRANSACTION
        SET @TranStarted = 1
    END
    ELSE
        SET @TranStarted = 0

    EXEC dbo.aspnet_Applications_CreateApplication @ApplicationName, @ApplicationId OUTPUT

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    IF (EXISTS(SELECT RoleId FROM dbo.aspnet_Roles WHERE LoweredRoleName = LOWER(@RoleName) AND ApplicationId = @ApplicationId))
    BEGIN
        SET @ErrorCode = 1
        GOTO Cleanup
    END

    INSERT INTO dbo.aspnet_Roles
                (ApplicationId, RoleName, LoweredRoleName)
         VALUES (@ApplicationId, @RoleName, LOWER(@RoleName))

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    IF( @TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
        COMMIT TRANSACTION
    END

    RETURN(0)

Cleanup:

    IF( @TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
        ROLLBACK TRANSACTION
    END

    RETURN @ErrorCode

END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_Roles_DeleteRole]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[aspnet_Roles_DeleteRole]
    @ApplicationName            nvarchar(256),
    @RoleName                   nvarchar(256),
    @DeleteOnlyIfRoleIsEmpty    bit
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
        RETURN(1)

    DECLARE @ErrorCode     int
    SET @ErrorCode = 0

    DECLARE @TranStarted   bit
    SET @TranStarted = 0

    IF( @@TRANCOUNT = 0 )
    BEGIN
        BEGIN TRANSACTION
        SET @TranStarted = 1
    END
    ELSE
        SET @TranStarted = 0

    DECLARE @RoleId   uniqueidentifier
    SELECT  @RoleId = NULL
    SELECT  @RoleId = RoleId FROM dbo.aspnet_Roles WHERE LoweredRoleName = LOWER(@RoleName) AND ApplicationId = @ApplicationId

    IF (@RoleId IS NULL)
    BEGIN
        SELECT @ErrorCode = 1
        GOTO Cleanup
    END
    IF (@DeleteOnlyIfRoleIsEmpty <> 0)
    BEGIN
        IF (EXISTS (SELECT RoleId FROM dbo.aspnet_UsersInRoles  WHERE @RoleId = RoleId))
        BEGIN
            SELECT @ErrorCode = 2
            GOTO Cleanup
        END
    END


    DELETE FROM dbo.aspnet_UsersInRoles  WHERE @RoleId = RoleId

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    DELETE FROM dbo.aspnet_Roles WHERE @RoleId = RoleId  AND ApplicationId = @ApplicationId

    IF( @@ERROR <> 0 )
    BEGIN
        SET @ErrorCode = -1
        GOTO Cleanup
    END

    IF( @TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
        COMMIT TRANSACTION
    END

    RETURN(0)

Cleanup:

    IF( @TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
        ROLLBACK TRANSACTION
    END

    RETURN @ErrorCode
END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_Roles_GetAllRoles]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[aspnet_Roles_GetAllRoles] (
    @ApplicationName           nvarchar(256))
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
        RETURN
    SELECT RoleName
    FROM   dbo.aspnet_Roles WHERE ApplicationId = @ApplicationId
    ORDER BY RoleName
END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_Roles_RoleExists]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[aspnet_Roles_RoleExists]
    @ApplicationName  nvarchar(256),
    @RoleName         nvarchar(256)
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
        RETURN(0)
    IF (EXISTS (SELECT RoleName FROM dbo.aspnet_Roles WHERE LOWER(@RoleName) = LoweredRoleName AND ApplicationId = @ApplicationId ))
        RETURN(1)
    ELSE
        RETURN(0)
END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_Setup_RemoveAllRoleMembers]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[aspnet_Setup_RemoveAllRoleMembers]
    @name   sysname
AS
BEGIN
    CREATE TABLE #aspnet_RoleMembers
    (
        Group_name      sysname,
        Group_id        smallint,
        Users_in_group  sysname,
        User_id         smallint
    )

    INSERT INTO #aspnet_RoleMembers
    EXEC sp_helpuser @name

    DECLARE @user_id smallint
    DECLARE @cmd nvarchar(500)
    DECLARE c1 cursor FORWARD_ONLY FOR
        SELECT User_id FROM #aspnet_RoleMembers

    OPEN c1

    FETCH c1 INTO @user_id
    WHILE (@@fetch_status = 0)
    BEGIN
        SET @cmd = 'EXEC sp_droprolemember ' + '''' + @name + ''', ''' + USER_NAME(@user_id) + ''''
        EXEC (@cmd)
        FETCH c1 INTO @user_id
    END

    CLOSE c1
    DEALLOCATE c1
END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_Setup_RestorePermissions]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[aspnet_Setup_RestorePermissions]
    @name   sysname
AS
BEGIN
    DECLARE @object sysname
    DECLARE @protectType char(10)
    DECLARE @action varchar(20)
    DECLARE @grantee sysname
    DECLARE @cmd nvarchar(500)
    DECLARE c1 cursor FORWARD_ONLY FOR
        SELECT Object, ProtectType, [Action], Grantee FROM #aspnet_Permissions where Object = @name

    OPEN c1

    FETCH c1 INTO @object, @protectType, @action, @grantee
    WHILE (@@fetch_status = 0)
    BEGIN
        SET @cmd = @protectType + ' ' + @action + ' on ' + @object + ' TO [' + @grantee + ']'
        EXEC (@cmd)
        FETCH c1 INTO @object, @protectType, @action, @grantee
    END

    CLOSE c1
    DEALLOCATE c1
END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_UnRegisterSchemaVersion]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[aspnet_UnRegisterSchemaVersion]
    @Feature                   nvarchar(128),
    @CompatibleSchemaVersion   nvarchar(128)
AS
BEGIN
    DELETE FROM dbo.aspnet_SchemaVersions
        WHERE   Feature = LOWER(@Feature) AND @CompatibleSchemaVersion = CompatibleSchemaVersion
END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_Users_CreateUser]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[aspnet_Users_CreateUser]
    @ApplicationId    uniqueidentifier,
    @UserName         nvarchar(256),
    @IsUserAnonymous  bit,
    @LastActivityDate DATETIME,
    @UserId           uniqueidentifier OUTPUT
AS
BEGIN
    IF( @UserId IS NULL )
        SELECT @UserId = NEWID()
    ELSE
    BEGIN
        IF( EXISTS( SELECT UserId FROM dbo.aspnet_Users
                    WHERE @UserId = UserId ) )
            RETURN -1
    END

    INSERT dbo.aspnet_Users (ApplicationId, UserId, UserName, LoweredUserName, IsAnonymous, LastActivityDate)
    VALUES (@ApplicationId, @UserId, @UserName, LOWER(@UserName), @IsUserAnonymous, @LastActivityDate)

    RETURN 0
END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_Users_DeleteUser]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_Users_DeleteUser]
    @ApplicationName  nvarchar(256),
    @UserName         nvarchar(256),
    @TablesToDeleteFrom int,
    @NumTablesDeletedFrom int OUTPUT
AS
BEGIN
    DECLARE @UserId               uniqueidentifier
    SELECT  @UserId               = NULL
    SELECT  @NumTablesDeletedFrom = 0

    DECLARE @TranStarted   bit
    SET @TranStarted = 0

    IF( @@TRANCOUNT = 0 )
    BEGIN
	    BEGIN TRANSACTION
	    SET @TranStarted = 1
    END
    ELSE
	SET @TranStarted = 0

    DECLARE @ErrorCode   int
    DECLARE @RowCount    int

    SET @ErrorCode = 0
    SET @RowCount  = 0

    SELECT  @UserId = u.UserId
    FROM    dbo.aspnet_Users u, dbo.aspnet_Applications a
    WHERE   u.LoweredUserName       = LOWER(@UserName)
        AND u.ApplicationId         = a.ApplicationId
        AND LOWER(@ApplicationName) = a.LoweredApplicationName

    IF (@UserId IS NULL)
    BEGIN
        GOTO Cleanup
    END

    -- Delete from Membership table if (@TablesToDeleteFrom & 1) is set
    IF ((@TablesToDeleteFrom & 1) <> 0 AND
        (EXISTS (SELECT name FROM sysobjects WHERE (name = N'vw_aspnet_MembershipUsers') AND (type = 'V'))))
    BEGIN
        DELETE FROM dbo.aspnet_Membership WHERE @UserId = UserId

        SELECT @ErrorCode = @@ERROR,
               @RowCount = @@ROWCOUNT

        IF( @ErrorCode <> 0 )
            GOTO Cleanup

        IF (@RowCount <> 0)
            SELECT  @NumTablesDeletedFrom = @NumTablesDeletedFrom + 1
    END

    -- Delete from aspnet_UsersInRoles table if (@TablesToDeleteFrom & 2) is set
    IF ((@TablesToDeleteFrom & 2) <> 0  AND
        (EXISTS (SELECT name FROM sysobjects WHERE (name = N'vw_aspnet_UsersInRoles') AND (type = 'V'))) )
    BEGIN
        DELETE FROM dbo.aspnet_UsersInRoles WHERE @UserId = UserId

        SELECT @ErrorCode = @@ERROR,
                @RowCount = @@ROWCOUNT

        IF( @ErrorCode <> 0 )
            GOTO Cleanup

        IF (@RowCount <> 0)
            SELECT  @NumTablesDeletedFrom = @NumTablesDeletedFrom + 1
    END

    -- Delete from aspnet_Profile table if (@TablesToDeleteFrom & 4) is set
    IF ((@TablesToDeleteFrom & 4) <> 0  AND
        (EXISTS (SELECT name FROM sysobjects WHERE (name = N'vw_aspnet_Profiles') AND (type = 'V'))) )
    BEGIN
        DELETE FROM dbo.aspnet_Profile WHERE @UserId = UserId

        SELECT @ErrorCode = @@ERROR,
                @RowCount = @@ROWCOUNT

        IF( @ErrorCode <> 0 )
            GOTO Cleanup

        IF (@RowCount <> 0)
            SELECT  @NumTablesDeletedFrom = @NumTablesDeletedFrom + 1
    END

    -- Delete from aspnet_PersonalizationPerUser table if (@TablesToDeleteFrom & 8) is set
    IF ((@TablesToDeleteFrom & 8) <> 0  AND
        (EXISTS (SELECT name FROM sysobjects WHERE (name = N'vw_aspnet_WebPartState_User') AND (type = 'V'))) )
    BEGIN
        DELETE FROM dbo.aspnet_PersonalizationPerUser WHERE @UserId = UserId

        SELECT @ErrorCode = @@ERROR,
                @RowCount = @@ROWCOUNT

        IF( @ErrorCode <> 0 )
            GOTO Cleanup

        IF (@RowCount <> 0)
            SELECT  @NumTablesDeletedFrom = @NumTablesDeletedFrom + 1
    END

    -- Delete from aspnet_Users table if (@TablesToDeleteFrom & 1,2,4 & 8) are all set
    IF ((@TablesToDeleteFrom & 1) <> 0 AND
        (@TablesToDeleteFrom & 2) <> 0 AND
        (@TablesToDeleteFrom & 4) <> 0 AND
        (@TablesToDeleteFrom & 8) <> 0 AND
        (EXISTS (SELECT UserId FROM dbo.aspnet_Users WHERE @UserId = UserId)))
    BEGIN
        DELETE FROM dbo.aspnet_Users WHERE @UserId = UserId

        SELECT @ErrorCode = @@ERROR,
                @RowCount = @@ROWCOUNT

        IF( @ErrorCode <> 0 )
            GOTO Cleanup

        IF (@RowCount <> 0)
            SELECT  @NumTablesDeletedFrom = @NumTablesDeletedFrom + 1
    END

    IF( @TranStarted = 1 )
    BEGIN
	    SET @TranStarted = 0
	    COMMIT TRANSACTION
    END

    RETURN 0

Cleanup:
    SET @NumTablesDeletedFrom = 0

    IF( @TranStarted = 1 )
    BEGIN
        SET @TranStarted = 0
	    ROLLBACK TRANSACTION
    END

    RETURN @ErrorCode

END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_UsersInRoles_AddUsersToRoles]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[aspnet_UsersInRoles_AddUsersToRoles]
	@ApplicationName  nvarchar(256),
	@UserNames		  nvarchar(4000),
	@RoleNames		  nvarchar(4000),
	@CurrentTimeUtc   datetime
AS
BEGIN
	DECLARE @AppId uniqueidentifier
	SELECT  @AppId = NULL
	SELECT  @AppId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
	IF (@AppId IS NULL)
		RETURN(2)
	DECLARE @TranStarted   bit
	SET @TranStarted = 0

	IF( @@TRANCOUNT = 0 )
	BEGIN
		BEGIN TRANSACTION
		SET @TranStarted = 1
	END

	DECLARE @tbNames	table(Name nvarchar(256) NOT NULL PRIMARY KEY)
	DECLARE @tbRoles	table(RoleId uniqueidentifier NOT NULL PRIMARY KEY)
	DECLARE @tbUsers	table(UserId uniqueidentifier NOT NULL PRIMARY KEY)
	DECLARE @Num		int
	DECLARE @Pos		int
	DECLARE @NextPos	int
	DECLARE @Name		nvarchar(256)

	SET @Num = 0
	SET @Pos = 1
	WHILE(@Pos <= LEN(@RoleNames))
	BEGIN
		SELECT @NextPos = CHARINDEX(N',', @RoleNames,  @Pos)
		IF (@NextPos = 0 OR @NextPos IS NULL)
			SELECT @NextPos = LEN(@RoleNames) + 1
		SELECT @Name = RTRIM(LTRIM(SUBSTRING(@RoleNames, @Pos, @NextPos - @Pos)))
		SELECT @Pos = @NextPos+1

		INSERT INTO @tbNames VALUES (@Name)
		SET @Num = @Num + 1
	END

	INSERT INTO @tbRoles
	  SELECT RoleId
	  FROM   dbo.aspnet_Roles ar, @tbNames t
	  WHERE  LOWER(t.Name) = ar.LoweredRoleName AND ar.ApplicationId = @AppId

	IF (@@ROWCOUNT <> @Num)
	BEGIN
		SELECT TOP 1 Name
		FROM   @tbNames
		WHERE  LOWER(Name) NOT IN (SELECT ar.LoweredRoleName FROM dbo.aspnet_Roles ar,  @tbRoles r WHERE r.RoleId = ar.RoleId)
		IF( @TranStarted = 1 )
			ROLLBACK TRANSACTION
		RETURN(2)
	END

	DELETE FROM @tbNames WHERE 1=1
	SET @Num = 0
	SET @Pos = 1

	WHILE(@Pos <= LEN(@UserNames))
	BEGIN
		SELECT @NextPos = CHARINDEX(N',', @UserNames,  @Pos)
		IF (@NextPos = 0 OR @NextPos IS NULL)
			SELECT @NextPos = LEN(@UserNames) + 1
		SELECT @Name = RTRIM(LTRIM(SUBSTRING(@UserNames, @Pos, @NextPos - @Pos)))
		SELECT @Pos = @NextPos+1

		INSERT INTO @tbNames VALUES (@Name)
		SET @Num = @Num + 1
	END

	INSERT INTO @tbUsers
	  SELECT UserId
	  FROM   dbo.aspnet_Users ar, @tbNames t
	  WHERE  LOWER(t.Name) = ar.LoweredUserName AND ar.ApplicationId = @AppId

	IF (@@ROWCOUNT <> @Num)
	BEGIN
		DELETE FROM @tbNames
		WHERE LOWER(Name) IN (SELECT LoweredUserName FROM dbo.aspnet_Users au,  @tbUsers u WHERE au.UserId = u.UserId)

		INSERT dbo.aspnet_Users (ApplicationId, UserId, UserName, LoweredUserName, IsAnonymous, LastActivityDate)
		  SELECT @AppId, NEWID(), Name, LOWER(Name), 0, @CurrentTimeUtc
		  FROM   @tbNames

		INSERT INTO @tbUsers
		  SELECT  UserId
		  FROM	dbo.aspnet_Users au, @tbNames t
		  WHERE   LOWER(t.Name) = au.LoweredUserName AND au.ApplicationId = @AppId
	END

	IF (EXISTS (SELECT * FROM dbo.aspnet_UsersInRoles ur, @tbUsers tu, @tbRoles tr WHERE tu.UserId = ur.UserId AND tr.RoleId = ur.RoleId))
	BEGIN
		SELECT TOP 1 UserName, RoleName
		FROM		 dbo.aspnet_UsersInRoles ur, @tbUsers tu, @tbRoles tr, aspnet_Users u, aspnet_Roles r
		WHERE		u.UserId = tu.UserId AND r.RoleId = tr.RoleId AND tu.UserId = ur.UserId AND tr.RoleId = ur.RoleId

		IF( @TranStarted = 1 )
			ROLLBACK TRANSACTION
		RETURN(3)
	END

	INSERT INTO dbo.aspnet_UsersInRoles (UserId, RoleId)
	SELECT UserId, RoleId
	FROM @tbUsers, @tbRoles

	IF( @TranStarted = 1 )
		COMMIT TRANSACTION
	RETURN(0)
END                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     

GO
/****** Object:  StoredProcedure [dbo].[aspnet_UsersInRoles_FindUsersInRole]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[aspnet_UsersInRoles_FindUsersInRole]
    @ApplicationName  nvarchar(256),
    @RoleName         nvarchar(256),
    @UserNameToMatch  nvarchar(256)
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
        RETURN(1)
     DECLARE @RoleId uniqueidentifier
     SELECT  @RoleId = NULL

     SELECT  @RoleId = RoleId
     FROM    dbo.aspnet_Roles
     WHERE   LOWER(@RoleName) = LoweredRoleName AND ApplicationId = @ApplicationId

     IF (@RoleId IS NULL)
         RETURN(1)

    SELECT u.UserName
    FROM   dbo.aspnet_Users u, dbo.aspnet_UsersInRoles ur
    WHERE  u.UserId = ur.UserId AND @RoleId = ur.RoleId AND u.ApplicationId = @ApplicationId AND LoweredUserName LIKE LOWER(@UserNameToMatch)
    ORDER BY u.UserName
    RETURN(0)
END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_UsersInRoles_GetRolesForUser]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[aspnet_UsersInRoles_GetRolesForUser]
    @ApplicationName  nvarchar(256),
    @UserName         nvarchar(256)
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
        RETURN(1)
    DECLARE @UserId uniqueidentifier
    SELECT  @UserId = NULL

    SELECT  @UserId = UserId
    FROM    dbo.aspnet_Users
    WHERE   LoweredUserName = LOWER(@UserName) AND ApplicationId = @ApplicationId

    IF (@UserId IS NULL)
        RETURN(1)

    SELECT r.RoleName
    FROM   dbo.aspnet_Roles r, dbo.aspnet_UsersInRoles ur
    WHERE  r.RoleId = ur.RoleId AND r.ApplicationId = @ApplicationId AND ur.UserId = @UserId
    ORDER BY r.RoleName
    RETURN (0)
END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_UsersInRoles_GetUsersInRoles]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[aspnet_UsersInRoles_GetUsersInRoles]
    @ApplicationName  nvarchar(256),
    @RoleName         nvarchar(256)
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
        RETURN(1)
     DECLARE @RoleId uniqueidentifier
     SELECT  @RoleId = NULL

     SELECT  @RoleId = RoleId
     FROM    dbo.aspnet_Roles
     WHERE   LOWER(@RoleName) = LoweredRoleName AND ApplicationId = @ApplicationId

     IF (@RoleId IS NULL)
         RETURN(1)

    SELECT u.UserName
    FROM   dbo.aspnet_Users u, dbo.aspnet_UsersInRoles ur
    WHERE  u.UserId = ur.UserId AND @RoleId = ur.RoleId AND u.ApplicationId = @ApplicationId
    ORDER BY u.UserName
    RETURN(0)
END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_UsersInRoles_IsUserInRole]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[aspnet_UsersInRoles_IsUserInRole]
    @ApplicationName  nvarchar(256),
    @UserName         nvarchar(256),
    @RoleName         nvarchar(256)
AS
BEGIN
    DECLARE @ApplicationId uniqueidentifier
    SELECT  @ApplicationId = NULL
    SELECT  @ApplicationId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
    IF (@ApplicationId IS NULL)
        RETURN(2)
    DECLARE @UserId uniqueidentifier
    SELECT  @UserId = NULL
    DECLARE @RoleId uniqueidentifier
    SELECT  @RoleId = NULL

    SELECT  @UserId = UserId
    FROM    dbo.aspnet_Users
    WHERE   LoweredUserName = LOWER(@UserName) AND ApplicationId = @ApplicationId

    IF (@UserId IS NULL)
        RETURN(2)

    SELECT  @RoleId = RoleId
    FROM    dbo.aspnet_Roles
    WHERE   LoweredRoleName = LOWER(@RoleName) AND ApplicationId = @ApplicationId

    IF (@RoleId IS NULL)
        RETURN(3)

    IF (EXISTS( SELECT * FROM dbo.aspnet_UsersInRoles WHERE  UserId = @UserId AND RoleId = @RoleId))
        RETURN(1)
    ELSE
        RETURN(0)
END

GO
/****** Object:  StoredProcedure [dbo].[aspnet_UsersInRoles_RemoveUsersFromRoles]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[aspnet_UsersInRoles_RemoveUsersFromRoles]
	@ApplicationName  nvarchar(256),
	@UserNames		  nvarchar(4000),
	@RoleNames		  nvarchar(4000)
AS
BEGIN
	DECLARE @AppId uniqueidentifier
	SELECT  @AppId = NULL
	SELECT  @AppId = ApplicationId FROM aspnet_Applications WHERE LOWER(@ApplicationName) = LoweredApplicationName
	IF (@AppId IS NULL)
		RETURN(2)


	DECLARE @TranStarted   bit
	SET @TranStarted = 0

	IF( @@TRANCOUNT = 0 )
	BEGIN
		BEGIN TRANSACTION
		SET @TranStarted = 1
	END

	DECLARE @tbNames  table(Name nvarchar(256) NOT NULL PRIMARY KEY)
	DECLARE @tbRoles  table(RoleId uniqueidentifier NOT NULL PRIMARY KEY)
	DECLARE @tbUsers  table(UserId uniqueidentifier NOT NULL PRIMARY KEY)
	DECLARE @Num	  int
	DECLARE @Pos	  int
	DECLARE @NextPos  int
	DECLARE @Name	  nvarchar(256)
	DECLARE @CountAll int
	DECLARE @CountU	  int
	DECLARE @CountR	  int


	SET @Num = 0
	SET @Pos = 1
	WHILE(@Pos <= LEN(@RoleNames))
	BEGIN
		SELECT @NextPos = CHARINDEX(N',', @RoleNames,  @Pos)
		IF (@NextPos = 0 OR @NextPos IS NULL)
			SELECT @NextPos = LEN(@RoleNames) + 1
		SELECT @Name = RTRIM(LTRIM(SUBSTRING(@RoleNames, @Pos, @NextPos - @Pos)))
		SELECT @Pos = @NextPos+1

		INSERT INTO @tbNames VALUES (@Name)
		SET @Num = @Num + 1
	END

	INSERT INTO @tbRoles
	  SELECT RoleId
	  FROM   dbo.aspnet_Roles ar, @tbNames t
	  WHERE  LOWER(t.Name) = ar.LoweredRoleName AND ar.ApplicationId = @AppId
	SELECT @CountR = @@ROWCOUNT

	IF (@CountR <> @Num)
	BEGIN
		SELECT TOP 1 N'', Name
		FROM   @tbNames
		WHERE  LOWER(Name) NOT IN (SELECT ar.LoweredRoleName FROM dbo.aspnet_Roles ar,  @tbRoles r WHERE r.RoleId = ar.RoleId)
		IF( @TranStarted = 1 )
			ROLLBACK TRANSACTION
		RETURN(2)
	END


	DELETE FROM @tbNames WHERE 1=1
	SET @Num = 0
	SET @Pos = 1


	WHILE(@Pos <= LEN(@UserNames))
	BEGIN
		SELECT @NextPos = CHARINDEX(N',', @UserNames,  @Pos)
		IF (@NextPos = 0 OR @NextPos IS NULL)
			SELECT @NextPos = LEN(@UserNames) + 1
		SELECT @Name = RTRIM(LTRIM(SUBSTRING(@UserNames, @Pos, @NextPos - @Pos)))
		SELECT @Pos = @NextPos+1

		INSERT INTO @tbNames VALUES (@Name)
		SET @Num = @Num + 1
	END

	INSERT INTO @tbUsers
	  SELECT UserId
	  FROM   dbo.aspnet_Users ar, @tbNames t
	  WHERE  LOWER(t.Name) = ar.LoweredUserName AND ar.ApplicationId = @AppId

	SELECT @CountU = @@ROWCOUNT
	IF (@CountU <> @Num)
	BEGIN
		SELECT TOP 1 Name, N''
		FROM   @tbNames
		WHERE  LOWER(Name) NOT IN (SELECT au.LoweredUserName FROM dbo.aspnet_Users au,  @tbUsers u WHERE u.UserId = au.UserId)

		IF( @TranStarted = 1 )
			ROLLBACK TRANSACTION
		RETURN(1)
	END

	SELECT  @CountAll = COUNT(*)
	FROM	dbo.aspnet_UsersInRoles ur, @tbUsers u, @tbRoles r
	WHERE   ur.UserId = u.UserId AND ur.RoleId = r.RoleId

	IF (@CountAll <> @CountU * @CountR)
	BEGIN
		SELECT TOP 1 UserName, RoleName
		FROM		 @tbUsers tu, @tbRoles tr, dbo.aspnet_Users u, dbo.aspnet_Roles r
		WHERE		 u.UserId = tu.UserId AND r.RoleId = tr.RoleId AND
					 tu.UserId NOT IN (SELECT ur.UserId FROM dbo.aspnet_UsersInRoles ur WHERE ur.RoleId = tr.RoleId) AND
					 tr.RoleId NOT IN (SELECT ur.RoleId FROM dbo.aspnet_UsersInRoles ur WHERE ur.UserId = tu.UserId)
		IF( @TranStarted = 1 )
			ROLLBACK TRANSACTION
		RETURN(3)
	END

	DELETE FROM dbo.aspnet_UsersInRoles
	WHERE UserId IN (SELECT UserId FROM @tbUsers)
	  AND RoleId IN (SELECT RoleId FROM @tbRoles)
	IF( @TranStarted = 1 )
		COMMIT TRANSACTION
	RETURN(0)
END
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        

GO
/****** Object:  StoredProcedure [dbo].[aspnet_WebEvent_LogEvent]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[aspnet_WebEvent_LogEvent]
        @EventId         char(32),
        @EventTimeUtc    datetime,
        @EventTime       datetime,
        @EventType       nvarchar(256),
        @EventSequence   decimal(19,0),
        @EventOccurrence decimal(19,0),
        @EventCode       int,
        @EventDetailCode int,
        @Message         nvarchar(1024),
        @ApplicationPath nvarchar(256),
        @ApplicationVirtualPath nvarchar(256),
        @MachineName    nvarchar(256),
        @RequestUrl      nvarchar(1024),
        @ExceptionType   nvarchar(256),
        @Details         ntext
AS
BEGIN
    INSERT
        dbo.aspnet_WebEvent_Events
        (
            EventId,
            EventTimeUtc,
            EventTime,
            EventType,
            EventSequence,
            EventOccurrence,
            EventCode,
            EventDetailCode,
            Message,
            ApplicationPath,
            ApplicationVirtualPath,
            MachineName,
            RequestUrl,
            ExceptionType,
            Details
        )
    VALUES
    (
        @EventId,
        @EventTimeUtc,
        @EventTime,
        @EventType,
        @EventSequence,
        @EventOccurrence,
        @EventCode,
        @EventDetailCode,
        @Message,
        @ApplicationPath,
        @ApplicationVirtualPath,
        @MachineName,
        @RequestUrl,
        @ExceptionType,
        @Details
    )
END

GO
/****** Object:  StoredProcedure [dbo].[BuildProductSearchIndex]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Darwin Zins
-- Create date: 5/25/2011
-- Description:	Build Product Search Index Data
-- =============================================
CREATE PROCEDURE [dbo].[BuildProductSearchIndex]
	@Incremental tinyint = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

UPDATE Product SET SearchLookup = 
	p.ProductCode + ' ' + 
	p.ErpDescription + ' ' + 
	p.MetaKeywords + ' ' + 
	p.MetaDescription + ' ' + 
	p.PageTitle + ' ' + 
	p.ModelNumber 
	FROM Product p
	WHERE p.StyleParentId IS NULL
	AND ((@Incremental = 0 AND p.IndexStatus <> 2) OR p.IndexStatus = 1)
END

GO
/****** Object:  StoredProcedure [dbo].[ELMAH_GetErrorsXml]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ELMAH_GetErrorsXml]
(
    @Application NVARCHAR(60),
    @PageIndex INT = 0,
    @PageSize INT = 15,
    @TotalCount INT OUTPUT
)
AS 

    SET NOCOUNT ON

    DECLARE @FirstTimeUTC DATETIME
    DECLARE @FirstSequence INT
    DECLARE @StartRow INT
    DECLARE @StartRowIndex INT

    SELECT 
        @TotalCount = COUNT(1) 
    FROM 
        [ELMAH_Error]
    WHERE 
        [Application] = @Application

    -- Get the ID of the first error for the requested page

    SET @StartRowIndex = @PageIndex * @PageSize + 1

    IF @StartRowIndex <= @TotalCount
    BEGIN

        SET ROWCOUNT @StartRowIndex

        SELECT  
            @FirstTimeUTC = [TimeUtc],
            @FirstSequence = [Sequence]
        FROM 
            [ELMAH_Error]
        WHERE   
            [Application] = @Application
        ORDER BY 
            [TimeUtc] DESC, 
            [Sequence] DESC

    END
    ELSE
    BEGIN

        SET @PageSize = 0

    END

    -- Now set the row count to the requested page size and get
    -- all records below it for the pertaining application.

    SET ROWCOUNT @PageSize

    SELECT 
        errorId     = [ErrorId], 
        application = [Application],
        host        = [Host], 
        type        = [Type],
        source      = [Source],
        message     = [Message],
        [user]      = [User],
        statusCode  = [StatusCode], 
        time        = CONVERT(VARCHAR(50), [TimeUtc], 126) + 'Z'
    FROM 
        [ELMAH_Error] error
    WHERE
        [Application] = @Application
    AND
        [TimeUtc] <= @FirstTimeUTC
    AND 
        [Sequence] <= @FirstSequence
    ORDER BY
        [TimeUtc] DESC, 
        [Sequence] DESC
    FOR
        XML AUTO


GO
/****** Object:  StoredProcedure [dbo].[ELMAH_GetErrorXml]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ELMAH_GetErrorXml]
(
    @Application NVARCHAR(60),
    @ErrorId UNIQUEIDENTIFIER
)
AS

    SET NOCOUNT ON

    SELECT 
        [AllXml]
    FROM 
        [ELMAH_Error]
    WHERE
        [ErrorId] = @ErrorId
    AND
        [Application] = @Application


GO
/****** Object:  StoredProcedure [dbo].[ELMAH_LogError]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ELMAH_LogError]
(
    @ErrorId UNIQUEIDENTIFIER,
    @Application NVARCHAR(60),
    @Host NVARCHAR(30),
    @Type NVARCHAR(100),
    @Source NVARCHAR(60),
    @Message NVARCHAR(500),
    @User NVARCHAR(50),
    @AllXml NTEXT,
    @StatusCode INT,
    @TimeUtc DATETIME
)
AS

    SET NOCOUNT ON

    INSERT
    INTO
        [ELMAH_Error]
        (
            [ErrorId],
            [Application],
            [Host],
            [Type],
            [Source],
            [Message],
            [User],
            [AllXml],
            [StatusCode],
            [TimeUtc]
        )
    VALUES
        (
            @ErrorId,
            @Application,
            @Host,
            @Type,
            @Source,
            @Message,
            @User,
            @AllXml,
            @StatusCode,
            @TimeUtc
        )


GO
/****** Object:  StoredProcedure [dbo].[GetPriceMatrix]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[GetPriceMatrix]
	  @ProductIds	IdList READONLY,
	  @CustomerIds  IdList READONLY
	AS
	BEGIN 

		SELECT	* 
		FROM	PriceMatrix pm (NOLOCK)
		WHERE	pm.ProductKeyPart in (select Id from @ProductIds)
				AND pm.CustomerKeyPart in (select Id from @CustomerIds)

	END

GO
/****** Object:  StoredProcedure [dbo].[NightlyMaintenance]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Darwin Zins
-- Create date: 2/13/2009
-- Description:	Stored Procedure to do Nightly Maintenance Tasks
-- 05/13/2013, jlindbo	- Added support for integration job log cleanup
-- 05/15/2013, jlindbo	- Change to integration cleanup to remove entire job
-- 10/31/2013, belav	- Add EmailMessage cleanup
-- 03/24/2014, jlindbo	- Added support for AbandonedCart rotation
-- 06/09/2014, pgaard	- Added ELMAH_Error log cleanup
-- 08/18/2014, amerrill	- Rfq order cleanup
-- =============================================
CREATE PROCEDURE [dbo].[NightlyMaintenance]
AS
BEGIN
	DECLARE 
		@RetentionWindow INT,
		@RetentionDate DATETIME,
		@Continue INT
	
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	INSERT INTO ApplicationLog (Source, Type, Message) VALUES ('NightlyMaintenance','INFO','Nightly Maintenance Starting')
	
	DECLARE @PurgeTable TABLE (Id UNIQUEIDENTIFIER)
	DECLARE @PurgeTableInt TABLE (Id Int)
	
	SET @Continue = 1
	WHILE (@Continue > 0)
	BEGIN
		INSERT INTO @PurgeTable SELECT DISTINCT TOP 100 co.CustomerOrderId AS Id FROM CustomerOrder co (NOLOCK) 
			LEFT JOIN OrderLine ol (NOLOCK) ON ol.CustomerOrderId = co.CustomerOrderId
			WHERE co.Status = 'Cart' AND co.OrderDate < DATEADD(day, -1, GETDATE()) AND ol.OrderLineId IS NULL
		DELETE co FROM CustomerOrder co INNER JOIN @PurgeTable pt ON pt.Id = co.CustomerOrderId
		SET @Continue = @@ROWCOUNT
		DELETE FROM @PurgeTable
	END

	IF NOT EXISTS(SELECT 1 FROM ApplicationSetting WHERE Name = 'ShoppingCartRetentionDays')
		INSERT INTO ApplicationSetting (Name, Value) VALUES ('ShoppingCartRetentionDays', '0')

	SELECT @RetentionWindow = CASE WHEN Value != 0 THEN CAST(Value AS INT) ELSE 1 END FROM ApplicationSetting WHERE Name = 'ShoppingCartRetentionDays'
	SET @RetentionWindow = -1 * @RetentionWindow
	SET @RetentionDate = DATEADD(day, @RetentionWindow, GETDATE())
	UPDATE co SET co.Status = 'AbandonedCart' FROM CustomerOrder co (NOLOCK) 
		LEFT JOIN OrderLine ol (NOLOCK) ON ol.CustomerOrderId = co.CustomerOrderId
		WHERE co.Status = 'Cart' AND co.OrderDate < DATEADD(day, @RetentionWindow, GETDATE()) AND ol.OrderLineId IS NOT NULL

	IF NOT EXISTS(SELECT 1 FROM ApplicationSetting WHERE Name = 'EmailMessagesRetentionDays')
		INSERT INTO ApplicationSetting (Name, Value) VALUES ('EmailMessagesRetentionDays', '60')

	SELECT @RetentionWindow = CAST(Value AS INT) FROM ApplicationSetting WHERE Name = 'EmailMessagesRetentionDays'
	SET @RetentionWindow = -1 * @RetentionWindow
	SET @RetentionDate = DATEADD(day, @RetentionWindow, GETDATE())
	SET @Continue = 1
	WHILE (@Continue > 0)
	BEGIN
		INSERT INTO @PurgeTable SELECT DISTINCT TOP 100 em.EmailMessageId AS Id FROM EmailMessage em (NOLOCK) 
			WHERE em.SentDate < @RetentionDate
		DELETE em FROM EmailMessage em INNER JOIN @PurgeTable pt ON pt.Id = em.EmailMessageId
		SET @Continue = @@ROWCOUNT
		DELETE FROM @PurgeTable
	END

	IF NOT EXISTS(SELECT 1 FROM ApplicationSetting WHERE Name = 'AbandonedCartRetentionDays')
		INSERT INTO ApplicationSetting (Name, Value) VALUES ('AbandonedCartRetentionDays', '90')

	SELECT @RetentionWindow = CAST(Value AS INT) FROM ApplicationSetting WHERE Name = 'AbandonedCartRetentionDays'
	SET @RetentionWindow = -1 * @RetentionWindow
	SET @RetentionDate = DATEADD(day, @RetentionWindow, GETDATE())
	SET @Continue = 1
	WHILE (@Continue > 0)
	BEGIN
		INSERT INTO @PurgeTable SELECT DISTINCT TOP 100 co.CustomerOrderId AS Id FROM CustomerOrder co (NOLOCK) 
			WHERE co.Status = 'Cart' AND co.OrderDate < @RetentionDate
		DELETE co FROM CustomerOrder co INNER JOIN @PurgeTable pt ON pt.Id = co.CustomerOrderId
		SET @Continue = @@ROWCOUNT
		DELETE FROM @PurgeTable
	END

	IF NOT EXISTS(SELECT 1 FROM ApplicationSetting WHERE Name = 'ApplicationLogRetentionDays')
		INSERT INTO ApplicationSetting (Name, Value) VALUES ('ApplicationLogRetentionDays', '14')

	SELECT @RetentionWindow = CAST(Value AS INT) FROM ApplicationSetting WHERE Name = 'ApplicationLogRetentionDays'
	SET @RetentionWindow = -1 * @RetentionWindow
	SET @RetentionDate = DATEADD(day, @RetentionWindow, GETDATE())
	SET @Continue = 1
	WHILE (@Continue > 0)
	BEGIN
		INSERT INTO @PurgeTable SELECT TOP 100 al.ApplicationLogId FROM ApplicationLog al (NOLOCK) WHERE al.LogDate < @RetentionDate
		DELETE al FROM ApplicationLog al INNER JOIN @PurgeTable pt ON pt.Id = al.ApplicationLogId
		SET @Continue = @@ROWCOUNT
		DELETE FROM @PurgeTable
	END

	SET @Continue = 1
	WHILE (@Continue > 0)
	BEGIN
		INSERT INTO @PurgeTableInt SELECT TOP 100 ee.Sequence FROM ELMAH_Error ee (NOLOCK) WHERE ee.TimeUtc < @RetentionDate
		DELETE ee FROM ELMAH_Error ee INNER JOIN @PurgeTableInt pt ON pt.Id = ee.Sequence
		SET @Continue = @@ROWCOUNT
		DELETE FROM @PurgeTableInt
	END

	IF NOT EXISTS(SELECT 1 FROM ApplicationSetting WHERE Name = 'IntegrationJobLogRetentionDays')
		INSERT INTO ApplicationSetting (Name, Value) VALUES ('IntegrationJobLogRetentionDays', '14')

	SELECT @RetentionWindow = CAST(Value AS INT) FROM ApplicationSetting WHERE Name = 'IntegrationJobLogRetentionDays'
	SET @RetentionWindow = -1 * @RetentionWindow
	SET @RetentionDate = DATEADD(day, @RetentionWindow, GETDATE())
	SET @Continue = 1
	WHILE (@Continue > 0)
	BEGIN
		INSERT INTO @PurgeTable SELECT TOP 100 ij.IntegrationJobId FROM IntegrationJob ij (NOLOCK) WHERE ij.StartDateTime < @RetentionDate
		DELETE ij FROM IntegrationJob ij INNER JOIN @PurgeTable pt ON pt.Id = ij.IntegrationJobId
		SET @Continue = @@ROWCOUNT
		DELETE FROM @PurgeTable
	END

	SET @Continue = 1
	WHILE (@Continue > 0)
	BEGIN
		INSERT INTO @PurgeTable SELECT TOP 100 st.ScheduledTaskId FROM ScheduledTask st (NOLOCK) WHERE st.IsRealTime = 1 and st.LastRunDateTime < CAST(CONVERT(CHAR(11), GETDATE(), 113) AS DATETIME)
		DELETE st FROM ScheduledTask st INNER JOIN @PurgeTable pt ON pt.Id = st.ScheduledTaskId
		SET @Continue = @@ROWCOUNT
		DELETE FROM @PurgeTable
	END
	
	IF NOT EXISTS(SELECT 1 FROM ApplicationSetting WHERE Name = 'ScheduledTaskRetentionDays')
		INSERT INTO ApplicationSetting (Name, Value) VALUES ('ScheduledTaskRetentionDays', '14')

	SELECT @RetentionWindow = CAST(Value AS INT) FROM ApplicationSetting WHERE Name = 'ScheduledTaskRetentionDays'
	SET @RetentionWindow = -1 * @RetentionWindow
	SET @RetentionDate = DATEADD(day, @RetentionWindow, GETDATE())
	SET @Continue = 1
	WHILE (@Continue > 0)
	BEGIN
		INSERT INTO @PurgeTable SELECT TOP 100 st.ScheduledTaskId FROM ScheduledTask st (NOLOCK) WHERE st.IsRealTime = 0 AND st.MinuteInterval = 0 AND st.LastRunDateTime < @RetentionDate
		DELETE st FROM ScheduledTask st INNER JOIN @PurgeTable pt ON pt.Id = st.ScheduledTaskId
		SET @Continue = @@ROWCOUNT
		DELETE FROM @PurgeTable
	END

	IF NOT EXISTS(SELECT 1 FROM ApplicationSetting WHERE Name = 'RfqOrderRetentionDays')
		INSERT INTO ApplicationSetting (Name, Value) VALUES ('RfqOrderRetentionDays', '90')

	SELECT @RetentionWindow = CAST(Value AS INT) FROM ApplicationSetting WHERE Name = 'RfqOrderRetentionDays'
	SET @RetentionWindow = -1 * @RetentionWindow
	SET @RetentionDate = DATEADD(day, @RetentionWindow, GETDATE())
	SET @Continue = 1
	WHILE (@Continue > 0)
	BEGIN
		INSERT INTO @PurgeTable 
		SELECT DISTINCT TOP 100 co.CustomerOrderId AS Id 
		FROM	CustomerOrder co (NOLOCK) 
		WHERE	co.Type = 'Quote' 
				AND (
					(co.QuoteExpirationDate < @RetentionDate AND co.Status IN ('QuoteCreated','QuoteProposed','QuoteRejected','QuoteRequested'))
					OR (co.Status = 'QuoteCreated' AND co.QuoteExpirationDate IS NULL AND co.OrderDate < @RetentionDate)
					)

		DELETE co FROM CustomerOrder co INNER JOIN @PurgeTable pt ON pt.Id = co.CustomerOrderId
		SET @Continue = @@ROWCOUNT
		DELETE FROM @PurgeTable
	END
	
    EXEC sp_updatestats

	INSERT INTO ApplicationLog (Source, Type, Message) VALUES ('NightlyMaintenance','INFO','Nightly Maintenance Finished')
	
END

GO
/****** Object:  StoredProcedure [dbo].[PriceCalculator_Epicor]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PriceCalculator_Epicor]
		@CustomerId        uniqueidentifier = null,
		@ProductId         uniqueidentifier = null,
		@QtyOrdered        decimal(18,5) = 0,
		@CurrencyCode      nvarchar(50) = '',
		@Warehouse         nvarchar(50) = '',
		@UnitOfMeasure     nvarchar(50) = '',
		@PricingDate       datetime = null,
		@RegularPrice      tinyint = 0,  -- if 1 return price without sale or customer pricing  
		@Price             decimal(18,5) OUTPUT,
		@IsSalePrice       tinyint OUTPUT  -- only valid if ReturnListPrice = 0
	AS
	BEGIN 
		declare
			@Loop               int,
			@CurAmount          decimal(18,5),
			@CurAltAmount       decimal(18,5),
			@CurBrkQty          decimal(18,5),
			@CurPriceBasis      nvarchar(50),
			@CurAdjType         nvarchar(50),
			@tmpBasisValue      decimal(18,5),
			@tmpAdjustValue     decimal(18,5),
			@tmpPriceBasis      nvarchar(50),
			@VendorSaleMarkup   decimal(18,5),
			@ProductPriceCode	nvarchar(50),
			@ProductUM			nvarchar(50),
			@UnitCost			decimal(18,5),
			@ProductVendorId	uniqueidentifier,
			@ListPrice			decimal(18,5),
			@PriceMatrixId		uniqueidentifier,
			@RecordType			nvarchar(50),
			@SalePrice			decimal(18,5)

	/* SyteLine-specific variables */
	DECLARE
		@PriceLevel1        decimal(18,5),
		@PriceLevel2        decimal(18,5),
		@PriceLevel3        decimal(18,5),
		@PriceLevel4        decimal(18,5),
		@PriceLevel5        decimal(18,5),
		@PriceLevel6        decimal(18,5)

	IF @PricingDate IS NULL
		SET @PricingDate = getdate()
	
	SET @IsSalePrice = 0
	SET @tmpBasisValue = 0

	/* If they want list price, whack the customer reference */
	IF @RegularPrice <> 0 
		SET @CustomerId = null

	/* First get the product information */
	IF @ProductID IS null
	BEGIN
		print 'Error - no product selected'
		RETURN 99
	END

	-- Get Product Info
	SELECT 
			@ProductPriceCode = PriceCode, 
			@ProductUM = UnitOfMeasure,
			@UnitCost = Cost,
			@ProductVendorId = VendorId
		FROM Product (NOLOCK)
		WHERE ProductId = @ProductId

	IF IsNull(@UnitOfMeasure,'') = ''
		SET @UnitOfMeasure = @ProductUM

	/* Get List Price for basis calculations */
	set @ListPrice = dbo.GetListPrice_Epicor(@ProductId,@CurrencyCode,@Warehouse,@UnitOfMeasure,@PricingDate)
	
	if @ListPrice is null
	begin
		set @ListPrice = 0
	end

 	/* Now try and find which record will hold the key */
	--select @CustomerId,@ProductId,@CurrencyCode,@Warehouse,@UnitOfMeasure,@PricingDate
	SET @PriceMatrixId = dbo.GetPriceMatrixId_Epicor(@CustomerId,@ProductId,@CurrencyCode,@Warehouse,@UnitOfMeasure,@PricingDate)
	select @PriceMatrixId  

	/* Check to see if we have a valid record and read it in */
	IF @PriceMatrixId IS NULL
	BEGIN
		SET @Price = @ListPrice
	END
	else
	begin
		select 
			@RecordType = recordtype,
			@curamount = curamount,
			@CurBrkQty = curbrkqty,
			@CurPriceBasis = curpricebasis,	
			@CurAdjType = curadjtype,
			@tmpBasisValue = curBasisValue
		from dbo.GetPricingBaisis_Epicor(@PriceMatrixId,@QtyOrdered)
	  
		/* Set price basis level */
		-- SET @tmpBasisValue = 0

		IF @CurPriceBasis = 'C' SET @tmpBasisValue = @UnitCost
		IF @CurPriceBasis = 'M' SET @tmpBasisValue = @UnitCost -- margin
		IF @CurPriceBasis = 'MU' SET @tmpBasisValue = @UnitCost -- markup (mu/vmu)
		IF @CurPriceBasis = 'L' SET @tmpBasisValue = @ListPrice
	    
--		IF @CurPriceBasis = 'P1' SET @tmpBasisValue = @PriceLevel1
--		IF @CurPriceBasis = 'P2' SET @tmpBasisValue = @PriceLevel2
--		IF @CurPriceBasis = 'P3' SET @tmpBasisValue = @PriceLevel3
--		IF @CurPriceBasis = 'P4' SET @tmpBasisValue = @PriceLevel4
--		IF @CurPriceBasis = 'P5' SET @tmpBasisValue = @PriceLevel5
--		IF @CurPriceBasis = 'P6' SET @tmpBasisValue = @PriceLevel6


--	select @RecordType 'RecordType', @tmpBasisValue 'TmpBasisValue',@ListPrice 'ListPrice',
--	@CurAdjType 'CurAdjType', @CurPriceBasis 'PriceBasis', @UnitCost 'Cost', @CurAmount 'CurAmount'

		IF @CurPriceBasis = ''
		begin
			set @Price = @CurAmount
		end

		/* Get vendor markup % if VMU */
		IF @CurPriceBasis = 'VMU' AND @ProductVendorId <> ''
		BEGIN
		  SET @VendorSaleMarkup = 0
		  SET @tmpAdjustValue = 0  -- if the customer needs a default markup, set here
		  SELECT  @tmpAdjustValue = RegularMarkup,
				  @VendorSaleMarkup = SaleMarkup
		  FROM Vendor (NOLOCK)
		  WHERE VendorId = @ProductVendorId    
		END  


		/* Calculate actual price based on current break */
	    
		/* Override Price */
		IF @CurPriceBasis = 'O' AND @CurAdjType = 'A'
		if @CurAmount = 0  
			SET @Price = @ListPrice
		else
			set @Price = @CurAmount

		/* Non-derived-Based types - always adds */
		IF @CurPriceBasis IN ('P1','P2','P3','P4','P5','P6')
		BEGIN
			IF @CurAdjType = 'A'
			begin
				set @Price = @ListPrice + @CurAmount
				--SET @Price = @tmpBasisValue + @CurAmount
			end

			IF @CurAdjType = 'P'
			begin
				--SET @Price = @ListPrice * (1 + @CurAmount / 100)
				SET @Price = @tmpBasisValue * (1 + @CurAmount / 100)
			end
		END -- non-derived

		IF @CurPriceBasis IN ('C','MU','L')
		begin
			IF @CurAdjType = 'A'
			begin
				SET @Price = @tmpBasisValue + @CurAmount
			end

			IF @CurAdjType = 'P'
			begin
				SET @Price = @tmpBasisValue * (1 + @CurAmount / 100)
			end

		end

		/* Margin */
		IF @CurPriceBasis = 'M'
		BEGIN
		  IF @CurAdjType = 'A'
			SET @Price = @CurAmount + @tmpBasisValue
		  IF @CurAdjType = 'P'
			SET @Price = @tmpBasisValue / (1 - @CurAmount / 100) 
		END

  END -- Price Matrix record found


  -- Now go for Sale Price - assumed to be all price overrides
  IF @RegularPrice = 0
  BEGIN
    
    /* Special case - vendor markup % */
    IF @CurPriceBasis = 'VMU' AND @VendorSaleMarkup > 0 and @UnitCost > 0    
    BEGIN
      SET @SalePrice = @UnitCost * (1 + @VendorSaleMarkup / 100)
    END
    ELSE 
	BEGIN
		set @SalePrice = dbo.GetVendorSalePrice_Epicor(@QtyOrdered,@ProductId,@CurrencyCode,@Warehouse,@UnitOfMeasure,@PricingDate)
    END --  Standard vs Vendor MU sales price

    IF @SalePrice > 0 AND @SalePrice < @Price
      SELECT
        @Price = @SalePrice, -- if it's actually less, set it
        @IsSalePrice = 1

  END -- RegularPrice=0


END -- End of procedure

GO
/****** Object:  StoredProcedure [dbo].[PriceCalculator_Epicor9]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Price Calculator - Epicor9 (also used for Vantage803)
-- Created: 6/13/11, tjf
-- 
-- This routine will first construct a temp table in order of the price lists to review
-- and then go through each one until if finds the appropriate data (basically PriceBasis and
-- AdjustmentAmount) to calculate from

CREATE PROCEDURE [dbo].[PriceCalculator_Epicor9]
  @CustomerId        uniqueidentifier = null,
  @ProductId         uniqueidentifier = null,
  @QtyOrdered        decimal(18,5) = 0,
  @CurrencyCode      nvarchar(50) = '',
  @Warehouse         nvarchar(50) = '',
  @UnitOfMeasure     nvarchar(50) = '',
  @PricingDate       datetime = null,
  @RegularPrice      tinyint = 0,  -- if 1 return price without sale or customer pricing  
  @Price             decimal(18,5) OUTPUT,
  @IsSalePrice       tinyint OUTPUT  -- only valid if ReturnListPrice = 0
AS
BEGIN 


  DECLARE
    @PriceMatrixId      uniqueidentifier,
    @SalePrice          decimal(18,5),
    @SaleStartDate      datetime,
    @SaleEndDate        datetime,
    @ListPrice          decimal(18,5),
    @UnitCost           decimal(18,5),
    @ProductPriceCode   nvarchar(50),
    @ProductUM          nvarchar(50),
    @ProductVendorId    uniqueidentifier,
    @CustomerType       nvarchar(50),
    @ParentCustomerId   uniqueidentifier,
    @RecordType         nvarchar(50),
    @CustomerKeyPart    nvarchar(50),
    @ProductKeyPart     nvarchar(50),
    @CalcFlags          nvarchar(50),
    @BrkQty1            decimal(18,5),
    @BrkQty2            decimal(18,5),
    @BrkQty3            decimal(18,5),
    @BrkQty4            decimal(18,5),
    @BrkQty5            decimal(18,5),
    @BrkQty6            decimal(18,5),
    @BrkQty7            decimal(18,5),
    @BrkQty8            decimal(18,5),
    @BrkQty9            decimal(18,5),
    @BrkQty10           decimal(18,5),
    @BrkQty11           decimal(18,5),
    @PriceBasis1        nvarchar(50),
    @PriceBasis2        nvarchar(50),
    @PriceBasis3        nvarchar(50),
    @PriceBasis4        nvarchar(50),
    @PriceBasis5        nvarchar(50),
    @PriceBasis6        nvarchar(50),
    @PriceBasis7        nvarchar(50),
    @PriceBasis8        nvarchar(50),
    @PriceBasis9        nvarchar(50),
    @PriceBasis10       nvarchar(50),
    @PriceBasis11       nvarchar(50),
    @AdjType1           nvarchar(50),
    @AdjType2           nvarchar(50),
    @AdjType3           nvarchar(50),
    @AdjType4           nvarchar(50),
    @AdjType5           nvarchar(50),
    @AdjType6           nvarchar(50),
    @AdjType7           nvarchar(50),
    @AdjType8           nvarchar(50),
    @AdjType9           nvarchar(50),
    @AdjType10          nvarchar(50),
    @AdjType11          nvarchar(50),
    @Amount1            decimal(18,5),
    @Amount2            decimal(18,5),
    @Amount3            decimal(18,5),
    @Amount4            decimal(18,5),
    @Amount5            decimal(18,5),
    @Amount6            decimal(18,5),
    @Amount7            decimal(18,5),
    @Amount8            decimal(18,5),
    @Amount9            decimal(18,5),
    @Amount10           decimal(18,5),
    @Amount11           decimal(18,5),
    @AltAmount1         decimal(18,5),    
    @AltAmount2         decimal(18,5),    
    @AltAmount3         decimal(18,5),    
    @AltAmount4         decimal(18,5),    
    @AltAmount5         decimal(18,5),    
    @AltAmount6         decimal(18,5),    
    @AltAmount7         decimal(18,5),    
    @AltAmount8         decimal(18,5),    
    @AltAmount9         decimal(18,5),    
    @AltAmount10        decimal(18,5),    
    @AltAmount11        decimal(18,5),
    @Loop               int,
    @CurAmount          decimal(18,5),
    @CurAltAmount       decimal(18,5),
    @CurBrkQty          decimal(18,5),
    @CurPriceBasis      nvarchar(50),
    @CurAdjType         nvarchar(50),
    @tmpBasisValue      decimal(18,5),
    @tmpAdjustValue     decimal(18,5),
    @tmpPriceBasis      nvarchar(50),
    @VendorSaleMarkup   decimal(18,5)

  -- Epicor-specific
  DECLARE @BasePrice decimal(18,5)
  DECLARE @CurrPriceList nvarchar(50)
  DECLARE @SaveDiscount decimal(18,5)  
  DECLARE @CustomerDiscount decimal(18,5)
  DECLARE @Debug as tinyint
  SET @BasePrice = NULL
  SET @SaveDiscount = NULL
  SET @Debug = 0


  IF @PricingDate IS NULL
  BEGIN
    SET @PricingDate = getdate()
    SET @IsSalePrice = 0
  END	   


  /* First get the product information */
  IF @ProductID IS null
  BEGIN
    print 'Error - no product selected'
    RETURN 99
  END

  SELECT 
    @ProductPriceCode = PriceCode, 
    @ProductUM = UnitOfMeasure,
    @SalePrice = BasicSalePrice,  
    @ListPrice = BasicListPrice,
    @SaleStartDate = BasicSaleStart,
    @SaleEndDate = BasicSaleEnd
  FROM Product (NOLOCK)
  WHERE ProductId = @ProductId
    
  IF @SaleStartDate IS NULL 
    SET @SaleStartDate = getdate()
  
  IF IsNull(@UnitOfMeasure,'') = ''
    SET @UnitOfMeasure = @ProductUM
    
  SET @Price = NULL

  -- Check if no customer in or they just want list - give it to them
  IF @RegularPrice = 1
  BEGIN
    SET @Price = @ListPrice
    RETURN
  END
  
  IF @CustomerId is null
  BEGIN
    SET @Price = @ListPrice
    IF @SalePrice > 0 AND @SalePrice < @ListPrice AND
      @SaleStartDate < = @PricingDate AND 
      (@SaleEndDate IS NULL OR @SaleEndDate > @PricingDate)
      BEGIN
        SET @Price = @SalePrice
        SET @IsSalePrice = 1
      END
    RETURN
  END

  /* Next get the customer information */
  SELECT
    @CustomerType = CustomerType,
    @CustomerDiscount = Discount,
    @ParentCustomerId = ParentId
  FROM Customer (NOLOCK)
  WHERE CustomerId = @CustomerId



  /* Now try and find which record will hold the key */
  SET @PriceMatrixId = NULL
  SET @BasePrice = NULL

/* Create temp table entries for price lists - Customer/ShipTo first */
  IF object_id('tempdb..##PriceLists') IS NOT NULL
  BEGIN
     DROP TABLE ##PriceLists
  END
  CREATE TABLE ##PriceLists (
    [Sequence] [int] IDENTITY(1,1) NOT NULL,
    [PriceList] [nvarchar](50) NOT NULL)

  INSERT INTO ##PriceLists (PriceList) 
  SELECT PriceBasis01
  FROM PriceMatrix
  WHERE 
    RecordType = 'Customer Price List' AND
    CustomerKeyPart = @CustomerId AND
    Active <= @PricingDate AND
    (Deactivate IS NULL OR Deactivate > @PricingDate)
  ORDER BY ProductKeyPart

  /* Parent customer if any */
  IF @ParentCustomerId <> @CustomerId AND @ParentCustomerId is not null
  BEGIN
    INSERT INTO ##PriceLists (PriceList) 
    SELECT PriceBasis01
    FROM PriceMatrix
    WHERE 
      RecordType = 'Customer Price List' AND
      CustomerKeyPart = @ParentCustomerId AND
      Active <= @PricingDate AND
      (Deactivate IS NULL OR Deactivate > @PricingDate)
    ORDER BY ProductKeyPart
  END

  /* Customer Group */
  IF ISNULL(@CustomerType,'') <> ''
  BEGIN
    INSERT INTO ##PriceLists (PriceList) 
    SELECT PriceBasis01
    FROM PriceMatrix
    WHERE 
      RecordType = 'Customer Group Price List' AND
      CustomerKeyPart = @CustomerType AND
      Active <= @PricingDate AND
      (Deactivate IS NULL OR Deactivate > @PricingDate)
    ORDER BY ProductKeyPart
  END

  IF @Debug = 1 SELECT * FROM ##PriceLists -- DEBUG

  /* Now all the price lists are loaded in - need to traverse them to get the data and set the price */
  DECLARE cPriceList CURSOR FOR SELECT PriceList FROM ##PriceLists
  OPEN cPriceList
  FETCH NEXT FROM cPriceList INTO @CurrPriceList
  
  WHILE (@@FETCH_STATUS = 0 AND @Price IS NULL) 
  BEGIN
  IF @Debug = 1 select @CurrPriceList as 'CurrPriceList',@Price as '@Price'  
    /* For a given price list - now try to find product-specific record */
    SELECT @PriceMatrixId = PriceMatrixId
    FROM PriceMatrix (NOLOCK)
    WHERE
      RecordType = 'Price List Product' AND
      CurrencyCode = @CurrencyCode AND
      Warehouse = @Warehouse AND
      UnitOfMeasure = @UnitOfMeasure AND
      CustomerKeyPart = @CurrPriceList AND
      ProductKeyPart =  @ProductId AND
      Active <= @PricingDate AND
      (Deactivate IS NULL OR Deactivate > @PricingDate)

    IF @PriceMatrixId is NULL 
    BEGIN
      -- Find product group
      SELECT @PriceMatrixId = PriceMatrixId
      FROM PriceMatrix (NOLOCK)
      WHERE
        RecordType = 'Price List Product Group' AND
        CurrencyCode = @CurrencyCode AND
        Warehouse = @Warehouse AND
        UnitOfMeasure = @UnitOfMeasure AND
        CustomerKeyPart = @CurrPriceList AND
        ProductKeyPart =  @ProductPriceCode AND
        Active <= @PricingDate AND
        (Deactivate IS NULL OR Deactivate > @PricingDate)
    END
IF @Debug = 1 select @PriceMatrixId as 'CurrentMatxId'
    /* Got a real record - start to process it */
    IF @PriceMatrixId IS NOT NULL
    BEGIN    
      SELECT
        @BrkQty1 = BreakQty01,
        @BrkQty2 = BreakQty02,
        @BrkQty3 = BreakQty03,
        @BrkQty4 = BreakQty04,
        @BrkQty5 = BreakQty05,
        @BrkQty6 = BreakQty06,
        @BrkQty7= BreakQty07,
        @BrkQty8 = BreakQty08,
        @BrkQty9 = BreakQty09,
        @BrkQty10 = BreakQty10,
        @BrkQty11 = BreakQty11,
        @AdjType1 = AdjustmentType01,
        @AdjType2 = AdjustmentType02,
        @AdjType3 = AdjustmentType03,
        @AdjType4 = AdjustmentType04,
        @AdjType5 = AdjustmentType05,
        @AdjType6 = AdjustmentType06,
        @AdjType7 = AdjustmentType07,
        @AdjType8 = AdjustmentType08,
        @AdjType9 = AdjustmentType09,
        @AdjType10 = AdjustmentType10,
        @AdjType11 = AdjustmentType11,
        @Amount1 = Amount01,
        @Amount2 = Amount02,
        @Amount3 = Amount03,
        @Amount4 = Amount04,
        @Amount5 = Amount05,
        @Amount6 = Amount06,
        @Amount7 = Amount07,
        @Amount8 = Amount08,
        @Amount9 = Amount09,
        @Amount10 = Amount10,
        @Amount11 = Amount11,
        @AltAmount1 = AltAmount01           
      FROM PriceMatrix (NOLOCK) 
      WHERE PriceMatrixId = @PriceMatrixId

      IF @BasePrice is null and ISNULL(@AltAmount1,0) > 0 
        SET @BasePrice = @AltAmount1

      IF @QtyOrdered >= @BrkQty1 AND @BrkQty1 > 0
      SELECT
        @CurAmount = @Amount1,
        @CurBrkQty = @BrkQty1,    
        @CurAdjType = @AdjType1

      IF @QtyOrdered >= @BrkQty2 AND @BrkQty2 > 0
      SELECT
        @CurAmount = @Amount2,
        @CurBrkQty = @BrkQty2,
        @CurAdjType = @AdjType2

      IF @QtyOrdered >= @BrkQty3 AND @BrkQty3 > 0
      SELECT
        @CurAmount = @Amount3,
        @CurBrkQty = @BrkQty3,
        @CurAdjType = @AdjType3

      IF @QtyOrdered >= @BrkQty4 AND @BrkQty4 > 0
      SELECT
        @CurAmount = @Amount4,
        @CurBrkQty = @BrkQty4,
        @CurAdjType = @AdjType4

      IF @QtyOrdered >= @BrkQty5 AND @BrkQty5 > 0
      SELECT
        @CurAmount = @Amount5,
        @CurBrkQty = @BrkQty5,
        @CurAdjType = @AdjType5

      IF @QtyOrdered >= @BrkQty6 AND @BrkQty6 > 0
      SELECT
        @CurAmount = @Amount6,
        @CurBrkQty = @BrkQty6,        
        @CurAdjType = @AdjType6

      IF @QtyOrdered >= @BrkQty7 AND @BrkQty7 > 0
      SELECT
        @CurAmount = @Amount7,
        @CurBrkQty = @BrkQty7,        
        @CurAdjType = @AdjType7

      IF @QtyOrdered >= @BrkQty8 AND @BrkQty8 > 0
      SELECT
        @CurAmount = @Amount8,
        @CurBrkQty = @BrkQty8,      
        @CurAdjType = @AdjType8

      IF @QtyOrdered >= @BrkQty9 AND @BrkQty9 > 0
      SELECT
        @CurAmount = @Amount9,
        @CurBrkQty = @BrkQty9,        
        @CurAdjType = @AdjType9

      IF @QtyOrdered >= @BrkQty10 AND @BrkQty10 > 0
      SELECT
        @CurAmount = @Amount10,
        @CurBrkQty = @BrkQty10,        
        @CurAdjType = @AdjType10

      IF @QtyOrdered >= @BrkQty11 AND @BrkQty11 > 0
      SELECT
        @CurAmount = @Amount11,
        @CurBrkQty = @BrkQty11,        
        @CurAdjType = @AdjType11
        
  
if @DEbug = 1 select @SaveDiscount as 'SaveDiscount',@CurAmount as 'curamount',
@BasePrice as 'Base Price',@CurBrkQty as 'cur brk qty', @CurAdjType as 'CurAdjType',
@CustomerDiscount as 'Customer Disct %',@ListPrice as 'List Price'

      /* Do the actual math next */
      IF ISNULL(@BasePrice,0) > 0
        SET @Price = @BasePrice -- initial
        
      IF ISNULL(@SaveDiscount,0) > 0 
      BEGIN
        IF ISNULL(@BasePrice,0) > 0
          SELECT @Price = @BasePrice * (1 - (@SaveDiscount / 100))
      END
      ELSE BEGIN    
        IF @CurAdjType = 'A' 
          SET @Price = @CurAmount
        IF @CurAdjType = 'P' AND @BasePrice > 0
          SET @Price = @BasePrice * (1 - (@CurAmount / 100))
        IF @CurAdjType = 'P' AND ISNULL(@Price,0) = 0
          SET @SaveDiscount = @CurAmount         
      END
    END -- if we have a price matrix record
  
    FETCH NEXT FROM cPriceList INTO @CurrPriceList
  END  -- while loop
  
  CLOSE cPriceList
  DEALLOCATE cPriceList
  DROP TABLE ##PriceLists

  -- Final check - discount but no base price (get from List Price)
  IF ISNULL(@BasePrice,0) = 0 AND ISNULL(@ListPrice,0) > 0
  BEGIN
    IF @Debug = 1 SELECT 'part master base - save disct = ',@SaveDiscount
    IF @SaveDiscount > 0 
       SET @Price = @ListPrice * (1 - (@SaveDiscount / 100))
    ELSE
        SET @Price = @ListPrice        
  END

  IF @Price is null 
    SET @Price = @ListPrice
    
  -- Apply customer discount next
  SET @Price = @Price * (1 - @CustomerDiscount / 100)
  
  IF @SalePrice > 0 AND @SalePrice < @Price AND
    @SaleStartDate <= @PricingDate AND (@SaleEndDate IS NULL OR @SaleEndDate >= @PricingDate)
    BEGIN
      SELECT
        @Price = @SalePrice, -- if it's actually less, set it
        @IsSalePrice = 1
    END
    
    IF @Debug = 1 select @Price as 'Returned price',@IsSalePrice as 'IsSalePrice'

END -- End of procedure






GO
/****** Object:  StoredProcedure [dbo].[PriceCalculator_Epicor9Vantage]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Price Calculator - Epicor9Vantage (also used for Vantage803)
-- Created: 6/13/11, tjf
-- 1/20/12, tjf, Problem with price list seq > 10, convert to INT
-- 2/27/12, tjf, Defaulting customer group if no customer passed in
-- 3/7/12,  tjf, Saving @QtyPriceMatrixID for breaks; only getting disct/qty brk
--				   from a single record; scan further for base price only - rework for secondary cursor
-- 2/6/13,  pwg, Fix output format to make this compatible with isc 3.4.
-- 5/22/13, jel, Fix to have percent off breaks return appropriate amount and have breaks start with base price at 1 (CW 42523)
-- 7/14/14, tjf, Somehow missed % off list price situation - adding back in
-- 
-- This routine will first construct a temp table in order of the price lists to review
-- and then go through each one until if finds the appropriate data (basically PriceBasis and
-- AdjustmentAmount) to calculate from

CREATE PROCEDURE [dbo].[PriceCalculator_Epicor9Vantage]
  @CustomerId        uniqueidentifier = null,
  @ProductId         uniqueidentifier = null,
  @QtyOrdered        decimal(18,5) = 0,
  @CurrencyCode      nvarchar(50) = '',
  @Warehouse         nvarchar(50) = '',
  @UnitOfMeasure     nvarchar(50) = '',
  @PricingDate       datetime = null,
  @RegularPrice      tinyint = 0,  -- if 1 return price without sale or customer pricing  
  @Price             decimal(18,5) OUTPUT,
  @IsSalePrice       tinyint OUTPUT  -- only valid if ReturnListPrice = 0
AS
BEGIN 

  DECLARE
    @PriceMatrixId      uniqueidentifier,
    @SalePrice          decimal(18,5),
    @SaleStartDate      datetime,
    @SaleEndDate        datetime,
    @ListPrice          decimal(18,5),
    @BasicListPrice     decimal(18,5),
    @UnitCost           decimal(18,5),
    @ProductCode        nvarchar(50),
    @ProductUM          nvarchar(50),
    @ProductVendorId    uniqueidentifier,
    @CustomerType       nvarchar(50),
    @ParentCustomerId   uniqueidentifier,
    @RecordType         nvarchar(50),
    @CustomerKeyPart    nvarchar(50),
    @ProductKeyPart     nvarchar(50),
    @CalcFlags          nvarchar(50),
    @BrkQty1            decimal(18,5),
    @BrkQty2            decimal(18,5),
    @BrkQty3            decimal(18,5),
    @BrkQty4            decimal(18,5),
    @BrkQty5            decimal(18,5),
    @BrkQty6            decimal(18,5),
    @BrkQty7            decimal(18,5),
    @BrkQty8            decimal(18,5),
    @BrkQty9            decimal(18,5),
    @BrkQty10           decimal(18,5),
    @BrkQty11           decimal(18,5),
    @PriceBasis1        nvarchar(50),
    @PriceBasis2        nvarchar(50),
    @PriceBasis3        nvarchar(50),
    @PriceBasis4        nvarchar(50),
    @PriceBasis5        nvarchar(50),
    @PriceBasis6        nvarchar(50),
    @PriceBasis7        nvarchar(50),
    @PriceBasis8        nvarchar(50),
    @PriceBasis9        nvarchar(50),
    @PriceBasis10       nvarchar(50),
    @PriceBasis11       nvarchar(50),
    @AdjType1           nvarchar(50),
    @AdjType2           nvarchar(50),
    @AdjType3           nvarchar(50),
    @AdjType4           nvarchar(50),
    @AdjType5           nvarchar(50),
    @AdjType6           nvarchar(50),
    @AdjType7           nvarchar(50),
    @AdjType8           nvarchar(50),
    @AdjType9           nvarchar(50),
    @AdjType10          nvarchar(50),
    @AdjType11          nvarchar(50),
    @Amount1            decimal(18,5),
    @Amount2            decimal(18,5),
    @Amount3            decimal(18,5),
    @Amount4            decimal(18,5),
    @Amount5            decimal(18,5),
    @Amount6            decimal(18,5),
    @Amount7            decimal(18,5),
    @Amount8            decimal(18,5),
    @Amount9            decimal(18,5),
    @Amount10           decimal(18,5),
    @Amount11           decimal(18,5),
    @AltAmount1         decimal(18,5),    
    @AltAmount2         decimal(18,5),    
    @AltAmount3         decimal(18,5),    
    @AltAmount4         decimal(18,5),    
    @AltAmount5         decimal(18,5),    
    @AltAmount6         decimal(18,5),    
    @AltAmount7         decimal(18,5),    
    @AltAmount8         decimal(18,5),    
    @AltAmount9         decimal(18,5),    
    @AltAmount10        decimal(18,5),    
    @AltAmount11        decimal(18,5),
    @Loop               int,
    @CurAmount          decimal(18,5),
    @CurAltAmount       decimal(18,5),
    @CurBrkQty          decimal(18,5),
    @CurPriceBasis      nvarchar(50),
    @CurAdjType         nvarchar(50),
    @tmpBasisValue      decimal(18,5),
    @tmpAdjustValue     decimal(18,5),
    @tmpPriceBasis      nvarchar(50),
    @VendorSaleMarkup   decimal(18,5),
    @UsingBaseUOM		bit

  DECLARE @PriceBreaks TABLE (BreakQty DECIMAL(18,5), Price DECIMAL(18,5))
	
  -- Epicor-specific
  DECLARE @BasePrice decimal(18,5)
  DECLARE @SaveDiscount decimal(18,5)  
  DECLARE @QtyPriceMatrixID uniqueidentifier
  DECLARE @CurrQtyPriceList nvarchar(50)
  DECLARE @CurrBasePriceList nvarchar(50)
  DECLARE @CustomerDiscount decimal(18,5)
  DECLARE @Debug as tinyint
  SET @BasePrice = NULL
  SET @SaveDiscount = NULL
  SET @Debug = 1
  
 
  IF @PricingDate IS NULL
  BEGIN
    SET @PricingDate = getdate()
    SET @IsSalePrice = 0
  END    
    
  IF @Debug = 1 
    SELECT @ProductId as 'ProductId',@CustomerId as 'CustId',@PricingDate as 'Price Date'


  /* First get the product information */
  IF @ProductID IS null
  BEGIN
    print 'Error - no product selected'
    RETURN 99
  END

  SELECT 
    @ProductCode = ProductCode, 
    @ProductUM = UnitOfMeasure,
    @SalePrice = BasicSalePrice,  
    @ListPrice = BasicListPrice,
    @SaleStartDate = BasicSaleStart,
    @SaleEndDate = BasicSaleEnd
  FROM Product (NOLOCK)
  WHERE ProductId = @ProductId
    
  IF @SaleStartDate IS NULL 
    SET @SaleStartDate = getdate()
  
  IF IsNull(@UnitOfMeasure,'') = ''
    SET @UnitOfMeasure = @ProductUM
    
  SET @UsingBaseUOM = 1
  IF (@UnitOfMeasure <> @ProductUM)
	SET @UsingBaseUOM = 0
    
  SET @Price = NULL

  -- Check if no customer in or they just want list - give it to them
  IF @RegularPrice = 1
  BEGIN
    SET @Price = @ListPrice
	SELECT * FROM @PriceBreaks  -- empty for now
	SELECT @Price AS Price, @IsSalePrice AS IsSalePrice
    RETURN
  END
  
  IF @CustomerId is null
  BEGIN
	SELECT
      @CustomerType = Value,
      @CustomerDiscount = 0,
      @ParentCustomerId = NULL 
      FROM ApplicationSetting WHERE name = 'Default_CustomerType'
    --SET @Price = @ListPrice
    --IF @SalePrice > 0 AND @SalePrice < @ListPrice AND
    --  @SaleStartDate < = @PricingDate AND 
    --  (@SaleEndDate IS NULL OR @SaleEndDate > @PricingDate)
    --  BEGIN
    --    SET @Price = @SalePrice
    --    SET @IsSalePrice = 1
    --  END
    --RETURN
  END

  /* Next get the customer information */
  SELECT
    @CustomerType = CustomerType,
    @CustomerDiscount = Discount,
    @ParentCustomerId = ParentId
  FROM Customer (NOLOCK)
  WHERE CustomerId = @CustomerId


  /* Now try and find which record will hold the key */
  SET @PriceMatrixId = NULL
  SET @BasePrice = NULL

/* Create temp table entries for price lists - Customer/ShipTo first */
  IF object_id('tempdb..#PriceLists') IS NOT NULL
  BEGIN
     DROP TABLE #PriceLists
  END
  CREATE TABLE #PriceLists (
    [Sequence] [int] IDENTITY(1,1) NOT NULL,
    [PriceList] [nvarchar](50) NOT NULL)

  INSERT INTO #PriceLists (PriceList) 
  SELECT PriceBasis01
  FROM PriceMatrix
  WHERE 
    RecordType = 'Customer Price List' AND
    CustomerKeyPart = @CustomerId AND
    Active <= @PricingDate AND
    (Deactivate IS NULL OR Deactivate > @PricingDate)
  ORDER BY CAST(ProductKeyPart AS INT)

  /* Parent customer if any */
  IF @ParentCustomerId <> @CustomerId AND @ParentCustomerId is not null
  BEGIN
    INSERT INTO #PriceLists (PriceList) 
    SELECT PriceBasis01
    FROM PriceMatrix
    WHERE 
      RecordType = 'Customer Price List' AND
      CustomerKeyPart = @ParentCustomerId AND
      Active <= @PricingDate AND
      (Deactivate IS NULL OR Deactivate > @PricingDate)
    ORDER BY CAST(ProductKeyPart as INT)
  END

  /* Customer Group */
  IF ISNULL(@CustomerType,'') <> ''
  BEGIN
    INSERT INTO #PriceLists (PriceList) 
    SELECT PriceBasis01
    FROM PriceMatrix
    WHERE 
      RecordType = 'Customer Group Price List' AND
      CustomerKeyPart = @CustomerType AND
      Active <= @PricingDate AND
      (Deactivate IS NULL OR Deactivate > @PricingDate)
    ORDER BY CAST(ProductKeyPart AS INT)
  END

  IF @Debug = 1 SELECT * FROM #PriceLists -- DEBUG

  /* Now all the price lists are loaded in - need to traverse them to get the qty record */
  DECLARE cPriceList CURSOR FOR SELECT PriceList FROM #PriceLists (NOLOCK)
  DECLARE cPriceList2 CURSOR FOR SELECT PriceList FROM #PriceLists (NOLOCK)
  OPEN cPriceList
  OPEN cPriceList2
  FETCH NEXT FROM cPriceList INTO @CurrQtyPriceList
  
  WHILE (@@FETCH_STATUS = 0 AND @QtyPriceMatrixID IS NULL) 
  BEGIN  
    IF @Debug = 1 SELECT @CurrQtyPriceList as 'Checking Qty List'
    /* For a given price list - now try to find product-specific record */   
    SELECT @PriceMatrixId = PriceMatrixId
    FROM PriceMatrix (NOLOCK)
    WHERE
      RecordType = 'Price List Product' AND
      CurrencyCode = @CurrencyCode AND
      Warehouse = @Warehouse AND
      UnitOfMeasure = @UnitOfMeasure AND
      CustomerKeyPart = @CurrQtyPriceList AND
      ProductKeyPart =  CAST(@ProductId AS NVARCHAR(50)) AND
      Active <= @PricingDate AND
      (Deactivate IS NULL OR Deactivate > @PricingDate)
      
    IF @Debug = 1 AND @PriceMatrixID IS NOT NULL SELECT @PriceMatrixId as 'Price List Product MtxID'
    
    IF @PriceMatrixId IS NOT NULL AND @QtyPriceMatrixID IS NULL SET
      @QtyPriceMatrixID = @PriceMatrixID

    IF @PriceMatrixId is NULL 
    BEGIN
      -- Find product group
      SELECT TOP 1 @PriceMatrixId = PriceMatrixId
      FROM PriceMatrix (NOLOCK)
      WHERE
        RecordType = 'Price List Product Group' AND
        CurrencyCode = @CurrencyCode AND
        Warehouse = @Warehouse AND
        (UnitOfMeasure = @UnitOfMeasure OR
         UnitOfMeasure = '') AND
        CustomerKeyPart = @CurrQtyPriceList AND
        ProductKeyPart =  @ProductCode AND
        Active <= @PricingDate AND
        (Deactivate IS NULL OR Deactivate > @PricingDate)
      IF @Debug = 1 AND @PriceMatrixId IS NOT NULL SELECT @PriceMatrixId as 'Price List Product Group MtxID',@ProductCode as 'Prod Code'
    END
    
    IF @PriceMatrixId IS NOT NULL AND @QtyPriceMatrixID IS NULL SET
      @QtyPriceMatrixID = @PriceMatrixID
    
		IF @Debug = 1 select @PriceMatrixId as 'CurrentMatxId',@BasePrice as 'BasePrice',@QtyPriceMatrixID as 'QtyPriceMatxId'

    /* Got a qty matrix record - start to process it */
    IF @PriceMatrixId IS NOT NULL
    BEGIN
      SELECT
        @BrkQty1 = BreakQty01,
        @BrkQty2 = BreakQty02,
        @BrkQty3 = BreakQty03,
        @BrkQty4 = BreakQty04,
        @BrkQty5 = BreakQty05,
        @BrkQty6 = BreakQty06,
        @BrkQty7= BreakQty07,
        @BrkQty8 = BreakQty08,
        @BrkQty9 = BreakQty09,
        @BrkQty10 = BreakQty10,
        @BrkQty11 = BreakQty11,
        @AdjType1 = AdjustmentType01,
        @AdjType2 = AdjustmentType02,
        @AdjType3 = AdjustmentType03,
        @AdjType4 = AdjustmentType04,
        @AdjType5 = AdjustmentType05,
        @AdjType6 = AdjustmentType06,
        @AdjType7 = AdjustmentType07,
        @AdjType8 = AdjustmentType08,
        @AdjType9 = AdjustmentType09,
        @AdjType10 = AdjustmentType10,
        @AdjType11 = AdjustmentType11,
        @Amount1 = Amount01,
        @Amount2 = Amount02,
        @Amount3 = Amount03,
        @Amount4 = Amount04,
        @Amount5 = Amount05,
        @Amount6 = Amount06,
        @Amount7 = Amount07,
        @Amount8 = Amount08,
        @Amount9 = Amount09,
        @Amount10 = Amount10,
        @Amount11 = Amount11,
        @BasePrice = ISNULL(AltAmount01,0)
      FROM PriceMatrix (NOLOCK) 
      WHERE PriceMatrixId = @PriceMatrixId
      
      -- Save Discount % in case - this is for price - the discount is being saved in @PriceBreaks
      -- but we are assuming that if the first entry is % off then all are (Epicor is this way)
      
      	IF @AdjType1 = 'P' AND @BasePrice = 0 SET @SaveDiscount = @Amount1
      	IF @AdjType1 = 'P' AND @BasePrice = 0 SET @SaveDiscount = @Amount1
      	IF @AdjType1 = 'P' AND @BasePrice = 0 SET @SaveDiscount = @Amount1
      	IF @AdjType1 = 'P' AND @BasePrice = 0 SET @SaveDiscount = @Amount1
      	IF @AdjType1 = 'P' AND @BasePrice = 0 SET @SaveDiscount = @Amount1
      	IF @AdjType1 = 'P' AND @BasePrice = 0 SET @SaveDiscount = @Amount1
      	IF @AdjType1 = 'P' AND @BasePrice = 0 SET @SaveDiscount = @Amount1
      	IF @AdjType1 = 'P' AND @BasePrice = 0 SET @SaveDiscount = @Amount1
      	IF @AdjType1 = 'P' AND @BasePrice = 0 SET @SaveDiscount = @Amount1
      	IF @AdjType1 = 'P' AND @BasePrice = 0 SET @SaveDiscount = @Amount1
      	IF @AdjType1 = 'P' AND @BasePrice = 0 SET @SaveDiscount = @Amount1

      
  																								
		-- Capture Price Breaks
		DELETE FROM @PriceBreaks
		INSERT INTO @PriceBreaks SELECT 1, @BasePrice
		IF @BrkQty1 > 0 AND @Amount1 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty1, @Amount1
		IF @BrkQty2 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty2, @Amount2
		IF @BrkQty3 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty3, @Amount3
		IF @BrkQty4 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty4, @Amount4
		IF @BrkQty5 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty5, @Amount5
		IF @BrkQty6 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty6, @Amount6
		IF @BrkQty7 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty7, @Amount7
		IF @BrkQty8 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty8, @Amount8
		IF @BrkQty9 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty9, @Amount9
		IF @BrkQty10 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty10, @Amount10
		IF @BrkQty11 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty11, @Amount11
		
			IF @QtyOrdered >= @BrkQty1 AND @BrkQty1 > 0
			SELECT
				@CurAmount = @Amount1,
				@CurBrkQty = @BrkQty1,    
				@CurAdjType = @AdjType1			

			IF @QtyOrdered >= @BrkQty2 AND @BrkQty2 > 0
			SELECT
				@CurAmount = @Amount2,
				@CurBrkQty = @BrkQty2,
				@CurAdjType = @AdjType2

			IF @QtyOrdered >= @BrkQty3 AND @BrkQty3 > 0
			SELECT
				@CurAmount = @Amount3,
				@CurBrkQty = @BrkQty3,
				@CurAdjType = @AdjType3

			IF @QtyOrdered >= @BrkQty4 AND @BrkQty4 > 0
			SELECT
				@CurAmount = @Amount4,
				@CurBrkQty = @BrkQty4,
				@CurAdjType = @AdjType4

			IF @QtyOrdered >= @BrkQty5 AND @BrkQty5 > 0
			SELECT
				@CurAmount = @Amount5,
				@CurBrkQty = @BrkQty5,
				@CurAdjType = @AdjType5

			IF @QtyOrdered >= @BrkQty6 AND @BrkQty6 > 0
			SELECT
				@CurAmount = @Amount6,
				@CurBrkQty = @BrkQty6,        
				@CurAdjType = @AdjType6

			IF @QtyOrdered >= @BrkQty7 AND @BrkQty7 > 0
			SELECT
				@CurAmount = @Amount7,
				@CurBrkQty = @BrkQty7,        
				@CurAdjType = @AdjType7

			IF @QtyOrdered >= @BrkQty8 AND @BrkQty8 > 0
			SELECT
				@CurAmount = @Amount8,
				@CurBrkQty = @BrkQty8,      
				@CurAdjType = @AdjType8

			IF @QtyOrdered >= @BrkQty9 AND @BrkQty9 > 0
			SELECT
				@CurAmount = @Amount9,
				@CurBrkQty = @BrkQty9,        
				@CurAdjType = @AdjType9

			IF @QtyOrdered >= @BrkQty10 AND @BrkQty10 > 0
			SELECT
				@CurAmount = @Amount10,
				@CurBrkQty = @BrkQty10,        
				@CurAdjType = @AdjType10

			IF @QtyOrdered >= @BrkQty11 AND @BrkQty11 > 0
			SELECT
				@CurAmount = @Amount11,
				@CurBrkQty = @BrkQty11,        
				@CurAdjType = @AdjType11
				
		    IF @CurAdjType = 'P' AND @BasePrice = 0 SET @SaveDiscount = @CurAmount
			
			IF @Debug = 1 SELECT @PriceMatrixId as 'Selected MtxID',@CurAmount as 'CurrAmt',@CurBrkQty as 'CurBrkQty',
				@CurAdjType as 'AdjType',@BasePrice as 'BasePrice'
			
				-- Next we have to get base price - secondary traversal
			IF @BasePrice = 0
			BEGIN			  
				FETCH NEXT FROM cPriceList2 INTO @CurrBasePriceList
				
			
				WHILE (@@FETCH_STATUS = 0 AND @BasePrice = 0)
				BEGIN
				  IF @Debug = 1 SELECT @CurrBasePriceList as 'Base price list'
					SELECT @BasePrice = ISNULL(AltAmount01,0)
					FROM PriceMatrix (NOLOCK)
					WHERE
	  				RecordType = 'Price List Product' AND
						CurrencyCode = @CurrencyCode AND
						Warehouse = @Warehouse AND
						UnitOfMeasure = @UnitOfMeasure AND
						CustomerKeyPart = @CurrBasePriceList AND
						ProductKeyPart =  CAST(@ProductId AS NVARCHAR(50)) AND
						Active <= @PricingDate AND
						(Deactivate IS NULL OR Deactivate > @PricingDate)						
					
			
					IF @BasePrice = 0 
					BEGIN
						SELECT @BasePrice = ISNULL(AltAmount01,0)
	 					FROM PriceMatrix (NOLOCK)
						WHERE
  						RecordType = 'Price List Product Group' AND
							CurrencyCode = @CurrencyCode AND
							Warehouse = @Warehouse AND
							 (UnitOfMeasure = @UnitOfMeasure OR
								UnitOfMeasure = '') AND
							CustomerKeyPart = @CurrBasePriceList AND
							ProductKeyPart =  @ProductCode AND
							Active <= @PricingDate AND
							(Deactivate IS NULL OR Deactivate > @PricingDate)
					END		 
					
					FETCH NEXT FROM cPriceList2 INTO @CurrBasePriceList		
				END  -- current base price list
											
				
			END -- capture of base price/cPriceList2						
		END  -- if price matrixid is not null
		FETCH NEXT FROM cPriceList INTO @CurrQtyPriceList
	END  -- capture of qty matrix/cPriceList

	if @DEbug = 1 select @CurAmount as 'curamount',@SaveDiscount as 'SavedDisct%',
		@BasePrice as 'Base Price',@CurBrkQty as 'cur brk qty', @CurAdjType as 'CurAdjType',
		@CustomerDiscount as 'Customer Disct %',@ListPrice as 'List Price'

	/* Do the actual math next */
	IF ISNULL(@BasePrice,0) > 0
		SET @Price = @BasePrice -- initial

    BEGIN    
		IF @CurAdjType IN ('A', 'P')  
			SET @Price = @CurAmount
	END
	
	-- Final check - discount basis but no base price - have to use ListPrice
	IF ISNULL(@BasePrice,0) = 0 AND ISNULL(@ListPrice,0) > 0
	BEGIN
	  IF @Debug = 1 SELECT 'BasePrice from Product - save disct = ',@SaveDiscount
	  IF @SaveDiscount > 0
	  BEGIN
		SET @Price = @ListPrice * (1 - (@SaveDiscount / 100))
		UPDATE @PriceBreaks SET Price = @ListPrice * (1 - Price / 100)
		  WHERE Price > 0
	  END
	  ELSE
		SET @Price = @ListPrice
	END
 
	-- Close up
  CLOSE cPriceList
  CLOSE cPriceList2
  DEALLOCATE cPriceList
  DEALLOCATE cPriceList2
  DROP TABLE #PriceLists
  
  -- Final check - discount but no base price (get from List Price)
  IF ISNULL(@BasePrice,0) = 0 AND ISNULL(@ListPrice,0) > 0
  BEGIN
    IF @Debug = 1 SELECT 'part master base - save disct = ',@SaveDiscount
    IF @SaveDiscount > 0 
       SET @Price = @ListPrice * (1 - (@SaveDiscount / 100))
    ELSE
        SET @Price = @ListPrice        
  END

  IF @Price is null AND @UsingBaseUOM = 1
    SET @Price = @ListPrice
    
  IF @Price is null AND @UsingBaseUOM = 0
	SET @Price = 0
    
  -- Apply customer discount next
  SET @Price = @Price * (1 - @CustomerDiscount / 100)
  
  IF @SalePrice > 0 AND @SalePrice < @Price AND
    @SaleStartDate <= @PricingDate AND (@SaleEndDate IS NULL OR @SaleEndDate >= @PricingDate)
    BEGIN
      SELECT
        @Price = @SalePrice, -- ifit's actually less, set it
        @IsSalePrice = 1
    END
    
    IF @Debug = 1 select @Price as 'Returned price',@IsSalePrice as 'IsSalePrice'

	-- this output format is required to work with the ISC 3.4 PricingService_Default
	
	SELECT * FROM @PriceBreaks  -- empty for now
	SELECT @Price AS Price, @IsSalePrice AS IsSalePrice

END -- End of procedure

GO
/****** Object:  StoredProcedure [dbo].[PriceCalculator_Generic]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Tom Frishberg
-- Create date:	8/3/2011
--
--	Date		Who		What
--	08/04/20??			Default price to ListPrice if nothing calculated and default to BasicListPrice if that doesn't have anything
--	12/10/2012			Fixed up a little for Jessica specifically
--	01/24/2014	Adam	UOM pricing: if a matrix record is used for a uom, do not multiply the uom.quantity by the price
-- =============================================
CREATE PROCEDURE [dbo].[PriceCalculator_Generic]
  @CustomerId        uniqueidentifier = null,
  @ProductId         uniqueidentifier = null,
  @QtyOrdered        decimal(18,5) = 0,
  @CurrencyCode      nvarchar(50) = '',
  @Warehouse         nvarchar(50) = '',
  @UnitOfMeasure     nvarchar(50) = '',
  @PricingDate       datetime = null,
  @RegularPrice      tinyint = 0,  -- if 1 return price without sale or customer pricing  
  @Price             decimal(18,5) OUTPUT,
  @IsSalePrice       tinyint OUTPUT,  -- only valid if ReturnListPrice = 0
  @Debug		     tinyint = 0
AS
BEGIN 

  DECLARE
    @PriceMatrixId      uniqueidentifier,
    @SalePrice          decimal(18,5),
    @SaleStartDate      datetime,
    @SaleEndDate        datetime,
    @BasicListPrice     decimal(18,5),
    @BasicSalePrice     decimal(18,5),
    @BasicSaleStartDate datetime,
    @BasicSaleEndDate   datetime,
    @ListPrice          decimal(18,5),
    @UnitCost           decimal(18,5),
    @ProductPriceCode   nvarchar(50),
    @ProductUM          nvarchar(50),
    @ProductVendorId    uniqueidentifier,
    @CustomerPriceCode  nvarchar(50),
    @ParentCustomerId   uniqueidentifier,
    @RecordType         nvarchar(50),
    @CustomerKeyPart    nvarchar(50),
    @ProductKeyPart     nvarchar(50),
    @CalcFlags          nvarchar(50),
    @BrkQty1            decimal(18,5),
    @BrkQty2            decimal(18,5),
    @BrkQty3            decimal(18,5),
    @BrkQty4            decimal(18,5),
    @BrkQty5            decimal(18,5),
    @BrkQty6            decimal(18,5),
    @BrkQty7            decimal(18,5),
    @BrkQty8            decimal(18,5),
    @BrkQty9            decimal(18,5),
    @BrkQty10           decimal(18,5),
    @BrkQty11           decimal(18,5),
    @PriceBasis1        nvarchar(50),
    @PriceBasis2        nvarchar(50),
    @PriceBasis3        nvarchar(50),
    @PriceBasis4        nvarchar(50),
    @PriceBasis5        nvarchar(50),
    @PriceBasis6        nvarchar(50),
    @PriceBasis7        nvarchar(50),
    @PriceBasis8        nvarchar(50),
    @PriceBasis9        nvarchar(50),
    @PriceBasis10       nvarchar(50),
    @PriceBasis11       nvarchar(50),
    @AdjType1           nvarchar(50),
    @AdjType2           nvarchar(50),
    @AdjType3           nvarchar(50),
    @AdjType4           nvarchar(50),
    @AdjType5           nvarchar(50),
    @AdjType6           nvarchar(50),
    @AdjType7           nvarchar(50),
    @AdjType8           nvarchar(50),
    @AdjType9           nvarchar(50),
    @AdjType10          nvarchar(50),
    @AdjType11          nvarchar(50),
    @Amount1            decimal(18,5),
    @Amount2            decimal(18,5),
    @Amount3            decimal(18,5),
    @Amount4            decimal(18,5),
    @Amount5            decimal(18,5),
    @Amount6            decimal(18,5),
    @Amount7            decimal(18,5),
    @Amount8            decimal(18,5),
    @Amount9            decimal(18,5),
    @Amount10           decimal(18,5),
    @Amount11           decimal(18,5),
    @AltAmount1         decimal(18,5),    
    @AltAmount2         decimal(18,5),    
    @AltAmount3         decimal(18,5),    
    @AltAmount4         decimal(18,5),    
    @AltAmount5         decimal(18,5),    
    @AltAmount6         decimal(18,5),    
    @AltAmount7         decimal(18,5),    
    @AltAmount8         decimal(18,5),    
    @AltAmount9         decimal(18,5),    
    @AltAmount10        decimal(18,5),    
    @AltAmount11        decimal(18,5),
    @Loop               int,
    @CurAmount          decimal(18,5),
    @CurAltAmount       decimal(18,5),
    @CurBrkQty          decimal(18,5),
    @CurPriceBasis      nvarchar(50),
    @CurAdjType         nvarchar(50),
    @tmpBasisValue      decimal(18,5),
    @tmpPriceBasis      nvarchar(50),
    @UsingBaseUOM		bit,
	@PriceIsOverride	bit = 0

  /* SyteLine-specific variables */
  DECLARE
    @PriceLevel1        decimal(18,5),
    @PriceLevel2        decimal(18,5),
    @PriceLevel3        decimal(18,5),
    @PriceLevel4        decimal(18,5),
    @PriceLevel5        decimal(18,5),
    @PriceLevel6        decimal(18,5)
    
  DECLARE @PriceBreaks TABLE (BreakQty DECIMAL(18,5), Price DECIMAL(18,5))
	

  IF @PricingDate IS NULL
    SET @PricingDate = dateadd(dd,0,datediff(dd,0,getdate()))
  SET @IsSalePrice = 0

  /* If they want list price, whack the customer reference */
  IF @RegularPrice <> 0 
    SET @CustomerId = null
    
  /* First get the product information */
  IF @ProductID IS null
  BEGIN
    print 'Error - no product selected'
    RETURN 99
  END  
 
  SELECT 
    @ProductPriceCode = PriceCode, 
    @ProductUM = UnitOfMeasure,
    @UnitCost = Cost,
    @ProductVendorId = VendorId,
    @BasicListPrice = BasicListPrice,
    @BasicSalePrice = BasicSalePrice,
    @BasicSaleStartDate = BasicSaleStart,
    @BasicSaleEndDate = BasicSaleEnd
  FROM Product (NOLOCK)
  WHERE ProductId = @ProductId


  IF IsNull(@UnitOfMeasure,'') = ''
    SET @UnitOfMeasure = @ProductUM
    
  SET @UsingBaseUOM = 1
  IF @UnitOfMeasure <> @ProductUM
	SET @UsingBaseUOM = 0
	
 IF @Debug = 1
    select @ProductId as 'ProductID',@UnitCost as 'Unit Cost', @CurrencyCode as 'Curr',
    @ProductUM as 'UM',@CustomerId as 'CustId',@PricingDate as 'PricingDate'
	

  /* Get List Price for basis calculations */
  SELECT 
    @ListPrice = Amount01,
    @PriceLevel1 = AltAmount01,
    @PriceLevel2 = AltAmount02,
    @PriceLevel3 = AltAmount03,
    @PriceLevel4 = AltAmount04,
    @PriceLevel5 = AltAmount05,
    @PriceLevel6 = AltAmount06,
    
    -- To Capture Price Breaks
	@BrkQty1 = BreakQty01,
	@BrkQty2 = BreakQty02,
	@BrkQty3 = BreakQty03,
	@BrkQty4 = BreakQty04,
	@BrkQty5 = BreakQty05,
	@BrkQty6 = BreakQty06,
	@BrkQty7 = BreakQty07,
	@BrkQty8 = BreakQty08,
	@BrkQty9 = BreakQty09,
	@BrkQty10 = BreakQty10,
	@BrkQty11 = BreakQty11,
	@Amount1 = Amount01,
	@Amount2 = Amount02,
	@Amount3 = Amount03,
	@Amount4 = Amount04,
	@Amount5 = Amount05,
	@Amount6 = Amount06,
	@Amount7 = Amount07,
	@Amount8 = Amount08,
	@Amount9 = Amount09,
	@Amount10 = Amount10,
	@Amount11 = Amount11

  FROM PriceMatrix (NOLOCK)
  WHERE
    RecordType = 'Product' AND
    CurrencyCode = @CurrencyCode AND
    Warehouse = @Warehouse AND
    UnitOfMeasure = @UnitOfMeasure AND
    CustomerKeyPart = '' AND
    ProductKeyPart = @ProductId AND
    Active <= @PricingDate AND
    (Deactivate IS NULL OR Deactivate > @PricingDate)

  -- Capture Price Breaks
  INSERT INTO @PriceBreaks SELECT @BrkQty1, @Amount1
  IF @BrkQty2 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty2, @Amount2
  IF @BrkQty3 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty3, @Amount3
  IF @BrkQty4 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty4, @Amount4
  IF @BrkQty5 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty5, @Amount5
  IF @BrkQty6 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty6, @Amount6
  IF @BrkQty7 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty7, @Amount7
  IF @BrkQty8 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty8, @Amount8
  IF @BrkQty9 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty9, @Amount9
  IF @BrkQty10 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty10, @Amount10
  IF @BrkQty11 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty11, @Amount11
      
  /* Next get the customer information, if any */
  IF @CustomerId is not null
  BEGIN
    SELECT
      @CustomerPriceCode = PriceCode,
      @ParentCustomerId = ParentId
    FROM Customer (NOLOCK)
    WHERE CustomerId = @CustomerId
  END


  /* Now try and find which record will hold the key */
  SET @PriceMatrixId = NULL
  
  /* Customer/Product */
  IF @PriceMatrixId IS NULL AND @CustomerId is not null
  BEGIN
    SELECT @PriceMatrixID = PriceMatrixID
    FROM PriceMatrix (NOLOCK) 
    WHERE
      RecordType = 'Customer/Product' AND
      CurrencyCode = @CurrencyCode AND
      Warehouse = @Warehouse AND
      UnitOfMeasure = @UnitOfMeasure AND
      CustomerKeyPart = @CustomerId AND
      ProductKeyPart = @ProductId AND
      Active <= @PricingDate AND
      (Deactivate IS NULL OR Deactivate > @PricingDate)
  END

  /* Customer/Product Price Code */
  IF @PriceMatrixId IS NULL AND @CustomerId  is not null
  BEGIN
    SELECT @PriceMatrixID = PriceMatrixID
    FROM PriceMatrix (NOLOCK) 
    WHERE
      RecordType = 'Customer/Product Price Code' AND
      CurrencyCode = @CurrencyCode AND
      Warehouse = @Warehouse AND
      --UnitOfMeasure = @UnitOfMeasure AND  -- can't use UM without specific product
      CustomerKeyPart = @CustomerId AND
      ProductKeyPart =  @ProductPriceCode AND
      Active <= @PricingDate AND
      (Deactivate IS NULL OR Deactivate > @PricingDate)
  END

  /* Parent Customer/Product */
  IF @PriceMatrixId IS NULL AND @ParentCustomerId  is not null
  BEGIN
    SELECT @PriceMatrixID = PriceMatrixID
    FROM PriceMatrix (NOLOCK) 
    WHERE
      RecordType = 'Customer/Product' AND
      CurrencyCode = @CurrencyCode AND
      Warehouse = @Warehouse AND
      UnitOfMeasure = @UnitOfMeasure AND
      CustomerKeyPart = @ParentCustomerId AND
      ProductKeyPart = @ProductId AND
      Active <= @PricingDate AND
      (Deactivate IS NULL OR Deactivate > @PricingDate)
  END

  /* Parent Customer/Product Price Code */
  IF @PriceMatrixId IS NULL AND @ParentCustomerId is not null
  BEGIN
    SELECT @PriceMatrixID = PriceMatrixID
    FROM PriceMatrix (NOLOCK) 
    WHERE
      RecordType = 'Customer/Product Price Code' AND
      CurrencyCode = @CurrencyCode AND
      Warehouse = @Warehouse AND
      --UnitOfMeasure = @UnitOfMeasure AND  -- no UM withouth specific product
      CustomerKeyPart = @ParentCustomerId AND
      ProductKeyPart =  @ProductPriceCode AND
      Active <= @PricingDate AND
      (Deactivate IS NULL OR Deactivate > @PricingDate)
  END

  /* Customer Price Code/Product - don't see this type in SL but no harm in looking for it */
  IF @PriceMatrixId IS NULL AND @CustomerId  is not null 
     AND @CustomerPriceCode <> ''
  BEGIN
    SELECT @PriceMatrixID = PriceMatrixID
    FROM PriceMatrix (NOLOCK) 
    WHERE
      RecordType = 'Customer Price Code/Product' AND
      CurrencyCode = @CurrencyCode AND
      Warehouse = @Warehouse AND
      UnitOfMeasure = @UnitOfMeasure AND
      CustomerKeyPart = @CustomerPriceCode AND
      ProductKeyPart = @ProductId AND
      Active <= @PricingDate AND
      (Deactivate IS NULL OR Deactivate > @PricingDate)
  END        

  /* Customer Price Code/Product Price Code */
  IF @PriceMatrixId IS NULL AND @CustomerId  is not null 
     AND @CustomerPriceCode <> ''
     AND @ProductPriceCode <> ''
  BEGIN
    SELECT @PriceMatrixID = PriceMatrixID
    FROM PriceMatrix (NOLOCK) 
    WHERE
      RecordType = 'Customer Price Code/Product Price Code' AND
      CurrencyCode = @CurrencyCode AND
      Warehouse = @Warehouse AND
   --   UnitOfMeasure = @UnitOfMeasure AND  -- no UM without specific product
      CustomerKeyPart = @CustomerPriceCode AND
      ProductKeyPart = @ProductPriceCode AND
      Active <= @PricingDate AND
      (Deactivate IS NULL OR Deactivate > @PricingDate)
  END       

  /* Customer */
  IF @PriceMatrixId IS NULL AND @CustomerId  is not null 
  BEGIN
    SELECT @PriceMatrixID = PriceMatrixID
    FROM PriceMatrix (NOLOCK) 
    WHERE
      RecordType = 'Customer' AND
      CurrencyCode = @CurrencyCode AND
   --   Warehouse = @Warehouse AND
   --   UnitOfMeasure = @UnitOfMeasure AND  -- no UM without specific product
      CustomerKeyPart = @CustomerId AND
      Active <= @PricingDate AND
      (Deactivate IS NULL OR Deactivate > @PricingDate)
  END       

  /* Customer Price Code */
  IF @PriceMatrixId IS NULL AND @CustomerId  is not null 
     AND @CustomerPriceCode <> ''
  BEGIN
    SELECT @PriceMatrixID = PriceMatrixID
    FROM PriceMatrix (NOLOCK) 
    WHERE
      RecordType = 'Customer Price Code' AND
      CurrencyCode = @CurrencyCode AND
      Warehouse = @Warehouse AND
   --   UnitOfMeasure = @UnitOfMeasure AND  -- no UM without specific product
      CustomerKeyPart = @CustomerPriceCode AND
      Active <= @PricingDate AND
      (Deactivate IS NULL OR Deactivate > @PricingDate)
  END       

  /* Product Price Code */
  IF @PriceMatrixId IS NULL AND @ProductPriceCode <> ''
  BEGIN
    SELECT @PriceMatrixID = PriceMatrixID
    FROM PriceMatrix (NOLOCK) 
    WHERE
      RecordType = 'Product Price Code' AND
      CurrencyCode = @CurrencyCode AND
      Warehouse = @Warehouse AND
      UnitOfMeasure = @UnitOfMeasure AND
      ProductKeyPart = @ProductPriceCode AND
      Active <= @PricingDate AND
      (Deactivate IS NULL OR Deactivate > @PricingDate)
  END       

  /* Product Base Record - grabbing this record if nothing else grabbed */
  IF @PriceMatrixId IS NULL
  BEGIN
    SELECT @PriceMatrixID = PriceMatrixID
    FROM PriceMatrix (NOLOCK) 
    WHERE
      RecordType = 'Product' AND
      CurrencyCode = @CurrencyCode AND
      Warehouse = @Warehouse AND
      UnitOfMeasure = @UnitOfMeasure AND
      CustomerKeyPart = '' AND
      ProductKeyPart = @ProductId AND
      Active <= @PricingDate AND
      (Deactivate IS NULL OR Deactivate > @PricingDate)
  END    
  
  IF @Debug = 1 SELECT @PriceMatrixId as 'Selected Matrix ID'

  /* Check to see if we have a valid record and read it in */
  IF @PriceMatrixId IS NULL
  BEGIN
    SET @Price = @ListPrice
  END

  ELSE BEGIN
    SELECT 
      @RecordType = RecordType,
      @BrkQty1 = BreakQty01,
      @BrkQty2 = BreakQty02,
      @BrkQty3 = BreakQty03,
      @BrkQty4 = BreakQty04,
      @BrkQty5 = BreakQty05,
      @BrkQty6 = BreakQty06,
      @BrkQty7 = BreakQty07,
      @BrkQty8 = BreakQty08,
      @BrkQty9 = BreakQty09,
      @BrkQty10 = BreakQty10,
      @BrkQty11 = BreakQty11,
      @PriceBasis1 = PriceBasis01,
      @PriceBasis2 = PriceBasis02,
      @PriceBasis3 = PriceBasis03,
      @PriceBasis4 = PriceBasis04,
      @PriceBasis5 = PriceBasis05,
      @PriceBasis6 = PriceBasis06,
      @PriceBasis7 = PriceBasis07,
      @PriceBasis8 = PriceBasis08,
      @PriceBasis9 = PriceBasis09,
      @PriceBasis10 = PriceBasis10,
      @PriceBasis11 = PriceBasis11,
      @AdjType1 = AdjustmentType01,
      @AdjType2 = AdjustmentType02,
      @AdjType3 = AdjustmentType03,
      @AdjType4 = AdjustmentType04,
      @AdjType5 = AdjustmentType05,
      @AdjType6 = AdjustmentType06,
      @AdjType7 = AdjustmentType07,
      @AdjType8 = AdjustmentType08,
      @AdjType9 = AdjustmentType09,
      @AdjType10 = AdjustmentType10,
      @AdjType11 = AdjustmentType11,
      @Amount1 = Amount01,
      @Amount2 = Amount02,
      @Amount3 = Amount03,
      @Amount4 = Amount04,
      @Amount5 = Amount05,
      @Amount6 = Amount06,
      @Amount7 = Amount07,
      @Amount8 = Amount08,
      @Amount9 = Amount09,
      @Amount10 = Amount10,
      @Amount11 = Amount11,
      @AltAmount1 = AltAmount01,
      @AltAmount2 = AltAmount02,
      @AltAmount3 = AltAmount03,
      @AltAmount4 = AltAmount04,
      @AltAmount5 = AltAmount05,
      @AltAmount6 = AltAmount06,
      @AltAmount7 = AltAmount07,
      @AltAmount8 = AltAmount08,
      @AltAmount9 = AltAmount09,
      @AltAmount10 = AltAmount10,
      @AltAmount11 = AltAmount11 
    FROM PriceMatrix (NOLOCK)
    WHERE PriceMatrixId = @PriceMatrixId


    /* And now the ugly stuff - traversing through the given record and figuring out price */
    SELECT
      @CurAmount = @Amount1,
      @CurBrkQty = @BrkQty1,
      @CurPriceBasis = @PriceBasis1,
      @CurAdjType = @AdjType1

    IF @QtyOrdered >= @BrkQty2 AND @BrkQty2 > 0
      SELECT
        @CurAmount = @Amount2,
        @CurBrkQty = @BrkQty2,
        @CurPriceBasis = @PriceBasis2,
        @CurAdjType = @AdjType2

    IF @QtyOrdered >= @BrkQty3 AND @BrkQty3 > 0
      SELECT
        @CurAmount = @Amount3,
        @CurBrkQty = @BrkQty3,
        @CurPriceBasis = @PriceBasis3,
        @CurAdjType = @AdjType3

    IF @QtyOrdered >= @BrkQty4 AND @BrkQty4 > 0
      SELECT
        @CurAmount = @Amount4,
        @CurBrkQty = @BrkQty4,
        @CurPriceBasis = @PriceBasis4,
        @CurAdjType = @AdjType4

    IF @QtyOrdered >= @BrkQty5 AND @BrkQty5 > 0
      SELECT
        @CurAmount = @Amount5,
        @CurBrkQty = @BrkQty5,
        @CurPriceBasis = @PriceBasis5,
        @CurAdjType = @AdjType5

    IF @QtyOrdered >= @BrkQty6 AND @BrkQty6 > 0
      SELECT
        @CurAmount = @Amount6,
        @CurBrkQty = @BrkQty6,
        @CurPriceBasis = @PriceBasis6,
        @CurAdjType = @AdjType6

    IF @QtyOrdered >= @BrkQty7 AND @BrkQty7 > 0
      SELECT
        @CurAmount = @Amount7,
        @CurBrkQty = @BrkQty7,
        @CurPriceBasis = @PriceBasis7,
        @CurAdjType = @AdjType7

    IF @QtyOrdered >= @BrkQty8 AND @BrkQty8 > 0
      SELECT
        @CurAmount = @Amount8,
        @CurBrkQty = @BrkQty8,
        @CurPriceBasis = @PriceBasis8,
        @CurAdjType = @AdjType8

    IF @QtyOrdered >= @BrkQty9 AND @BrkQty9 > 0
      SELECT
        @CurAmount = @Amount9,
        @CurBrkQty = @BrkQty9,
        @CurPriceBasis = @PriceBasis9,
        @CurAdjType = @AdjType9

    IF @QtyOrdered >= @BrkQty10 AND @BrkQty10 > 0
      SELECT
        @CurAmount = @Amount10,
        @CurBrkQty = @BrkQty10,
        @CurPriceBasis = @PriceBasis10,
        @CurAdjType = @AdjType10

    IF @QtyOrdered >= @BrkQty11 AND @BrkQty11 > 0
      SELECT
        @CurAmount = @Amount11,
        @CurBrkQty = @BrkQty11,
        @CurPriceBasis = @PriceBasis11,
        @CurAdjType = @AdjType11


    /* Set price basis level */
    SET @tmpBasisValue = 0
    IF @CurPriceBasis = 'C' SET @tmpBasisValue = @UnitCost
    IF @CurPriceBasis = 'M' SET @tmpBasisValue = @UnitCost -- margin
    IF @CurPriceBasis = 'MU' SET @tmpBasisValue = @UnitCost -- markup (mu/vmu)
    IF @CurPriceBasis = 'L' SET @tmpBasisValue = @ListPrice
    IF @CurPriceBasis = 'P1' SET @tmpBasisValue = @PriceLevel1
    IF @CurPriceBasis = 'P2' SET @tmpBasisValue = @PriceLevel2
    IF @CurPriceBasis = 'P3' SET @tmpBasisValue = @PriceLevel3
    IF @CurPriceBasis = 'P4' SET @tmpBasisValue = @PriceLevel4
    IF @CurPriceBasis = 'P5' SET @tmpBasisValue = @PriceLevel5
    IF @CurPriceBasis = 'P6' SET @tmpBasisValue = @PriceLevel6

	IF @Debug = 1
	SELECT 
		@RecordType 'RecordType', 
		@tmpBasisValue 'TmpBasisValue',
		@ListPrice 'ListPrice',
		@CurAdjType 'CurAdjType', 
		@CurPriceBasis 'PriceBasis', 
		@UnitCost 'Cost', 
		@CurAmount 'CurAmount',
		@Price 'Price'

    /* Calculate actual price based on current break */
    
    /* Override Price */
    IF @CurPriceBasis = 'O' AND @CurAdjType = 'A'
    BEGIN
      SET @Price = @CurAmount
	  SET @PriceIsOverride = 1
      
      -- Capture Price Breaks
      DELETE FROM @PriceBreaks
      INSERT INTO @PriceBreaks SELECT @BrkQty1, @Amount1
      IF @BrkQty2 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty2, @Amount2
      IF @BrkQty3 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty3, @Amount3
      IF @BrkQty4 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty4, @Amount4
      IF @BrkQty5 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty5, @Amount5
      IF @BrkQty6 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty6, @Amount6
      IF @BrkQty7 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty7, @Amount7
      IF @BrkQty8 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty8, @Amount8
      IF @BrkQty9 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty9, @Amount9
      IF @BrkQty10 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty10, @Amount10
      IF @BrkQty11 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty11, @Amount11

	END
    /* Non-derived-Based types - always adds */
    IF @CurPriceBasis IN ('C','MU','L','P1','P2','P3','P4','P5','P6')
    BEGIN
      IF @CurAdjType = 'A'
        SET @Price = @tmpBasisValue + @CurAmount
      IF @CurAdjType = 'P'
        SET @Price = @tmpBasisValue * (1 + @CurAmount / 100)
        
      -- Capture Price Breaks
      DELETE FROM @PriceBreaks
      INSERT INTO @PriceBreaks SELECT @BrkQty1, CASE WHEN @CurAdjType = 'A' THEN @tmpBasisValue + @Amount1 ELSE @tmpBasisValue * (1 + @Amount1 / 100) END
      IF @BrkQty2 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty2, CASE WHEN @CurAdjType = 'A' THEN @tmpBasisValue + @Amount2 ELSE @tmpBasisValue * (1 + @Amount2 / 100) END
      IF @BrkQty3 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty3, CASE WHEN @CurAdjType = 'A' THEN @tmpBasisValue + @Amount3 ELSE @tmpBasisValue * (1 + @Amount3 / 100) END
      IF @BrkQty4 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty4, CASE WHEN @CurAdjType = 'A' THEN @tmpBasisValue + @Amount4 ELSE @tmpBasisValue * (1 + @Amount4 / 100) END
      IF @BrkQty5 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty5, CASE WHEN @CurAdjType = 'A' THEN @tmpBasisValue + @Amount5 ELSE @tmpBasisValue * (1 + @Amount5 / 100) END
      IF @BrkQty6 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty6, CASE WHEN @CurAdjType = 'A' THEN @tmpBasisValue + @Amount6 ELSE @tmpBasisValue * (1 + @Amount6 / 100) END
      IF @BrkQty7 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty7, CASE WHEN @CurAdjType = 'A' THEN @tmpBasisValue + @Amount7 ELSE @tmpBasisValue * (1 + @Amount7 / 100) END
      IF @BrkQty8 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty8, CASE WHEN @CurAdjType = 'A' THEN @tmpBasisValue + @Amount8 ELSE @tmpBasisValue * (1 + @Amount8 / 100) END
      IF @BrkQty9 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty9, CASE WHEN @CurAdjType = 'A' THEN @tmpBasisValue + @Amount9 ELSE @tmpBasisValue * (1 + @Amount9 / 100) END
      IF @BrkQty10 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty10, CASE WHEN @CurAdjType = 'A' THEN @tmpBasisValue + @Amount10 ELSE @tmpBasisValue * (1 + @Amount10 / 100) END
      IF @BrkQty11 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty11, CASE WHEN @CurAdjType = 'A' THEN @tmpBasisValue + @Amount11 ELSE @tmpBasisValue * (1 + @Amount11 / 100) END

    END -- non-derived

    /* Margin */
    IF @CurPriceBasis = 'M'
    BEGIN
      IF @CurAdjType = 'A'
        SET @Price = @CurAmount + @tmpBasisValue
      IF @CurAdjType = 'P'
        SET @Price = @tmpBasisValue / (1 - @CurAmount / 100) 

      -- Capture Price Breaks
      DELETE FROM @PriceBreaks
      INSERT INTO @PriceBreaks SELECT @BrkQty1, CASE WHEN @CurAdjType = 'A' THEN @tmpBasisValue + @Amount1 ELSE @tmpBasisValue / (1 - @Amount1 / 100) END
      IF @BrkQty2 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty2, CASE WHEN @CurAdjType = 'A' THEN @tmpBasisValue + @Amount2 ELSE @tmpBasisValue / (1 - @Amount2 / 100) END
      IF @BrkQty3 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty3, CASE WHEN @CurAdjType = 'A' THEN @tmpBasisValue + @Amount3 ELSE @tmpBasisValue / (1 - @Amount3 / 100) END
      IF @BrkQty4 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty4, CASE WHEN @CurAdjType = 'A' THEN @tmpBasisValue + @Amount4 ELSE @tmpBasisValue / (1 - @Amount4 / 100) END
      IF @BrkQty5 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty5, CASE WHEN @CurAdjType = 'A' THEN @tmpBasisValue + @Amount5 ELSE @tmpBasisValue / (1 - @Amount5 / 100) END
      IF @BrkQty6 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty6, CASE WHEN @CurAdjType = 'A' THEN @tmpBasisValue + @Amount6 ELSE @tmpBasisValue / (1 - @Amount6 / 100) END
      IF @BrkQty7 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty7, CASE WHEN @CurAdjType = 'A' THEN @tmpBasisValue + @Amount7 ELSE @tmpBasisValue / (1 - @Amount7 / 100) END
      IF @BrkQty8 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty8, CASE WHEN @CurAdjType = 'A' THEN @tmpBasisValue + @Amount8 ELSE @tmpBasisValue / (1 - @Amount8 / 100) END
      IF @BrkQty9 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty9, CASE WHEN @CurAdjType = 'A' THEN @tmpBasisValue + @Amount9 ELSE @tmpBasisValue / (1 - @Amount9 / 100) END
      IF @BrkQty10 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty10, CASE WHEN @CurAdjType = 'A' THEN @tmpBasisValue + @Amount10 ELSE @tmpBasisValue / (1 - @Amount10 / 100) END
      IF @BrkQty11 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty11, CASE WHEN @CurAdjType = 'A' THEN @tmpBasisValue + @Amount11 ELSE @tmpBasisValue / (1 - @Amount11 / 100) END

    END
/*
	SELECT 
		@RecordType 'RecordType', 
		@tmpBasisValue 'TmpBasisValue',
		@ListPrice 'ListPrice',
		@CurAdjType 'CurAdjType', 
		@CurPriceBasis 'PriceBasis', 
		@UnitCost 'Cost', 
		@CurAmount 'CurAmount',
		@Price 'Price'
		*/

  END -- Price Matrix record found


  -- Now go for Sale Price - assumed to be all price overrides
  IF @RegularPrice = 0
  BEGIN
    
	BEGIN
      SET @PriceMatrixId = NULL
      SET @SalePrice = 0
      SELECT 
        @PriceMatrixId = PriceMatrixId,
        @BrkQty1 = BreakQty01,
        @BrkQty2 = BreakQty02,
        @BrkQty3 = BreakQty03,
        @BrkQty4 = BreakQty04,
        @BrkQty5 = BreakQty05,
        @BrkQty6 = BreakQty06,
        @BrkQty7 = BreakQty07,
        @BrkQty8 = BreakQty08,
        @BrkQty9 = BreakQty09,
        @BrkQty10 = BreakQty10,
        @BrkQty11 = BreakQty11,
        @Amount1 = Amount01,
        @Amount2 = Amount02,
        @Amount3 = Amount03,
        @Amount4 = Amount04,
        @Amount5 = Amount05,
        @Amount6 = Amount06,
        @Amount7 = Amount07,
        @Amount8 = Amount08,
        @Amount9 = Amount09,
        @Amount10 = Amount10,
        @Amount11 = Amount11
      FROM PriceMatrix (NOLOCK) 
      WHERE
        RecordType = 'Product Sale' AND
        CurrencyCode = @CurrencyCode AND
        Warehouse = @Warehouse AND
        UnitOfMeasure = @UnitOfMeasure AND
        CustomerKeyPart = '' AND
        ProductKeyPart = @ProductId AND
        Active <= @PricingDate AND
        (Deactivate IS NULL OR Deactivate > @PricingDate)

      IF @PriceMatrixId IS NOT NULL
      BEGIN
        IF @QtyOrdered >= @BrkQty1                    SET @SalePrice = @Amount1
        IF @QtyOrdered >= @BrkQty2  AND @BrkQty2  > 0 SET @SalePrice = @Amount2
        IF @QtyOrdered >= @BrkQty3  AND @BrkQty3  > 0 SET @SalePrice = @Amount3
        IF @QtyOrdered >= @BrkQty4  AND @BrkQty4  > 0 SET @SalePrice = @Amount4
        IF @QtyOrdered >= @BrkQty5  AND @BrkQty5  > 0 SET @SalePrice = @Amount5
        IF @QtyOrdered >= @BrkQty6  AND @BrkQty6  > 0 SET @SalePrice = @Amount6
        IF @QtyOrdered >= @BrkQty7  AND @BrkQty7  > 0 SET @SalePrice = @Amount7
        IF @QtyOrdered >= @BrkQty8  AND @BrkQty8  > 0 SET @SalePrice = @Amount8
        IF @QtyOrdered >= @BrkQty9  AND @BrkQty9  > 0 SET @SalePrice = @Amount9
        IF @QtyOrdered >= @BrkQty10 AND @BrkQty10 > 0 SET @SalePrice = @Amount10
        IF @QtyOrdered >= @BrkQty11 AND @BrkQty11 > 0 SET @SalePrice = @Amount11    

		-- Capture Price Breaks
		DELETE FROM @PriceBreaks
		INSERT INTO @PriceBreaks SELECT @BrkQty1, @Amount1
		IF @BrkQty2 > 0 AND @Amount2 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty2, @Amount2
		IF @BrkQty3 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty3, @Amount3
		IF @BrkQty4 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty4, @Amount4
		IF @BrkQty5 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty5, @Amount5
		IF @BrkQty6 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty6, @Amount6
		IF @BrkQty7 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty7, @Amount7
		IF @BrkQty8 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty8, @Amount8
		IF @BrkQty9 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty9, @Amount9
		IF @BrkQty10 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty10, @Amount10
		IF @BrkQty11 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty11, @Amount11

      END
      ELSE
      BEGIN
		IF @BasicSaleStartDate <= @PricingDate AND @BasicSaleEndDate IS NULL OR @BasicSaleEndDate > @PricingDate
			SET @SalePrice = @BasicSalePrice
      END

    END --  Standard vs Vendor MU sales price

    -- Check for 0 pricing
    SET @Price = ISNULL(@Price,0)
    IF @Price <= 0 SET @Price = ISNULL(@ListPrice,0)
    IF @Price <= 0 AND @UsingBaseUOM = 1 SET @Price = ISNULL(@BasicListPrice,0)

    IF @SalePrice > 0 AND @SalePrice < @Price
      SELECT
        @Price = @SalePrice, -- if it's actually less, set it
        @IsSalePrice = 1

  END -- RegularPrice=0
  
  ELSE BEGIN
    -- Check for 0 pricing
    SET @Price = ISNULL(@Price,0)
    IF @Price <= 0 SET @Price = ISNULL(@ListPrice,0)
    IF @Price <= 0 AND @UsingBaseUOM = 1 SET @Price = ISNULL(@BasicListPrice,0)
  END

  IF (@UsingBaseUOM = 0 AND @PriceIsOverride = 0)
  BEGIN
	DECLARE @QtyPerBase DECIMAL
	SELECT @QtyPerBase = QtyPerBaseUnitOfMeasure FROM ProductUnitOfMeasure (NOLOCK) WHERE ProductId = @ProductId AND UnitOfMeasure = @UnitOfMeasure
	IF NOT @QtyPerBase IS NULL
	BEGIN
 		SET @Price = @Price * @QtyPerBase
 		UPDATE @PriceBreaks SET Price = Price * @QtyPerBase
 	END
  END
  
  SELECT * FROM @PriceBreaks

  -- Output parameters do not appear to work if a stored proc returns a result set, so we are just going to return two result sets to get the data back
  SELECT @Price AS Price, @IsSalePrice AS IsSalePrice

END -- End of procedure

GO
/****** Object:  StoredProcedure [dbo].[PriceCalculator_Sx]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*-------------------------------------------------------------------------------
Copyright ? Insite Software Solutions, Inc. 2009 - All Rights Reserved

Name: PriceCalculator_Sx - Price Calculator for Sx Enterprise
Written By: Tom Frishberg
Dated: 09/15/09

Revision History
----------------
10/06/09, tjf, Reworked Product Types from codes to more verbal representations
10/29/09, tjf, Reworked again - less context to data, customer line discounts 
10/31/09, tjf, Reworked again - handling margin calculations; changing nulls to 
               empty strings for keyparts
11/02/09, wrb, Added logic to handle rounding
02/25/13, pwg, Changed to work with 3.4 PricingServiceDefault
08/30/13, tjf, Significant reworking to get it to work correctly;
				 excluding warehouse and UM on summary type records
09/03/13, tjf, Reworking to facilitate promotional pricing; breaking into
				separate code to price different matrix records; get
				price break table to reflect properly calculated data
10/02/13, tjf, Reworking to handle alternate units of measure
--------------------------------------------------------------------------------*/
CREATE PROCEDURE [dbo].[PriceCalculator_Sx]
  @CustomerId        uniqueidentifier = null,
  @ProductId         uniqueidentifier = null,
  @QtyOrdered        decimal(18,5) = 0,
  @CurrencyCode      nvarchar(50) = '',
  @Warehouse         nvarchar(50) = '',
  @UnitOfMeasure     nvarchar(50) = '',
  @PricingDate       datetime = null,
  @RegularPrice      tinyint = 0,  -- if 1 return price without sale or customer pricing  
  @Price             decimal(18,5) OUTPUT,
  @IsSalePrice       tinyint OUTPUT  -- only valid if ReturnListPrice = 0
AS
BEGIN
  DECLARE
    @PriceMatrixId      uniqueidentifier,
    @SalePrice          decimal(18,5),
    @SaleStartDate      datetime,
    @SaleEndDate        datetime,
    @ListPrice          decimal(18,5),
    @UnitCost           decimal(18,5),
    @ProductPriceCode   nvarchar(50),
    @ProductUM          nvarchar(50),
    @ProductVendorId    uniqueidentifier,
    @CustomerPriceCode  nvarchar(50),
    @Loop               int,
    @CurAmount          decimal(18,5),
    @CurAltAmount       decimal(18,5),
    @CurBrkQty          decimal(18,5),
    @CurPriceBasis      nvarchar(50),
    @CurAdjType         nvarchar(50),
    @tmpAdjustValue     decimal(18,5),
    @tmpPriceBasis      nvarchar(50),
    @VendorSaleMarkup   decimal(18,5),
	@OkToRound			int,
	@Debug				tinyint,
	@UMConversionFactor	int
	
  SET @Debug = 0

  /* Holding Tables */
  DECLARE @BasePriceBreaks TABLE (Qty decimal(18,5), Price decimal(18,5));
  DECLARE @PromoPriceBreaks TABLE (Qty decimal(18,5), Price decimal(18,5));
  DECLARE @StandardPrice decimal(18,5)
  DECLARE @PromoPrice decimal(18,5)



  /* Sx-specific parameters */
  DECLARE
    @ProductLine           nvarchar(50),  
    @ProductCategory       nvarchar(50),  
    @CustomerPriceLevel    int,
    @CustomerDiscountLevel int,
    @BasePrice             decimal(18,5),
	@BasicListPrice        decimal(18,5),
	@BasicSalePrice		   decimal(18,5),
	@BasicSaleStartDate	   datetime,
	@BasicSaleEndDate	   datetime,
    @ProductQtyBreak2      decimal(18,5),
    @ProductAmount02       decimal(18,5),
    @ProductAltAmount01    decimal(18,5),
    @tmpAmount             decimal(18,5),
    @Multiplier            decimal(18,5),
    @FallbackMultiplier    decimal(18,5),
    @Discount              decimal(18,5),
	@CalculationFlags	   nvarchar(50),	
	@Pround				   nvarchar(50),
	@Ptarget			   int	    

DECLARE @PriceBreaks TABLE (BreakQty DECIMAL(18,5), Price DECIMAL(18,5))

  IF @PricingDate IS NULL
    SET @PricingDate = getdate()
  SET @IsSalePrice = 0

  /* If they want list price, whack the customer reference */
  IF @RegularPrice <> 0 
    SET @CustomerId = NULL

  /* First get the product information */
  IF @ProductID IS NULL 
  BEGIN
    print 'Error - no product selected'
    RETURN 99
  END

  -- Default rounding to normal, two digits
  set @Pround = 'n'
  set @Ptarget = 5
  set @OkToRound = 1	

  SELECT 
    @ProductPriceCode = PriceCode, 
    @ProductUM = UnitOfMeasure,
    @UnitCost = Cost,
    @ProductVendorId = VendorId,
	@BasicListPrice = BasicListPrice,
	@BasicSalePrice = BasicSalePrice,
	@BasicSaleStartDate = BasicSaleStart,
	@BasicSaleEndDate = BasicSaleEnd
	
  FROM Product (NOLOCK)
  WHERE ProductId = @ProductId

  -- Unit Of Measure setup
  IF IsNull(@UnitOfMeasure,'') = ''
    SET @UnitOfMeasure = @ProductUM
  IF @UnitOfMeasure = @ProductUM 
    SET @UMConversionFactor = 1
  ELSE 
  BEGIN
    SELECT @UMConversionFactor = QtyPerBaseUnitOfMeasure
	FROM ProductUnitOfMeasure pum (NOLOCK)
	WHERE pum.ProductId = @ProductId and
	      pum.UnitOfMeasure = @UnitOfMeasure
    IF @UMConversionFactor IS NULL 
	  SET @UMConversionFactor = 1
  END
  	

 /* Get unit cost from warehouse table */
 DECLARE @WhseUnitCost decimal(18,5)
 SELECT @WhseUnitCost = UnitCost from ProductWarehouse (NOLOCK) join Warehouse (NOLOCK)
	on ProductWarehouse.WarehouseId = Warehouse.WarehouseId
	WHERE ProductWarehouse.ProductId = @ProductId AND 
		  Warehouse.Name = @Warehouse
 IF IsNull(@WhseUnitCost,0) > 0 SET @UnitCost = @WhseUnitCost

 -- Apply UM Conversion
 SELECT
	@ListPrice = @ListPrice * @UMConversionFactor,
	@UnitCost = @UnitCost * @UMConversionFactor,
    @BasicListPrice = @BasicListPrice * @UMConversionFactor,
	@BasicSalePrice = @BasicSalePrice * @UMConversionFactor

  /* Get List Price for basis calculations  - deprecating this - unlikely they'll ever really use manual product record entry */
  --SELECT 
  --  @ListPrice = Amount01,
  --  -- Sx - get additional data fields to determine if there is a 'real' P record or
  --  -- if it's simply there to hold the list price
  --  @ProductQtyBreak2 = BreakQty02, 
  --  @ProductAmount02 = Amount02,
  --  @ProductAltAmount01 = AltAmount01
  --FROM PriceMatrix (NOLOCK)
  --WHERE
  --  RecordType = 'Product' AND
  --  CurrencyCode = @CurrencyCode AND
  --  (Warehouse = @Warehouse OR @Warehouse = '') AND
  --  UnitOfMeasure = @UnitOfMeasure AND
  --  isnull(CustomerKeyPart,'') = ''  AND
  --  ProductKeyPart = cast(@ProductId as varchar(50)) AND
  --  Active <= @PricingDate AND
  --  (Deactivate IS NULL OR Deactivate > @PricingDate)

  -- If no 'Product' record, get it from the product itself
  IF IsNull(@ListPrice,0) = 0 SET @ListPrice = @BasicListPrice

  -- Get base price
  BEGIN
    SELECT @BasePrice = CAST(Value AS DECIMAL (18,5))
    FROM ProductProperty (NOLOCK) 
    WHERE
      ProductId = @ProductId AND
      Name = 'ERP_BasePrice'        
  END
  IF @BasePrice = 0 SET @BasePrice = @ListPrice   --this may not be 100% correct but I think we need something in base price
  ELSE
	SELECT @BasePrice = @BasePrice * @UMConversionFactor

  /* Sx - get alternate product types */
  SET @ProductLine = ''
  SET @ProductCategory = ''
  SELECT @ProductLine = Value 
  FROM ProductProperty (NOLOCK) 
  WHERE
    ProductId = @ProductId AND
    Name = 'ERP_ProdLine'

  SELECT @ProductCategory = Value 
  FROM ProductProperty (NOLOCK) 
  WHERE
    ProductId = @ProductId AND
    Name = 'ERP_ProdCat'    
    
  /* Next get the customer information, if any */
  SET @CustomerPriceLevel = 1
  IF @CustomerId IS NOT NULL
  BEGIN
    SELECT
      @CustomerPriceCode = PriceCode
    FROM Customer (NOLOCK)
    WHERE CustomerId = @CustomerId

    /* Sx - get price level */
    SELECT @CustomerPriceLevel = CAST(Value AS INT) 
    FROM CustomerProperty (NOLOCK) 
    WHERE
      CustomerId = @CustomerId AND
      Name = 'ERP_PriceLevel'        
    IF @CustomerPriceLevel IS NULL
      SET @CustomerPriceLevel = 1

    /* Sx - get line discount level */
    SELECT @CustomerDiscountLevel = CAST(Value AS INT) 
    FROM CustomerProperty (NOLOCK) 
    WHERE
      CustomerId = @CustomerId AND
      Name = 'ERP_PriceDscLevel'        
    IF @CustomerDiscountLevel IS NULL
      SET @CustomerDiscountLevel = 0

  END

 IF @Debug = 1 select @ListPrice 'ListPrice',@BasePrice 'BasePrice',@CustomerPriceLevel 'CustPrcLvl',@CustomerDiscountLevel 'CustDscLvl'


  /* Now try and find which record will hold the key */
  SET @PriceMatrixId = NULL
  
  /* Customer/Product (type 1) */
  IF @PriceMatrixId IS NULL AND @CustomerId IS NOT NULL
  BEGIN
    SELECT @PriceMatrixID = PriceMatrixID
    FROM PriceMatrix (NOLOCK) 
    WHERE
      RecordType = 'Customer/Product' AND
      CurrencyCode = @CurrencyCode AND
      (Warehouse = @Warehouse OR Warehouse = '') AND
      UnitOfMeasure = @UnitOfMeasure AND
      CustomerKeyPart = cast(@CustomerId as varchar(50)) AND
      ProductKeyPart = Cast(@ProductId as varchar(50)) AND
      Active <= @PricingDate AND
      (Deactivate IS NULL OR Deactivate > @PricingDate)
  END

  /* Customer/Product - no specific UM (type 1) */
  IF @PriceMatrixId IS NULL AND @CustomerId IS NOT NULL
  BEGIN
    SELECT @PriceMatrixID = PriceMatrixID
    FROM PriceMatrix (NOLOCK) 
    WHERE
      RecordType = 'Customer/Product' AND
      CurrencyCode = @CurrencyCode AND
      (Warehouse = @Warehouse OR Warehouse = '') AND
     -- UnitOfMeasure = @UnitOfMeasure AND
      CustomerKeyPart = cast(@CustomerId as varchar(50)) AND
      ProductKeyPart = Cast(@ProductId as varchar(50)) AND
      Active <= @PricingDate AND
      (Deactivate IS NULL OR Deactivate > @PricingDate)
  END

  /* Customer/Product Price Code (type 2, P-) */
  IF @PriceMatrixId IS NULL AND @CustomerId IS NOT NULL
  BEGIN
    SELECT @PriceMatrixID = PriceMatrixID
    FROM PriceMatrix (NOLOCK) 
    WHERE
      RecordType = 'Customer/Product Price Code' AND
      CurrencyCode = @CurrencyCode AND
      (Warehouse = @Warehouse OR Warehouse = '') AND
      --UnitOfMeasure = @UnitOfMeasure AND
      CustomerKeyPart = cast(@CustomerId as varchar(50)) AND
      ProductKeyPart = 'P-' + @ProductPriceCode AND
      Active <= @PricingDate AND
      (Deactivate IS NULL OR Deactivate > @PricingDate)
  END

  /* Customer/Product Line (type 2, L-) */
  IF @PriceMatrixId IS NULL AND @CustomerId IS NOT NULL
     AND @ProductLine <> ''
  BEGIN
    SELECT @PriceMatrixID = PriceMatrixID
    FROM PriceMatrix (NOLOCK) 
    WHERE
      RecordType = 'Customer/Product Price Line' AND
      CurrencyCode = @CurrencyCode AND
      (Warehouse = @Warehouse OR Warehouse = '') AND
      --UnitOfMeasure = @UnitOfMeasure AND
      CustomerKeyPart = cast(@CustomerId as varchar(50)) AND
      ProductKeyPart = 'L-' + @ProductLine AND
      Active <= @PricingDate AND
      (Deactivate IS NULL OR Deactivate > @PricingDate)
  END

  /* Customer/Product Category (type 2 C-) */
  IF @PriceMatrixId IS NULL AND @CustomerId IS NOT NULL 
     AND @ProductCategory <> ''
  BEGIN
    SELECT @PriceMatrixID = PriceMatrixID
    FROM PriceMatrix (NOLOCK) 
    WHERE
      RecordType = 'Customer/Product Price Category' AND
      CurrencyCode = @CurrencyCode AND
      (Warehouse = @Warehouse OR Warehouse = '') AND
      --UnitOfMeasure = @UnitOfMeasure AND
      CustomerKeyPart = cast(@CustomerId as varchar(50)) AND
      ProductKeyPart = 'C-' + @ProductCategory AND
      Active <= @PricingDate AND
      (Deactivate IS NULL OR Deactivate > @PricingDate)
  END  
  
  /* Customer Price Code/Product (type 3) */
  IF @PriceMatrixId IS NULL AND @CustomerId IS NOT NULL 
     AND @CustomerPriceCode <> ''
  BEGIN
    SELECT @PriceMatrixID = PriceMatrixID
    FROM PriceMatrix (NOLOCK) 
    WHERE
      RecordType = 'Customer Price Code/Product' AND
      CurrencyCode = @CurrencyCode AND
      (Warehouse = @Warehouse OR Warehouse = '')  AND
      UnitOfMeasure = @UnitOfMeasure AND
      CustomerKeyPart = @CustomerPriceCode AND
      ProductKeyPart = Cast(@ProductId as varchar(50))  AND
      Active <= @PricingDate AND
      (Deactivate IS NULL OR Deactivate > @PricingDate)
  END        

  /* Customer Price Code/Product  - no specific UM (type 3) */
  IF @PriceMatrixId IS NULL AND @CustomerId IS NOT NULL 
     AND @CustomerPriceCode <> ''
  BEGIN
    SELECT @PriceMatrixID = PriceMatrixID
    FROM PriceMatrix (NOLOCK) 
    WHERE
      RecordType = 'Customer Price Code/Product' AND
      CurrencyCode = @CurrencyCode AND
      (Warehouse = @Warehouse OR Warehouse = '')  AND
      --UnitOfMeasure = @UnitOfMeasure AND
      CustomerKeyPart = @CustomerPriceCode AND
      ProductKeyPart = Cast(@ProductId as varchar(50))  AND
      Active <= @PricingDate AND
      (Deactivate IS NULL OR Deactivate > @PricingDate)
  END        

  /* Customer Price Code/Product Type (type 4, P-) */
  IF @PriceMatrixId IS NULL AND @CustomerId IS NOT NULL 
     AND @CustomerPriceCode <> ''
     AND @ProductPriceCode <> ''
  BEGIN
    IF @Debug = 1 select @CurrencyCode 'currcd',@warehouse 'whs',@UnitOfMeasure 'um', @CustomerPriceCode 'pricecode',@ProductPriceCode 'prod code'

    SELECT @PriceMatrixID = PriceMatrixID
    FROM PriceMatrix (NOLOCK) 
    WHERE
      RecordType = 'Customer Price Code/Product Price Code' AND
      CurrencyCode = @CurrencyCode AND
      (Warehouse = @Warehouse OR Warehouse = '') AND
      --UnitOfMeasure = @UnitOfMeasure AND
      CustomerKeyPart = @CustomerPriceCode AND
      ProductKeyPart = 'P-' + @ProductPriceCode AND
      Active <= @PricingDate AND
      (Deactivate IS NULL OR Deactivate > @PricingDate)
  END        

  /* Customer Specific (type 5) */
  IF @PriceMatrixId IS NULL AND @CustomerId IS NOT NULL 
     AND @CustomerPriceLevel > 0
  BEGIN
    SELECT @PriceMatrixID = PriceMatrixID
    FROM PriceMatrix (NOLOCK) 
    WHERE
      RecordType = 'Customer' AND
      CurrencyCode = @CurrencyCode AND
      (Warehouse = @Warehouse OR Warehouse = '') AND
      --UnitOfMeasure = @UnitOfMeasure AND
      CustomerKeyPart = cast(@CustomerId as varchar(50)) AND
      isnull(ProductKeyPart,'') = ''  AND
      Active <= @PricingDate AND
      (Deactivate IS NULL OR Deactivate > @PricingDate)
  END    

  /* Customer Price Code (type 6) */
  IF @PriceMatrixId IS NULL AND @CustomerId IS NOT NULL 
     AND @CustomerPriceCode <> ''
  BEGIN
    SELECT @PriceMatrixID = PriceMatrixID
    FROM PriceMatrix (NOLOCK) 
    WHERE
      RecordType = 'Customer Price Code' AND
      CurrencyCode = @CurrencyCode AND
	  (Warehouse = @Warehouse or Warehouse = '') AND
      --UnitOfMeasure = @UnitOfMeasure AND
      CustomerKeyPart = @CustomerPriceCode AND
      isnull(ProductKeyPart,'') = ''  AND
      Active <= @PricingDate AND
      (Deactivate IS NULL OR Deactivate > @PricingDate)
  END    

  /* Product Base Record - grabbing this record if there are any breaks or
     customer-level prices (i.e. something other than list price) type 7/non-promotional */
  IF @PriceMatrixId IS NULL AND
   (@ProductQtyBreak2 > 0 OR @ProductAmount02 > 0 OR @ProductAltAmount01 > 0)  
  BEGIN
    SELECT @PriceMatrixID = PriceMatrixID
    FROM PriceMatrix (NOLOCK) 
    WHERE
      RecordType = 'Product' AND
      CurrencyCode = @CurrencyCode AND
      (Warehouse = @Warehouse OR Warehouse = '') AND
      UnitOfMeasure = @UnitOfMeasure AND
      isnull(CustomerKeyPart,'') = ''  AND
      ProductKeyPart = Cast(@ProductId as varchar(50)) AND
      Active <= @PricingDate AND
      (Deactivate IS NULL OR Deactivate > @PricingDate)
  END    

  /* Product Record - no specific UM */
  IF @PriceMatrixId IS NULL AND
   (@ProductQtyBreak2 > 0 OR @ProductAmount02 > 0 OR @ProductAltAmount01 > 0)  
  BEGIN
    SELECT @PriceMatrixID = PriceMatrixID
    FROM PriceMatrix (NOLOCK) 
    WHERE
      RecordType = 'Product' AND
      CurrencyCode = @CurrencyCode AND
      (Warehouse = @Warehouse OR Warehouse = '') AND
      --UnitOfMeasure = @UnitOfMeasure AND
      isnull(CustomerKeyPart,'') = ''  AND
      ProductKeyPart = Cast(@ProductId as varchar(50)) AND
      Active <= @PricingDate AND
      (Deactivate IS NULL OR Deactivate > @PricingDate)
  END    

  /* Product Type (type 8, non-promotional, no P-) */
  IF @PriceMatrixId IS NULL
     AND @ProductPriceCode <> '' 
     AND @RegularPrice = 0
  BEGIN
    SELECT @PriceMatrixID = PriceMatrixID
    FROM PriceMatrix (NOLOCK) 
    WHERE
      RecordType = 'Product Price Code' AND
      CurrencyCode = @CurrencyCode AND
      (Warehouse = @Warehouse OR Warehouse = '') AND
      --UnitOfMeasure = @UnitOfMeasure AND
      isnull(CustomerKeyPart,'') = ''  AND
      ProductKeyPart = @ProductPriceCode AND
      Active <= @PricingDate AND
      (Deactivate IS NULL OR Deactivate > @PricingDate)
  END    

IF @Debug = 1 select @Pricematrixid as 'Selected MID'

	/* Check to see if we have a valid record and read it in */
	IF @PriceMatrixId IS NULL
	BEGIN
		SET @Price = @ListPrice
		SET @StandardPrice = @Price
	END

	-- Test current matrix
	ELSE
		BEGIN
			INSERT into @BasePriceBreaks
			SELECT * FROM dbo.calcmatrixresults_sx(@PriceMatrixId,@UnitCost,@ListPrice,@BasePrice,
												   @ProductVendorId,@CustomerPriceLevel,@CustomerDiscountLevel,
												   @UnitOfMeasure,@UMConversionFactor)
			SELECT TOP 1 @StandardPrice = Price FROM @BasePriceBreaks WHERE @QtyOrdered >= Qty ORDER BY Qty DESC 
			SELECT @Price = @StandardPrice,@PromoPrice = 0
	
			IF @Debug = 1 
			BEGIN
			    select @Price 'Price from std matrix'
				select * From @BasePriceBreaks order by qty
			END	
		END


	-- See if there are any promotional records
	SELECT @PriceMatrixId = NULL
	SELECT @PriceMatrixID = PriceMatrixID
	FROM PriceMatrix (NOLOCK) 
	WHERE
		RecordType = 'Product Promotion' AND
		CurrencyCode = @CurrencyCode AND
		(Warehouse = @Warehouse OR Warehouse = '') AND
		UnitOfMeasure = @UnitOfMeasure AND
		isnull(CustomerKeyPart,'') = ''  AND
		ProductKeyPart = @ProductId AND
		Active <= @PricingDate AND
		(Deactivate IS NULL OR Deactivate > @PricingDate)

    /* Product promo - no specific UM */
    IF @PriceMatrixId IS NULL
	BEGIN
		SELECT @PriceMatrixID = PriceMatrixID
		FROM PriceMatrix (NOLOCK) 
		WHERE
			RecordType = 'Product Promotion' AND
			CurrencyCode = @CurrencyCode AND
			(Warehouse = @Warehouse OR Warehouse = '') AND
			--UnitOfMeasure = @UnitOfMeasure AND
			isnull(CustomerKeyPart,'') = ''  AND
			ProductKeyPart = @ProductId AND
			Active <= @PricingDate AND
			(Deactivate IS NULL OR Deactivate > @PricingDate)

	IF @PriceMatrixId IS NULL
	BEGIN
		SELECT @PriceMatrixID = PriceMatrixID
		FROM PriceMatrix (NOLOCK) 
		WHERE
			RecordType = 'Product Price Code Promotion' AND
			CurrencyCode = @CurrencyCode AND
			(Warehouse = @Warehouse OR Warehouse = '') AND
			--UnitOfMeasure = @UnitOfMeasure AND
			isnull(CustomerKeyPart,'') = ''  AND
			ProductKeyPart = @ProductPriceCode AND
			Active <= @PricingDate AND
			(Deactivate IS NULL OR Deactivate > @PricingDate)
		END   
	END

	IF @PriceMatrixID IS NOT NULL
	BEGIN
		IF @Debug = 1 select @PriceMatrixId as 'Promo Matrix'
		INSERT into @PromoPriceBreaks
			SELECT * FROM dbo.calcmatrixresults_sx(@PriceMatrixId,@UnitCost,@ListPrice,@BasePrice,
													@ProductVendorId,@CustomerPriceLevel,@CustomerDiscountLevel,
													@UnitOfMeasure,@UMConversionFactor)
		SELECT TOP 1 @PromoPrice = Price FROM @PromoPriceBreaks WHERE @QtyOrdered >= Qty ORDER BY Qty DESC 
		IF @PromoPrice > 0 AND @PromoPrice < @StandardPrice SET @Price = @PromoPrice
		IF @Debug = 1 begin
			select @PromoPrice 'Promo Price',@StandardPrice 'standard price',@QtyOrdered 'qty ordered'
			select * FROM @PromoPriceBreaks order by qty
		END
	END


	-- Finally - Sale Pricing - assuming they will NOT use Product Sale records - only basic sale
	IF @BasicSalePrice > 0 AND @BasicSaleStartDate < GETDATE() and @BasicSaleEndDate > GETDATE() AND
		@BasicSalePrice < @Price
	SELECT @Price = @BasicSalePrice,@IsSalePrice = 1

	IF @Debug = 1 select @Price 'Price after promo'
    


  -- Determine which matrix to send back
  IF @Debug = 1 select 'Grid being returned...'
  IF @PromoPrice > 0 AND @PromoPrice < @StandardPrice	
	SELECT Qty as BreakQty, Price FROM @PromoPriceBreaks order by qty
  ELSE
    SELECT Qty as BreakQty, Price FROM @BasePriceBreaks order by qty
  IF @Debug = 1 SELECT @QtyOrdered as 'Qty Ordered', @Price AS 'SX_Price',@IsSalePrice as 'SX_IsSalePrice' 

  SELECT @Price as Price, @IsSalePrice as IsSalePrice
		

END -- End of procedure

GO
/****** Object:  StoredProcedure [dbo].[PriceCalculator_Syteline]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PriceCalculator_Syteline]
		@CustomerId        uniqueidentifier = null,
		@ProductId         uniqueidentifier = null,
		@QtyOrdered        decimal(18,5) = 0,
		@CurrencyCode      nvarchar(50) = '',
		@Warehouse         nvarchar(50) = '',
		@UnitOfMeasure     nvarchar(50) = '',
		@PricingDate       datetime = null,
		@RegularPrice      tinyint = 0,  -- if 1 return price without sale or customer pricing  
		@Price             decimal(18,5) OUTPUT,
		@IsSalePrice       tinyint OUTPUT  -- only valid if ReturnListPrice = 0
	AS
	BEGIN 
		declare
			@Loop               int,
			@CurAmount          decimal(18,5),
			@CurAltAmount       decimal(18,5),
			@CurBrkQty          decimal(18,5),
			@CurPriceBasis      nvarchar(50),
			@CurAdjType         nvarchar(50),
			@tmpBasisValue      decimal(18,5),
			@tmpAdjustValue     decimal(18,5),
			@tmpPriceBasis      nvarchar(50),
			@VendorSaleMarkup   decimal(18,5),
			@ProductPriceCode	nvarchar(50),
			@ProductUM			nvarchar(50),
			@UnitCost			decimal(18,5),
			@ProductVendorId	uniqueidentifier,
			@ListPrice			decimal(18,5),
			@PriceMatrixId		uniqueidentifier,
			@RecordType			nvarchar(50),
			@SalePrice			decimal(18,5)

	DECLARE
		@BrkQty1            decimal(18,5),
		@BrkQty2            decimal(18,5),
		@BrkQty3            decimal(18,5),
		@BrkQty4            decimal(18,5),
		@BrkQty5            decimal(18,5),
		@BrkQty6            decimal(18,5),
		@BrkQty7            decimal(18,5),
		@BrkQty8            decimal(18,5),
		@BrkQty9            decimal(18,5),
		@BrkQty10           decimal(18,5),
		@BrkQty11           decimal(18,5),
		@PriceBasis1        nvarchar(50),
		@PriceBasis2        nvarchar(50),
		@PriceBasis3        nvarchar(50),
		@PriceBasis4        nvarchar(50),
		@PriceBasis5        nvarchar(50),
		@PriceBasis6        nvarchar(50),
		@PriceBasis7        nvarchar(50),
		@PriceBasis8        nvarchar(50),
		@PriceBasis9        nvarchar(50),
		@PriceBasis10       nvarchar(50),
		@PriceBasis11       nvarchar(50),
		@AdjType1           nvarchar(50),
		@AdjType2           nvarchar(50),
		@AdjType3           nvarchar(50),
		@AdjType4           nvarchar(50),
		@AdjType5           nvarchar(50),
		@AdjType6           nvarchar(50),
		@AdjType7           nvarchar(50),
		@AdjType8           nvarchar(50),
		@AdjType9           nvarchar(50),
		@AdjType10          nvarchar(50),
		@AdjType11          nvarchar(50),
		@Amount1            decimal(18,5),
		@Amount2            decimal(18,5),
		@Amount3            decimal(18,5),
		@Amount4            decimal(18,5),
		@Amount5            decimal(18,5),
		@Amount6            decimal(18,5),
		@Amount7            decimal(18,5),
		@Amount8            decimal(18,5),
		@Amount9            decimal(18,5),
		@Amount10           decimal(18,5),
		@Amount11           decimal(18,5),
		@AltAmount1         decimal(18,5),    
		@AltAmount2         decimal(18,5),    
		@AltAmount3         decimal(18,5),    
		@AltAmount4         decimal(18,5),    
		@AltAmount5         decimal(18,5),    
		@AltAmount6         decimal(18,5),    
		@AltAmount7         decimal(18,5),    
		@AltAmount8         decimal(18,5),    
		@AltAmount9         decimal(18,5),    
		@AltAmount10        decimal(18,5),    
		@AltAmount11        decimal(18,5)
		
	/* SyteLine-specific variables */
	DECLARE
		@PriceLevel1        decimal(18,5),
		@PriceLevel2        decimal(18,5),
		@PriceLevel3        decimal(18,5),
		@PriceLevel4        decimal(18,5),
		@PriceLevel5        decimal(18,5),
		@PriceLevel6        decimal(18,5)

    DECLARE @PriceBreaks TABLE (BreakQty DECIMAL(18,5), Price DECIMAL(18,5))

	-- Set the pricingdate to date only, no time
	IF @PricingDate IS NULL
	begin
		SET @PricingDate = getdate()
	end

	set @PricingDate = dateadd(dd,0,datediff(dd,0,@PricingDate))
	
	SET @IsSalePrice = 0
	SET @tmpBasisValue = 0

	/* If they want list price, whack the customer reference */
	IF @RegularPrice <> 0 
		SET @CustomerId = null

	/* First get the product information */
	IF @ProductID IS null
	BEGIN
		print 'Error - no product selected'
		RETURN 99
	END

	-- Get Product Info
	SELECT 
			@ProductUM = UnitOfMeasure,
			@UnitCost = Cost,
			@ProductVendorId = VendorId
		FROM Product (NOLOCK)
		WHERE ProductId = @ProductId

	IF IsNull(@UnitOfMeasure,'') = ''
		SET @UnitOfMeasure = @ProductUM

	/* Get List Price and Price Code for basis calculations */
	--set @ListPrice = dbo.GetListPrice_SyteLine(@ProductId,@CurrencyCode,@Warehouse,@UnitOfMeasure,@PricingDate)
	select @ListPrice = ListPrice,@ProductPriceCode = PriceCode
			,@PriceLevel1 = PriceLevel1
			,@PriceLevel2 = PriceLevel2
			,@PriceLevel3 = PriceLevel3
			,@PriceLevel4 = PriceLevel4
			,@PriceLevel5 = PriceLevel5
			,@PriceLevel6 = PriceLevel6
		from dbo.GetListPrice_Syteline
		(@ProductId,@CurrencyCode,@Warehouse,@UnitOfMeasure,@PricingDate)

 	/* Now try and find which record will hold the key */
	--select @CustomerId,@ProductId,@CurrencyCode,@Warehouse,@UnitOfMeasure,@PricingDate
	
	SET @PriceMatrixId = dbo.GetPriceMatrixId_Syteline(@CustomerId,@ProductId,@CurrencyCode,@Warehouse,@UnitOfMeasure,@PricingDate,@ProductPriceCode)
	--select @PriceMatrixId  

	/* Check to see if we have a valid record and read it in */
	IF @PriceMatrixId IS NULL
	BEGIN
		SET @Price = @ListPrice
	END
	else
	begin
		select 
			@RecordType = recordtype,
		@BrkQty1 = BreakQty01,
		@BrkQty2 = BreakQty02,
		@BrkQty3 = BreakQty03,
		@BrkQty4 = BreakQty04,
		@BrkQty5 = BreakQty05,
		@BrkQty6 = BreakQty06,
		@BrkQty7 = BreakQty07,
		@BrkQty8 = BreakQty08,
		@BrkQty9 = BreakQty09,
		@BrkQty10 = BreakQty10,
		@BrkQty11 = BreakQty11,
		@PriceBasis1 = PriceBasis01,
		@PriceBasis2 = PriceBasis02,
		@PriceBasis3 = PriceBasis03,
		@PriceBasis4 = PriceBasis04,
		@PriceBasis5 = PriceBasis05,
		@PriceBasis6 = PriceBasis06,
		@PriceBasis7 = PriceBasis07,
		@PriceBasis8 = PriceBasis08,
		@PriceBasis9 = PriceBasis09,
		@PriceBasis10 = PriceBasis10,
		@PriceBasis11 = PriceBasis11,
		@AdjType1 = AdjustmentType01,
		@AdjType2 = AdjustmentType02,
		@AdjType3 = AdjustmentType03,
		@AdjType4 = AdjustmentType04,
		@AdjType5 = AdjustmentType05,
		@AdjType6 = AdjustmentType06,
		@AdjType7 = AdjustmentType07,
		@AdjType8 = AdjustmentType08,
		@AdjType9 = AdjustmentType09,
		@AdjType10 = AdjustmentType10,
		@AdjType11 = AdjustmentType11,
		@Amount1 = Amount01,
		@Amount2 = Amount02,
		@Amount3 = Amount03,
		@Amount4 = Amount04,
		@Amount5 = Amount05,
		@Amount6 = Amount06,
		@Amount7 = Amount07,
		@Amount8 = Amount08,
		@Amount9 = Amount09,
		@Amount10 = Amount10,
		@Amount11 = Amount11,
		@AltAmount1 = AltAmount01,
		@AltAmount2 = AltAmount02,
		@AltAmount3 = AltAmount03,
		@AltAmount4 = AltAmount04,
		@AltAmount5 = AltAmount05,
		@AltAmount6 = AltAmount06,
		@AltAmount7 = AltAmount07,
		@AltAmount8 = AltAmount08,
		@AltAmount9 = AltAmount09,
		@AltAmount10 = AltAmount10,
		@AltAmount11 = AltAmount11,
		@tmpBasisValue = AltAmount01
	FROM PriceMatrix (NOLOCK)
	WHERE PriceMatrixId = @PriceMatrixId

		-- Capture Price Breaks
		DELETE FROM @PriceBreaks
		INSERT INTO @PriceBreaks SELECT @BrkQty1, @Amount1
		IF @BrkQty2 > 0 AND @Amount2 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty2, @Amount2
		IF @BrkQty3 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty3, @Amount3
		IF @BrkQty4 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty4, @Amount4
		IF @BrkQty5 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty5, @Amount5
		IF @BrkQty6 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty6, @Amount6
		IF @BrkQty7 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty7, @Amount7
		IF @BrkQty8 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty8, @Amount8
		IF @BrkQty9 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty9, @Amount9
		IF @BrkQty10 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty10, @Amount10
		IF @BrkQty11 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty11, @Amount11

	SELECT
		@CurAmount = @Amount1,
		@CurBrkQty = 0,
		@CurPriceBasis = @PriceBasis1,
		@CurAdjType = @AdjType1


	/* And now the ugly stuff - traversing through the given record and figuring out price */
	IF @CurPriceBasis in ('P1','P2','P3','P4','P5')
	begin
		IF @CurPriceBasis = 'P1'
		begin
			-- get the BasisValue from the product pricematrix record
			SELECT 
				@tmpBasisValue = AltAmount01
			FROM PriceMatrix (NOLOCK)
			WHERE productkeypart = @Productid and recordtype = 'Product'
		end

		IF @CurPriceBasis = 'P2'
		begin
			-- get the BasisValue from the product pricematrix record
			SELECT 
				@tmpBasisValue = AltAmount02
			FROM PriceMatrix (NOLOCK)
			WHERE productkeypart = @Productid and recordtype = 'Product'
		end
		IF @CurPriceBasis = 'P3'
		begin
			-- get the BasisValue from the product pricematrix record
			SELECT 
				@tmpBasisValue = AltAmount03
			FROM PriceMatrix (NOLOCK)
			WHERE productkeypart = @Productid and recordtype = 'Product'
		end
		IF @CurPriceBasis = 'P4'
		begin
			-- get the BasisValue from the product pricematrix record
			SELECT 
				@tmpBasisValue = AltAmount04
			FROM PriceMatrix (NOLOCK)
			WHERE productkeypart = @Productid and recordtype = 'Product'
		end
		IF @CurPriceBasis = 'P5'
		begin
			-- get the BasisValue from the product pricematrix record
			SELECT 
				@tmpBasisValue = AltAmount05
			FROM PriceMatrix (NOLOCK)
			WHERE productkeypart = @Productid and recordtype = 'Product'
		end
	end

	IF @QtyOrdered >= @BrkQty1 AND @BrkQty1 > 0
	begin
		SELECT
			@CurAmount = @Amount1,
			@CurBrkQty = @BrkQty1,
			@CurPriceBasis = @PriceBasis1,
			@CurAdjType = @AdjType1
	end

	IF @QtyOrdered >= @BrkQty2 AND @BrkQty2 > 0
	begin
		SELECT
			@CurAmount = @Amount2,
			@CurBrkQty = @BrkQty2,
			@CurPriceBasis = @PriceBasis2,
			@CurAdjType = @AdjType2
	end

	IF @QtyOrdered >= @BrkQty3 AND @BrkQty3 > 0
	begin
		SELECT
			@CurAmount = @Amount3,
			@CurBrkQty = @BrkQty3,
			@CurPriceBasis = @PriceBasis3,
			@CurAdjType = @AdjType3
	end
	IF @QtyOrdered >= @BrkQty4 AND @BrkQty4 > 0
	begin
		SELECT
			@CurAmount = @Amount4,
			@CurBrkQty = @BrkQty4,
			@CurPriceBasis = @PriceBasis4,
			@CurAdjType = @AdjType4
	end
	IF @QtyOrdered >= @BrkQty5 AND @BrkQty5 > 0
	begin
		SELECT
			@CurAmount = @Amount5,
			@CurBrkQty = @BrkQty5,
			@CurPriceBasis = @PriceBasis5,
			@CurAdjType = @AdjType5
	end
	IF @QtyOrdered >= @BrkQty6 AND @BrkQty6 > 0
	begin
		SELECT
			@CurAmount = @Amount6,
			@CurBrkQty = @BrkQty6,
			@CurPriceBasis = @PriceBasis6,
			@CurAdjType = @AdjType6
	end
	IF @QtyOrdered >= @BrkQty7 AND @BrkQty7 > 0
	begin
		SELECT
			@CurAmount = @Amount7,
			@CurBrkQty = @BrkQty7,
			@CurPriceBasis = @PriceBasis7,
			@CurAdjType = @AdjType7
	end
	IF @QtyOrdered >= @BrkQty8 AND @BrkQty8 > 0
	begin
		SELECT
			@CurAmount = @Amount8,
			@CurBrkQty = @BrkQty8,
			@CurPriceBasis = @PriceBasis8,
			@CurAdjType = @AdjType8
	end
	IF @QtyOrdered >= @BrkQty9 AND @BrkQty9 > 0
	begin
		SELECT
			@CurAmount = @Amount9,
			@CurBrkQty = @BrkQty9,
			@CurPriceBasis = @PriceBasis9,
			@CurAdjType = @AdjType9
	end
	IF @QtyOrdered >= @BrkQty10 AND @BrkQty10 > 0
	begin
		SELECT
			@CurAmount = @Amount10,
			@CurBrkQty = @BrkQty10,
			@CurPriceBasis = @PriceBasis10,
			@CurAdjType = @AdjType10
	end
	IF @QtyOrdered >= @BrkQty11 AND @BrkQty11 > 0
	begin
		SELECT
			@CurAmount = @Amount11,
			@CurBrkQty = @BrkQty11,
			@CurPriceBasis = @PriceBasis11,
			@CurAdjType = @AdjType11
	end
	/*
		select 
			@RecordType = recordtype,
			@curamount = curamount,
			@CurBrkQty = curbrkqty,
			@CurPriceBasis = curpricebasis,	
			@CurAdjType = curadjtype,
			@tmpBasisValue = curBasisValue
		from dbo.GetPricingBasis_Syteline(@PriceMatrixId,cast(@Productid as nvarchar(36)),@QtyOrdered )
	  */	 	
	  
	  select @curPriceBasis 'CurPriceBasis'
	  
		/* Set price basis level */
		--SET @tmpBasisValue = @ListPrice

		IF @CurPriceBasis = 'C' SET @tmpBasisValue = @UnitCost
		IF @CurPriceBasis = 'M' SET @tmpBasisValue = @UnitCost -- margin
		IF @CurPriceBasis = 'MU' SET @tmpBasisValue = @UnitCost -- markup (mu/vmu)
		IF @CurPriceBasis = 'L' SET @tmpBasisValue = @ListPrice
--   		IF @CurPriceBasis IN ('P1','P2','P3','P4','P5','P6') set @tmpBasisValue = @curPriceBasis
	    		
		IF @CurPriceBasis = 'P1' SET @tmpBasisValue = @PriceLevel1
		IF @CurPriceBasis = 'P2' SET @tmpBasisValue = @PriceLevel2
		IF @CurPriceBasis = 'P3' SET @tmpBasisValue = @PriceLevel3
		IF @CurPriceBasis = 'P4' SET @tmpBasisValue = @PriceLevel4
		IF @CurPriceBasis = 'P5' SET @tmpBasisValue = @PriceLevel5
		IF @CurPriceBasis = 'P6' SET @tmpBasisValue = @PriceLevel6


	select @RecordType 'RecordType', @tmpBasisValue 'TmpBasisValue',@ListPrice 'ListPrice',
	@CurAdjType 'CurAdjType', @CurPriceBasis 'PriceBasis', @UnitCost 'Cost', @CurAmount 'CurAmount'

		/* Get vendor markup % if VMU */
		IF @CurPriceBasis = 'VMU' AND @ProductVendorId <> ''
		BEGIN
		  SET @VendorSaleMarkup = 0
		  SET @tmpAdjustValue = 0  -- if the customer needs a default markup, set here
		  SELECT  @tmpAdjustValue = RegularMarkup,
				  @VendorSaleMarkup = SaleMarkup
		  FROM Vendor (NOLOCK)
		  WHERE VendorId = @ProductVendorId    
		END  


		/* Calculate actual price based on current break */
	    
		/* Override Price */
		IF @CurPriceBasis = 'O' AND @CurAdjType = 'A'
		if @CurAmount = 0  
			SET @Price = @ListPrice
		else
			set @Price = @CurAmount

		/* Non-derived-Based types - always adds */
		IF @CurPriceBasis IN ('P1','P2','P3','P4','P5','P6')
		BEGIN
			IF @CurAdjType = 'A'
			begin
				set @Price = @ListPrice + @CurAmount
				--SET @Price = @tmpBasisValue + @CurAmount
			end

			IF @CurAdjType = 'P'
			begin
				--SET @Price = @ListPrice * (1 + @CurAmount / 100)
				SET @Price = @tmpBasisValue * (1 + @CurAmount / 100)
			end
		END -- non-derived

		IF @CurPriceBasis IN ('C','MU','L')
		begin
			IF @CurAdjType = 'A'
			begin
				SET @Price = @tmpBasisValue + @CurAmount
			end

			IF @CurAdjType = 'P'
			begin
				SET @Price = @tmpBasisValue * (1 + @CurAmount / 100)
			end

		end

		/* Margin */
		IF @CurPriceBasis = 'M'
		BEGIN
		  IF @CurAdjType = 'A'
			SET @Price = @CurAmount + @tmpBasisValue
		  IF @CurAdjType = 'P'
			SET @Price = @tmpBasisValue / (1 - @CurAmount / 100) 
		END

  END -- Price Matrix record found


  -- Now go for Sale Price - assumed to be all price overrides
  IF @RegularPrice = 0
  BEGIN
    
    /* Special case - vendor markup % */
    IF @CurPriceBasis = 'VMU' AND @VendorSaleMarkup > 0 and @UnitCost > 0    
    BEGIN
      SET @SalePrice = @UnitCost * (1 + @VendorSaleMarkup / 100)
    END
    ELSE 
	BEGIN
		set @SalePrice = dbo.GetVendorSalePrice_Syteline(@QtyOrdered,@ProductId,@CurrencyCode,@Warehouse,@UnitOfMeasure,@PricingDate)
    END --  Standard vs Vendor MU sales price

    IF @SalePrice > 0 AND @SalePrice < @Price
      SELECT
        @Price = @SalePrice, -- if it's actually less, set it
        @IsSalePrice = 1

  END -- RegularPrice=0

  SELECT * FROM @PriceBreaks

  -- Output parameters do not appear to work if a stored proc returns a result set, so we are just going to return two result sets to get the data back
  SELECT @Price AS Price, @IsSalePrice AS IsSalePrice        

END -- End of procedure

GO
/****** Object:  StoredProcedure [dbo].[PriceCalculator_Visual]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:        Tom Frishberg
-- Create date:   09/23/2011
-- Description:   Visual Price Calculator (from Generic)
--
-- NOTES:  Standard price is in the product record;
--         Customer Discount is applied after other pricing
--         There is no ship-to pricing or discount supported
-- =============================================
CREATE PROCEDURE [dbo].[PriceCalculator_Visual]
  @CustomerId        uniqueidentifier = null,
  @ProductId         uniqueidentifier = null,
  @QtyOrdered        decimal(18,5) = 0,
  @CurrencyCode      nvarchar(50) = '',
  @Warehouse         nvarchar(50) = '',
  @UnitOfMeasure     nvarchar(50) = '',
  @PricingDate       datetime = null,
  @RegularPrice      tinyint = 0,  -- if 1 return price without sale or customer pricing  
  @Price             decimal(18,5) OUTPUT,
  @IsSalePrice       tinyint OUTPUT  -- only valid if ReturnListPrice = 0
AS
BEGIN 

  DECLARE
    @PriceMatrixId      uniqueidentifier,
    @SalePrice          decimal(18,5),
    @SaleStartDate      datetime,
    @SaleEndDate        datetime,
    @BasicListPrice     decimal(18,5),
    @ListPrice          decimal(18,5),
    @UnitCost           decimal(18,5),
    @ProductPriceCode   nvarchar(50),
    @ProductUM          nvarchar(50),
    @ProductVendorId    uniqueidentifier,
    @CustomerPriceCode  nvarchar(50),
    @ParentCustomerId   uniqueidentifier,
    @RecordType         nvarchar(50),
    @CustomerKeyPart    nvarchar(50),
    @ProductKeyPart     nvarchar(50),
    @CalcFlags          nvarchar(50),
    @BrkQty1            decimal(18,5),
    @BrkQty2            decimal(18,5),
    @BrkQty3            decimal(18,5),
    @BrkQty4            decimal(18,5),
    @BrkQty5            decimal(18,5),
    @BrkQty6            decimal(18,5),
    @BrkQty7            decimal(18,5),
    @BrkQty8            decimal(18,5),
    @BrkQty9            decimal(18,5),
    @BrkQty10           decimal(18,5),
    @BrkQty11           decimal(18,5),
    @PriceBasis1        nvarchar(50),
    @PriceBasis2        nvarchar(50),
    @PriceBasis3        nvarchar(50),
    @PriceBasis4        nvarchar(50),
    @PriceBasis5        nvarchar(50),
    @PriceBasis6        nvarchar(50),
    @PriceBasis7        nvarchar(50),
    @PriceBasis8        nvarchar(50),
    @PriceBasis9        nvarchar(50),
    @PriceBasis10       nvarchar(50),
    @PriceBasis11       nvarchar(50),
    @AdjType1           nvarchar(50),
    @AdjType2           nvarchar(50),
    @AdjType3           nvarchar(50),
    @AdjType4           nvarchar(50),
    @AdjType5           nvarchar(50),
    @AdjType6           nvarchar(50),
    @AdjType7           nvarchar(50),
    @AdjType8           nvarchar(50),
    @AdjType9           nvarchar(50),
    @AdjType10          nvarchar(50),
    @AdjType11          nvarchar(50),
    @Amount1            decimal(18,5),
    @Amount2            decimal(18,5),
    @Amount3            decimal(18,5),
    @Amount4            decimal(18,5),
    @Amount5            decimal(18,5),
    @Amount6            decimal(18,5),
    @Amount7            decimal(18,5),
    @Amount8            decimal(18,5),
    @Amount9            decimal(18,5),
    @Amount10           decimal(18,5),
    @Amount11           decimal(18,5),
    @AltAmount1         decimal(18,5),    
    @AltAmount2         decimal(18,5),    
    @AltAmount3         decimal(18,5),    
    @AltAmount4         decimal(18,5),    
    @AltAmount5         decimal(18,5),    
    @AltAmount6         decimal(18,5),    
    @AltAmount7         decimal(18,5),    
    @AltAmount8         decimal(18,5),    
    @AltAmount9         decimal(18,5),    
    @AltAmount10        decimal(18,5),    
    @AltAmount11        decimal(18,5),
    @Loop               int,
    @CurAmount          decimal(18,5),
    @CurAltAmount       decimal(18,5),
    @CurBrkQty          decimal(18,5),
    @CurPriceBasis      nvarchar(50),
    @CurAdjType         nvarchar(50),
    @tmpBasisValue      decimal(18,5),
    @tmpAdjustValue     decimal(18,5),
    @tmpPriceBasis      nvarchar(50),
    @VendorSaleMarkup   decimal(18,5)
    
    -- Visual specific
  DECLARE @CustomerDiscount decimal(18,5)
  DECLARE @CustomerType nvarchar(50)

  DECLARE @PriceBreaks TABLE (BreakQty DECIMAL(18,5), Price DECIMAL(18,5))

  IF @PricingDate IS NULL
    SET @PricingDate = dateadd(dd,0,datediff(dd,0,getdate()))
  SET @IsSalePrice = 0

  /* If they want list price, whack the customer reference */
  IF @RegularPrice <> 0 
    SET @CustomerId = null

  /* First get the product information */
  IF @ProductID IS null
  BEGIN
    print 'Error - no product selected'
    RETURN 99
  END
  
  SELECT 
    @ProductPriceCode = PriceCode,     
    @ProductUM = UnitOfMeasure,
    @UnitCost = Cost,
    @ProductVendorId = VendorId,
    @BasicListPrice = BasicListPrice
  FROM Product (NOLOCK)
  WHERE ProductId = @ProductId


  IF IsNull(@UnitOfMeasure,'') = ''
    SET @UnitOfMeasure = @ProductUM


  /* Get List Price for basis calculations */
  SELECT 
    @ListPrice = @BasicListPrice
    
   
  /* Next get the customer information, if any */
  IF @CustomerId is not null
  BEGIN
    SELECT
      @CustomerPriceCode = PriceCode,
      @CustomerDiscount = ISNULL(Discount,0),
      @CustomerType = CustomerType,
      @ParentCustomerId = ParentId
    FROM Customer (NOLOCK)
    WHERE CustomerId = @CustomerId
    
    IF @ParentCustomerId is not null
    BEGIN
      SELECT
        @CustomerPriceCode = PriceCode,
        @CustomerDiscount = ISNULL(Discount,0),
        @CustomerType = CustomerType,
        @ParentCustomerId = ParentId
      FROM Customer (NOLOCK)
      WHERE CustomerId = @ParentCustomerId
    END    
  END


  /* Now try and find which record will hold the key */
  SET @PriceMatrixId = NULL
  
  /* Customer/Product */
  IF @PriceMatrixId IS NULL AND @CustomerId is not null
  BEGIN
    SELECT @PriceMatrixID = PriceMatrixID
    FROM PriceMatrix (NOLOCK) 
    WHERE
      RecordType = 'Customer/Product' AND
      CurrencyCode = @CurrencyCode AND
      Warehouse = @Warehouse AND
      UnitOfMeasure = @UnitOfMeasure AND
      CustomerKeyPart = @CustomerId AND
      ProductKeyPart = @ProductId AND
      Active <= @PricingDate AND
      (Deactivate IS NULL OR Deactivate > @PricingDate)
  END
   

  /* Customer Price Code/Product - */
  IF @PriceMatrixId IS NULL AND @CustomerId  is not null 
     AND @CustomerPriceCode <> ''
  BEGIN
    SELECT @PriceMatrixID = PriceMatrixID
    FROM PriceMatrix (NOLOCK) 
    WHERE
      RecordType = 'Customer Price Code/Product' AND
      CurrencyCode = @CurrencyCode AND
      Warehouse = @Warehouse AND
      UnitOfMeasure = @UnitOfMeasure AND
      CustomerKeyPart = @CustomerPriceCode AND
      ProductKeyPart = @ProductId AND
      Active <= @PricingDate AND
      (Deactivate IS NULL OR Deactivate > @PricingDate)
  END        

  /* Customer Type/Product - */
  IF @PriceMatrixId IS NULL AND @CustomerId  is not null 
     AND @CustomerType <> ''
  BEGIN
    SELECT @PriceMatrixID = PriceMatrixID
    FROM PriceMatrix (NOLOCK) 
    WHERE
      RecordType = 'Customer Type/Product' AND
      CurrencyCode = @CurrencyCode AND
      Warehouse = @Warehouse AND
      UnitOfMeasure = @UnitOfMeasure AND
      CustomerKeyPart = @CustomerType AND
      ProductKeyPart = @ProductId AND
      Active <= @PricingDate AND
      (Deactivate IS NULL OR Deactivate > @PricingDate)
  END        

  /* Check to see if we have a valid record and read it in */
  IF @PriceMatrixId IS NULL
  BEGIN
    SET @Price = @ListPrice
  END
 

  ELSE BEGIN
    SELECT 
      @RecordType = RecordType,
      @BrkQty1 = BreakQty01,
      @BrkQty2 = BreakQty02,
      @BrkQty3 = BreakQty03,
      @BrkQty4 = BreakQty04,
      @BrkQty5 = BreakQty05,
      @BrkQty6 = BreakQty06,
      @BrkQty7 = BreakQty07,
      @BrkQty8 = BreakQty08,
      @BrkQty9 = BreakQty09,
      @BrkQty10 = BreakQty10,
      @BrkQty11 = BreakQty11,
      @PriceBasis1 = PriceBasis01,
      @PriceBasis2 = PriceBasis02,
      @PriceBasis3 = PriceBasis03,
      @PriceBasis4 = PriceBasis04,
      @PriceBasis5 = PriceBasis05,
      @PriceBasis6 = PriceBasis06,
      @PriceBasis7 = PriceBasis07,
      @PriceBasis8 = PriceBasis08,
      @PriceBasis9 = PriceBasis09,
      @PriceBasis10 = PriceBasis10,
      @PriceBasis11 = PriceBasis11,
      @AdjType1 = AdjustmentType01,
      @AdjType2 = AdjustmentType02,
      @AdjType3 = AdjustmentType03,
      @AdjType4 = AdjustmentType04,
      @AdjType5 = AdjustmentType05,
      @AdjType6 = AdjustmentType06,
      @AdjType7 = AdjustmentType07,
      @AdjType8 = AdjustmentType08,
      @AdjType9 = AdjustmentType09,
      @AdjType10 = AdjustmentType10,
      @AdjType11 = AdjustmentType11,
      @Amount1 = Amount01,
      @Amount2 = Amount02,
      @Amount3 = Amount03,
      @Amount4 = Amount04,
      @Amount5 = Amount05,
      @Amount6 = Amount06,
      @Amount7 = Amount07,
      @Amount8 = Amount08,
      @Amount9 = Amount09,
      @Amount10 = Amount10,
      @Amount11 = Amount11,
      @AltAmount1 = AltAmount01,
      @AltAmount2 = AltAmount02,
      @AltAmount3 = AltAmount03,
      @AltAmount4 = AltAmount04,
      @AltAmount5 = AltAmount05,
      @AltAmount6 = AltAmount06,
      @AltAmount7 = AltAmount07,
      @AltAmount8 = AltAmount08,
      @AltAmount9 = AltAmount09,
      @AltAmount10 = AltAmount10,
      @AltAmount11 = AltAmount11 
    FROM PriceMatrix (NOLOCK)
    WHERE PriceMatrixId = @PriceMatrixId


    /* And now the ugly stuff - traversing through the given record and figuring out price */
    SELECT
      @CurAmount = @Amount1,
      @CurBrkQty = @BrkQty1,
      @CurPriceBasis = @PriceBasis1,
      @CurAdjType = @AdjType1

    IF @QtyOrdered >= @BrkQty2 AND @BrkQty2 > 0
      SELECT
        @CurAmount = @Amount2,
        @CurBrkQty = @BrkQty2,
        @CurPriceBasis = @PriceBasis2,
        @CurAdjType = @AdjType2

    IF @QtyOrdered >= @BrkQty3 AND @BrkQty3 > 0
      SELECT
        @CurAmount = @Amount3,
        @CurBrkQty = @BrkQty3,
        @CurPriceBasis = @PriceBasis3,
        @CurAdjType = @AdjType3

    IF @QtyOrdered >= @BrkQty4 AND @BrkQty4 > 0
      SELECT
        @CurAmount = @Amount4,
        @CurBrkQty = @BrkQty4,
        @CurPriceBasis = @PriceBasis4,
        @CurAdjType = @AdjType4

    IF @QtyOrdered >= @BrkQty5 AND @BrkQty5 > 0
      SELECT
        @CurAmount = @Amount5,
        @CurBrkQty = @BrkQty5,
        @CurPriceBasis = @PriceBasis5,
        @CurAdjType = @AdjType5

    IF @QtyOrdered >= @BrkQty6 AND @BrkQty6 > 0
      SELECT
        @CurAmount = @Amount6,
        @CurBrkQty = @BrkQty6,
        @CurPriceBasis = @PriceBasis6,
        @CurAdjType = @AdjType6

    IF @QtyOrdered >= @BrkQty7 AND @BrkQty7 > 0
      SELECT
        @CurAmount = @Amount7,
        @CurBrkQty = @BrkQty7,
        @CurPriceBasis = @PriceBasis7,
        @CurAdjType = @AdjType7

    IF @QtyOrdered >= @BrkQty8 AND @BrkQty8 > 0
      SELECT
        @CurAmount = @Amount8,
        @CurBrkQty = @BrkQty8,
        @CurPriceBasis = @PriceBasis8,
        @CurAdjType = @AdjType8

    IF @QtyOrdered >= @BrkQty9 AND @BrkQty9 > 0
      SELECT
        @CurAmount = @Amount9,
        @CurBrkQty = @BrkQty9,
        @CurPriceBasis = @PriceBasis9,
        @CurAdjType = @AdjType9

    IF @QtyOrdered >= @BrkQty10 AND @BrkQty10 > 0
      SELECT
        @CurAmount = @Amount10,
        @CurBrkQty = @BrkQty10,
        @CurPriceBasis = @PriceBasis10,
        @CurAdjType = @AdjType10

    IF @QtyOrdered >= @BrkQty11 AND @BrkQty11 > 0
      SELECT
        @CurAmount = @Amount11,
        @CurBrkQty = @BrkQty11,
        @CurPriceBasis = @PriceBasis11,
        @CurAdjType = @AdjType11


    /* Set price basis level */
    SET @tmpBasisValue = 0
    IF @CurPriceBasis = 'C' SET @tmpBasisValue = @UnitCost
    IF @CurPriceBasis = 'M' SET @tmpBasisValue = @UnitCost -- margin
    IF @CurPriceBasis = 'MU' SET @tmpBasisValue = @UnitCost -- markup (mu/vmu)
    IF @CurPriceBasis = 'L' SET @tmpBasisValue = @ListPrice


    /* Calculate actual price based on current break */
    
    /* Override Price */
    IF @CurPriceBasis = 'O' AND @CurAdjType = 'A'
      SET @Price = @CurAmount

    /* Non-derived-Based types - always adds */
    IF @CurPriceBasis IN ('C','MU','L')
    BEGIN
      IF @CurAdjType = 'A'
        SET @Price = @tmpBasisValue + @CurAmount
      IF @CurAdjType = 'P'
        SET @Price = @tmpBasisValue * (1 + @CurAmount / 100)
              
    END -- non-derived

    /* Margin */
    IF @CurPriceBasis = 'M'
    BEGIN
      IF @CurAdjType = 'A'
        SET @Price = @CurAmount + @tmpBasisValue
      IF @CurAdjType = 'P'
        SET @Price = @tmpBasisValue / (1 - @CurAmount / 100) 
    END

  END -- Price Matrix record found


  -- Now go for Sale Price - assumed to be all price overrides
  IF @RegularPrice = 0
  BEGIN
    
    /* Special case - vendor markup % */
    IF @CurPriceBasis = 'VMU' AND @VendorSaleMarkup > 0 and @UnitCost > 0    
    BEGIN
      SET @SalePrice = @UnitCost * (1 + @VendorSaleMarkup / 100)
    END

    ELSE BEGIN
      SET @PriceMatrixId = NULL
      SET @SalePrice = 0
      SELECT 
        @PriceMatrixId = PriceMatrixId,
        @BrkQty1 = BreakQty01,
        @BrkQty2 = BreakQty02,
        @BrkQty3 = BreakQty03,
        @BrkQty4 = BreakQty04,
        @BrkQty5 = BreakQty05,
        @BrkQty6 = BreakQty06,
        @BrkQty7 = BreakQty07,
        @BrkQty8 = BreakQty08,
        @BrkQty9 = BreakQty09,
        @BrkQty10 = BreakQty10,
        @BrkQty11 = BreakQty11,
        @Amount1 = Amount01,
        @Amount2 = Amount02,
        @Amount3 = Amount03,
        @Amount4 = Amount04,
        @Amount5 = Amount05,
        @Amount6 = Amount06,
        @Amount7 = Amount07,
        @Amount8 = Amount08,
        @Amount9 = Amount09,
        @Amount10 = Amount10,
        @Amount11 = Amount11
      FROM PriceMatrix (NOLOCK) 
      WHERE
        RecordType = 'Product Sale' AND
        CurrencyCode = @CurrencyCode AND
        Warehouse = @Warehouse AND
        UnitOfMeasure = @UnitOfMeasure AND
        CustomerKeyPart = '' AND
        ProductKeyPart = @ProductId AND
        Active <= @PricingDate AND
        (Deactivate IS NULL OR Deactivate > @PricingDate)

      IF @PriceMatrixId IS NOT NULL
      BEGIN
        IF @QtyOrdered >= @BrkQty1                    SET @SalePrice = @Amount1
        IF @QtyOrdered >= @BrkQty2  AND @BrkQty2  > 0 SET @SalePrice = @Amount2
        IF @QtyOrdered >= @BrkQty3  AND @BrkQty3  > 0 SET @SalePrice = @Amount3
        IF @QtyOrdered >= @BrkQty4  AND @BrkQty4  > 0 SET @SalePrice = @Amount4
        IF @QtyOrdered >= @BrkQty5  AND @BrkQty5  > 0 SET @SalePrice = @Amount5
        IF @QtyOrdered >= @BrkQty6  AND @BrkQty6  > 0 SET @SalePrice = @Amount6
        IF @QtyOrdered >= @BrkQty7  AND @BrkQty7  > 0 SET @SalePrice = @Amount7
        IF @QtyOrdered >= @BrkQty8  AND @BrkQty8  > 0 SET @SalePrice = @Amount8
        IF @QtyOrdered >= @BrkQty9  AND @BrkQty9  > 0 SET @SalePrice = @Amount9
        IF @QtyOrdered >= @BrkQty10 AND @BrkQty10 > 0 SET @SalePrice = @Amount10
        IF @QtyOrdered >= @BrkQty11 AND @BrkQty11 > 0 SET @SalePrice = @Amount11    
      
		-- Capture Price Breaks
		DELETE FROM @PriceBreaks
		INSERT INTO @PriceBreaks SELECT @BrkQty1, @Amount1
		IF @BrkQty2 > 0 AND @Amount2 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty2, @Amount2
		IF @BrkQty3 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty3, @Amount3
		IF @BrkQty4 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty4, @Amount4
		IF @BrkQty5 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty5, @Amount5
		IF @BrkQty6 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty6, @Amount6
		IF @BrkQty7 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty7, @Amount7
		IF @BrkQty8 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty8, @Amount8
		IF @BrkQty9 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty9, @Amount9
		IF @BrkQty10 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty10, @Amount10
		IF @BrkQty11 > 0 INSERT INTO @PriceBreaks SELECT @BrkQty11, @Amount11
	  END
    END --  Standard vs Vendor MU sales price

    -- Check for 0 pricing
    SET @Price = ISNULL(@Price,0)
    IF @Price <= 0 SET @Price = ISNULL(@ListPrice,0)
    IF @Price <= 0 SET @Price = ISNULL(@BasicListPrice,0)

    IF @SalePrice > 0 AND @SalePrice < @Price
      SELECT
        @Price = @SalePrice, -- if it's actually less, set it
        @IsSalePrice = 1

  END -- RegularPrice=0
  
  ELSE BEGIN
    -- Check for 0 pricing
    SET @Price = ISNULL(@Price,0)
    IF @Price <= 0 SET @Price = ISNULL(@ListPrice,0)
    IF @Price <= 0 SET @Price = ISNULL(@BasicListPrice,0)
  END  
  
   -- Apply customer discount next
  SET @CustomerDiscount = ISNULL(@CustomerDiscount,0)
  SET @Price = @Price * (1 - @CustomerDiscount / 100)
  
  IF @SalePrice > 0 AND @SalePrice < @Price AND
    @SaleStartDate <= @PricingDate AND (@SaleEndDate IS NULL OR @SaleEndDate >= @PricingDate)
    BEGIN
      SELECT
        @Price = @SalePrice, -- ifit's actually less, set it
        @IsSalePrice = 1
    END
 
  SELECT * FROM @PriceBreaks

  -- Output parameters do not appear to work if a stored proc returns a result set, so we are just going to return two result sets to get the data back
  SELECT @Price AS Price, @IsSalePrice AS IsSalePrice                

END -- End of procedure

GO
/****** Object:  StoredProcedure [dbo].[RefreshAndRollupInventory]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RefreshAndRollupInventory] 
  @XMLString NVARCHAR(MAX) = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE 
		@XMLHandle XML,
		@ERPNumber NVARCHAR(100),
        @QtyAvailable DECIMAL(19,5),
        @Warehouse NVARCHAR(100),
        @QtyOnHand DECIMAL(19,5),
		@ProductId UNIQUEIDENTIFIER,
		@RetentionWindow INT,
		@RetentionDate DATETIME

	DECLARE @InventoryData TABLE
    (
		ERPNumber NVARCHAR(100),
        QtyAvailable DECIMAL(19,5),
        Warehouse NVARCHAR(100)
    )

	/* XML DataSet was sent in to Refresh Inventory balance */
	IF NOT @XMLString IS NULL
	BEGIN
		SET @XMLHandle = @XMLString 

		INSERT INTO @InventoryData
		SELECT
			I.value('ERPNUMBER[1]', 'NVARCHAR(100)') ERPNumber,
			I.value('QTYAVAILABLE[1]', 'DECIMAL(19,5)') QtyAvailable,
			I.value('WAREHOUSE[1]', 'NVARCHAR(100)') Warehouse
		FROM
			@XMLHandle.nodes('/NewDataSet/Inventory') AS Inventory(I)

		DECLARE InventoryDataCursor CURSOR FOR SELECT * FROM @InventoryData	
		OPEN InventoryDataCursor
		WHILE 1 = 1
		BEGIN
			FETCH NEXT FROM InventoryDataCursor INTO @ERPNumber, @QtyAvailable, @Warehouse
			IF @@FETCH_STATUS <> 0
				BREAK
			SET @ProductId = NULL
			SELECT @ProductId = p.ProductId FROM Product p WHERE ERPNumber = @ERPNumber AND TrackInventory = 1
			IF NOT @ProductId IS NULL
			BEGIN
				SELECT @QtyOnHand = ISNULL(SUM(Amount),0) FROM InventoryTransaction it WHERE it.ProductId = @ProductId
				IF @QtyOnHand <> @QtyAvailable
					INSERT INTO InventoryTransaction (ProductId, Description, Amount) VALUES (@ProductId, 'ERP Reconciliation', @QtyAvailable - @QtyOnHand)
			END
		END
		CLOSE InventoryDataCursor
		DEALLOCATE InventoryDataCursor
	END

	-- Rollup Inventory Transaction Records
	IF NOT EXISTS(SELECT 1 FROM ApplicationSetting WHERE Name = 'InventoryTransactionRetentionDays')
		INSERT INTO ApplicationSetting (Name, Value) VALUES ('InventoryTransactionRetentionDays', '14')

	SELECT @RetentionWindow = CAST(Value AS INT) FROM ApplicationSetting WHERE Name = 'InventoryTransactionRetentionDays'
	IF @RetentionWindow > 0
	BEGIN
		SET @RetentionWindow = -1 * @RetentionWindow
		SET @RetentionDate = DATEADD(day, @RetentionWindow, GETDATE())
		DECLARE ProductCursor CURSOR LOCAL STATIC READ_ONLY FOR SELECT ProductId FROM Product
		OPEN ProductCursor
		WHILE 1 = 1
		BEGIN
			FETCH NEXT FROM ProductCursor INTO @ProductId
			IF @@FETCH_STATUS <> 0
				BREAK
			SET @QtyOnHand = NULL
			SELECT @QtyOnHand = SUM(Amount) FROM InventoryTransaction it WHERE it.ProductId = @ProductId AND it.TransactionDate < @RetentionDate
			IF NOT @QtyOnHand IS NULL
			BEGIN
				BEGIN TRANSACTION
					DELETE it FROM InventoryTransaction it WHERE it.ProductId = @ProductId AND it.TransactionDate < @RetentionDate
					INSERT INTO InventoryTransaction (ProductId, TransactionDate, Description, Amount) VALUES (@ProductId, @RetentionDate, 'Rollup', @QtyOnHand)
				COMMIT TRANSACTION
			END
		END
		CLOSE ProductCursor
		DEALLOCATE ProductCursor
	END

END
GO
/****** Object:  StoredProcedure [dbo].[RefreshInventory]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Darwin Zins
-- Create date: 2/12/2009
-- Description:	Stored Procedure that accepts DataSet and Refreshes and Rolls up Inventory
-- =============================================
CREATE PROCEDURE [dbo].[RefreshInventory] 
  @XMLString NVARCHAR(MAX) = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE 
		@XMLHandle INT,
		@ERPNumber NVARCHAR(100),
        @QtyAvailable DECIMAL(19,5),
        @Warehouse NVARCHAR(100),
        @QtyOnHand DECIMAL(19,5),
		@ProductId UNIQUEIDENTIFIER,
		@RetentionWindow INT,
		@RetentionDate DATETIME

	DECLARE @InventoryData TABLE
    (
		ERPNumber NVARCHAR(100),
        QtyAvailable DECIMAL(19,5),
        Warehouse NVARCHAR(100)
    )

	/* XML DataSet was sent in to Refresh Inventory balance */
	IF NOT @XMLString IS NULL
	BEGIN
		EXEC sp_xml_preparedocument @XMLHandle output, @XMLString 

		INSERT INTO @InventoryData
		SELECT
			ERPNumber,
			QtyAvailable,
			Warehouse 
		FROM OPENXML (@XMLHandle, '/NewDataSet/Inventory',1) 
			WITH 
			(
				ERPNumber    NVARCHAR(100) 'ERPNUMBER', 
				QtyAvailable DECIMAL(19,5) 'QTYAVAILABLE', 
				Warehouse    NVARCHAR(100) 'WAREHOUSE'
			)

		DECLARE InventoryDataCursor CURSOR FOR SELECT * FROM @InventoryData	
		OPEN InventoryDataCursor
		WHILE 1 = 1
		BEGIN
			FETCH NEXT FROM InventoryDataCursor INTO @ERPNumber, @QtyAvailable, @Warehouse
			IF @@FETCH_STATUS <> 0
				BREAK
			SET @ProductId = NULL
			SELECT @ProductId = p.ProductId FROM Product p WHERE ERPNumber = @ERPNumber AND TrackInventory = 1
			IF NOT @ProductId IS NULL
			BEGIN
				SELECT @QtyOnHand = ISNULL(SUM(Amount),0) FROM InventoryTransaction it WHERE it.ProductId = @ProductId
				IF @QtyOnHand <> @QtyAvailable
					INSERT INTO InventoryTransaction (ProductId, Description, Amount) VALUES (@ProductId, 'ERP Reconciliation', @QtyAvailable - @QtyOnHand)
			END
		END
		CLOSE InventoryDataCursor
		DEALLOCATE InventoryDataCursor

		EXEC sp_xml_removedocument @XMLHandle
	END

END

GO
/****** Object:  StoredProcedure [dbo].[RefreshPricing_Epicor9Vantage]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Darwin Zins
-- Create date: 6/13/2011
-- Description:	Stored Procedure that accepts DataSet and Refreshes Pricing for Epicor 9 and Vantage
-- =============================================
CREATE PROCEDURE [dbo].[RefreshPricing_Epicor9Vantage] 
  @XMLString NVARCHAR(MAX) = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE 
		@XMLHandle INT,
		@RecordType NVARCHAR(50),
		@CustNum NVARCHAR(50),
		@ShipToNum NVARCHAR(50),
		@PartNum NVARCHAR(50),
		@CustomerKeyPart NVARCHAR(50),
		@ProductKeyPart NVARCHAR(50),
		@CurrencyCode NVARCHAR(50),
		@Warehouse NVARCHAR(50),
		@UnitOfMeasure NVARCHAR(50),
		@PriceBasis NVARCHAR(50),
		@AdjustmentType NVARCHAR(50),
		@BreakQty DECIMAL(18,5),
		@Amount DECIMAL(18,5),
		@AltAmount DECIMAL(18,5),
		@Active DATETIME,
		@Deactivate DATETIME,

		@NewCustomerKeyPart NVARCHAR(50),
		@NewProductKeyPart NVARCHAR(50),
		@NewActive DATETIME,

		@BrkPriceBasis NVARCHAR(50),
		@BrkAdjustmentType NVARCHAR(50),
		@BrkBreakQty DECIMAL(18,5),
		@BrkAmount DECIMAL(18,5),
		@BrkQtyCounter INT,
		@BrkQtyCounterStr NVARCHAR(2),
		
		@PriceMatrixId UNIQUEIDENTIFIER,
		@SqlString NVARCHAR(500),
		@ParamDefinition NVARCHAR(500),
		
		@RunDateTime DATETIME,
		
		@RecordCount INT,
		@RecordPageSize INT
		
	SET @RunDateTime = CONVERT(nvarchar(20), GETDATE(), 101)
		
	SET @ParamDefinition = 
		'@InBrkPriceBasis NVARCHAR(50),
		@InBrkAdjustmentType NVARCHAR(50),
		@InBrkBreakQty DECIMAL(18,5),
		@InBrkAmount DECIMAL(18,5),
		@InPriceMatrixId UNIQUEIDENTIFIER'
	
    INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
        VALUES (0, 'INFO', 'RefreshPricing_Epicor9Vantage', 'Start reading XML data')

	IF NOT @XMLString IS NULL
	BEGIN
		EXEC sp_xml_preparedocument @XMLHandle output, @XMLString 

		TRUNCATE TABLE tmp_PriceData

		INSERT INTO tmp_PriceData (RecordType, CustNum, ShipToNum, PartNum, CustomerKeyPart, ProductKeyPart, CurrencyCode, Warehouse, UnitOfMeasure, PriceBasis, AdjustmentType, BreakQty, Amount, AltAmount, Active, Deactivate)
		SELECT
		RecordType, CustNum, ShipToNum,PartNum, CustomerKeyPart, ProductKeyPart ,CurrencyCode, Warehouse, UnitOfMeasure , PriceBasis , AdjustmentType ,BreakQty, Amount, AltAmount,	 cast(left(Active,10)+' '+right(left(Active,19),8) as nvarchar(100)) , cast(left(Deactivate,10)+' '+right(left(Deactivate,19),8) as nvarchar(100)) 
		FROM OPENXML (@XMLHandle, '/Pricing/PriceMatrix',1) 
			WITH 
			(
				RecordType NVARCHAR(50) 'RecordType',
				CustNum NVARCHAR(50) 'CustNum',
				ShipToNum NVARCHAR(50) 'ShipToNum',
				PartNum NVARCHAR(50) 'PartNum',
				CustomerKeyPart NVARCHAR(50) 'CustomerKeyPart',
				ProductKeyPart NVARCHAR(50) 'ProductKeyPart',
				CurrencyCode NVARCHAR(50) 'CurrencyCode',
				Warehouse NVARCHAR(50) 'Warehouse',
				UnitOfMeasure NVARCHAR(50) 'UnitOfMeasure',
				PriceBasis NVARCHAR(50) 'PriceBasis',
				AdjustmentType NVARCHAR(50) 'AdjustmentType',
				BreakQty DECIMAL(18,5) 'BreakQty',
				Amount DECIMAL(18,5) 'Amount',
				AltAmount DECIMAL(18,5) 'AltAmount',
				Active NVARCHAR(100) 'Active',
				Deactivate NVARCHAR(100) 'Deactivate'
			)

		TRUNCATE TABLE PriceMatrix_Batch

		INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
			VALUES (0, 'INFO', 'RefreshPricing_Epicor9Vantage', 'Finished reading XML data')

		SET @RecordCount = 0
		SET @RecordPageSize = 1000
		BEGIN TRANSACTION
		
		DECLARE PriceMatrixDataCursor CURSOR LOCAL STATIC READ_ONLY FOR SELECT RecordType, CustNum, ShipToNum, PartNum, CustomerKeyPart, ProductKeyPart, CurrencyCode, Warehouse, UnitOfMeasure, PriceBasis, AdjustmentType, BreakQty, Amount, AltAmount, Active, Deactivate 
		FROM tmp_PriceData	
		OPEN PriceMatrixDataCursor
		WHILE 1 = 1
		BEGIN
			FETCH NEXT FROM PriceMatrixDataCursor INTO 
				@RecordType,
				@CustNum,
				@ShipToNum,
				@PartNum,
				@CustomerKeyPart,
				@ProductKeyPart,
				@CurrencyCode,
				@Warehouse,
				@UnitOfMeasure,
				@PriceBasis,
				@AdjustmentType,
				@BreakQty,
				@Amount,
				@AltAmount,
				@Active,
				@Deactivate
			IF @@FETCH_STATUS <> 0
				BREAK

			IF @RecordType <> 'Price List Product Group' AND @BreakQty > 0
				CONTINUE
			
			SELECT 
				@NewCustomerKeyPart = @CustomerKeyPart, 
				@NewProductKeyPart = @ProductKeyPart,
				@NewActive = ISNULL(@Active,@RunDateTime),
				@Deactivate = ISNULL(@Deactivate,'2059-12-31')
				
			IF @RecordType = 'Customer Price List'
			BEGIN
				SELECT @NewCustomerKeyPart = CustomerId FROM Customer WHERE ERPNumber = @CustNum AND CustomerSequence = @ShipToNum
				IF @NewCustomerKeyPart IS NULL -- Possibly not a WebCustomer?
					CONTINUE
			END
			
			IF @RecordType = 'Price List Product'
			BEGIN
				SELECT @NewProductKeyPart = ProductId FROM Product WHERE ERPNumber = @PartNum
				IF @NewProductKeyPart IS NULL -- Possibly not a WebPart?
					CONTINUE
			END

			SELECT
				@NewCustomerKeyPart = ISNULL(@NewCustomerKeyPart,''),
				@NewProductKeyPart = ISNULL(@NewProductKeyPart,''),
				@CurrencyCode = ISNULL(@CurrencyCode,''),
				@Warehouse = ISNULL(@Warehouse,''),
				@UnitOfMeasure = ISNULL(@UnitOfMeasure,''),
				@PriceBasis = ISNULL(@PriceBasis,''),
				@AltAmount = ISNULL(@AltAmount,0)
			
			IF NOT EXISTS(SELECT 1 FROM PriceMatrix_Batch WHERE
				RecordType = @RecordType AND 
				CustomerKeyPart = @NewCustomerKeyPart AND 
				ProductKeyPart = @NewProductKeyPart AND
				CurrencyCode = @CurrencyCode AND
				Warehouse = @Warehouse AND
				UnitOfMeasure = @UnitOfMeasure AND
				Active = @NewActive AND
				Deactivate = @Deactivate)
			BEGIN
				INSERT INTO PriceMatrix_Batch (
					RecordType, 
					CustomerKeyPart, 
					ProductKeyPart,
					CurrencyCode,
					Warehouse,
					UnitOfMeasure,
					PriceBasis01,
					AltAmount01, 
					Active,
					Deactivate
				) VALUES (
					@RecordType,
					@NewCustomerKeyPart,
					@NewProductKeyPart,
					@CurrencyCode,
					@Warehouse,
					@UnitOfMeasure,
					@PriceBasis,
					@AltAmount,
					@NewActive,
					@Deactivate
				)
				
				SET @RecordCount = @RecordCount + 1
				IF @RecordCount % @RecordPageSize = 0
				BEGIN
					COMMIT TRANSACTION

					INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
						VALUES (0, 'INFO', 'RefreshPricing_Epicor9Vantage', 'Processing record ' + CAST(@RecordCount AS NVARCHAR(50)))

					BEGIN TRANSACTION	
				END
			END

			-- Do Break Qtys			
			IF @RecordType = 'Price List Product Group' OR @RecordType = 'Price List Product'
			BEGIN
				SELECT @PriceMatrixId = PriceMatrixId FROM PriceMatrix_Batch WHERE
					RecordType = @RecordType AND 
					CustomerKeyPart = @NewCustomerKeyPart AND 
					ProductKeyPart = @NewProductKeyPart AND
					CurrencyCode = @CurrencyCode AND
					Warehouse = @Warehouse AND
					UnitOfMeasure = @UnitOfMeasure AND
					Active = @NewActive AND
					Deactivate = @Deactivate
				SET @BrkQtyCounter = 1
				DECLARE BrkPriceMatrixDataCursor CURSOR LOCAL STATIC READ_ONLY FOR SELECT 
					PriceBasis, 
					AdjustmentType, 
					BreakQty, 
					Amount 
				FROM tmp_PriceData WHERE 
					RecordType = @RecordType AND 
					CustomerKeyPart = @CustomerKeyPart AND
					ISNULL(ProductKeyPart,'') = ISNULL(@ProductKeyPart,'') AND
					ISNULL(PartNum,'') = ISNULL(@PartNum,'') AND
					CurrencyCode = @CurrencyCode AND
					Warehouse = @Warehouse AND
					UnitOfMeasure = @UnitOfMeasure AND
					BreakQty > 0
				ORDER BY BreakQty
				OPEN BrkPriceMatrixDataCursor
				WHILE 1 = 1
				BEGIN
					FETCH NEXT FROM BrkPriceMatrixDataCursor INTO 
						@BrkPriceBasis,
						@BrkAdjustmentType,
						@BrkBreakQty,
						@BrkAmount
					IF @@FETCH_STATUS <> 0
						BREAK
						
					SET @BrkQtyCounterStr = CAST(@BrkQtyCounter AS NVARCHAR(2))
					
					IF @BrkQtyCounter < 10
						SET @SqlString = 'UPDATE PriceMatrix_Batch SET 
							PriceBasis0' + @BrkQtyCounterStr + ' = @InBrkPriceBasis,
							AdjustmentType0' + @BrkQtyCounterStr + ' = @InBrkAdjustmentType,
							BreakQty0' + @BrkQtyCounterStr + ' = @InBrkBreakQty,
							Amount0' + @BrkQtyCounterStr + ' = @InBrkAmount
						WHERE PriceMatrixId = @InPriceMatrixId'
					ELSE IF @BrkQtyCounter < 12 -- We Only Support up to 11 Break Qty
						SET @SqlString = 'UPDATE PriceMatrix_Batch SET 
							PriceBasis' + @BrkQtyCounterStr + ' = @InBrkPriceBasis,
							AdjustmentType' + @BrkQtyCounterStr + ' = @InBrkAdjustmentType,
							BreakQty' + @BrkQtyCounterStr + ' = @InBrkBreakQty,
							Amount' + @BrkQtyCounterStr + ' = @InBrkAmount
						WHERE PriceMatrixId = @InPriceMatrixId'
					ELSE
						CONTINUE

					EXEC sp_executesql @SqlString, @ParamDefinition, 
						@InBrkPriceBasis = @BrkPriceBasis, 
						@InBrkAdjustmentType = @BrkAdjustmentType, 
						@InBrkBreakQty = @BrkBreakQty, 
						@InBrkAmount = @BrkAmount, 
						@InPriceMatrixId = @PriceMatrixId
						
					SET @RecordCount = @RecordCount + 1
					IF @RecordCount % @RecordPageSize = 0
					BEGIN
						COMMIT TRANSACTION

						INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
							VALUES (0, 'INFO', 'RefreshPricing_Epicor9Vantage', 'Processing record ' + CAST(@RecordCount AS NVARCHAR(50)))

						BEGIN TRANSACTION				
					END
					
					SET @BrkQtyCounter = @BrkQtyCounter + 1
				END
				CLOSE BrkPriceMatrixDataCursor
				DEALLOCATE BrkPriceMatrixDataCursor
			END
			
		END
		IF @@TRANCOUNT > 0
			COMMIT TRANSACTION
			
		CLOSE PriceMatrixDataCursor
		DEALLOCATE PriceMatrixDataCursor

		EXEC sp_xml_removedocument @XMLHandle

		INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
			VALUES (0, 'INFO', 'RefreshPricing_Epicor9Vantage', 'Finished Processing, total records processed ' + CAST(@RecordCount AS NVARCHAR(50)) + ' copying from PriceMatrix_Batch to PriceMatrix')


		BEGIN TRANSACTION
		TRUNCATE TABLE PriceMatrix
		INSERT INTO PriceMatrix SELECT * FROM PriceMatrix_Batch
		COMMIT TRANSACTION

		INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
			VALUES (0, 'INFO', 'RefreshPricing_Epicor9Vantage', 'Finished')

	END

END

GO
/****** Object:  StoredProcedure [dbo].[RefreshPricing_Visual]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:        Patrick Nigon
-- Create date: 10/03/2011
-- Description:   Stored Procedure that accepts DataSet and Refreshes Pricing for Visual
-- Modified 12/19/11, tjf, Handle multiple currencies; change default warehouse to ERP_Warehouse
-- =============================================
CREATE PROCEDURE [dbo].[RefreshPricing_Visual]
@XMLString NVARCHAR(MAX) = NULL
AS
BEGIN
	  
	  -- set nocount on added to prevent extra result sets from interfering with select statements
	  SET NOCOUNT ON;
	  
	  DECLARE
			-- handle to xml doc after loaded into memory
			@XMLHandle INT

			
			-- variables for xml elements
			,@CustNum NVARCHAR(50)
			,@EffectiveDate DATETIME
			,@DiscontinueDate DATETIME
			,@PriceCode NVARCHAR(50)
			,@CustType NVARCHAR(50)
			,@RecordType NVARCHAR(50)
			,@ProdName NVARCHAR(50)
			,@UnitOfMeasure NVARCHAR(50)
			,@CurrencyCode NVARCHAR(50)
			,@UnitPrice DECIMAL(18,5)
			,@BreakQty02 DECIMAL(18,5) 
			,@BreakQty03 DECIMAL(18,5) 
			,@BreakQty04 DECIMAL(18,5) 
			,@BreakQty05 DECIMAL(18,5) 
			,@BreakQty06 DECIMAL(18,5) 
			,@BreakQty07 DECIMAL(18,5) 
			,@BreakQty08 DECIMAL(18,5) 
			,@BreakQty09 DECIMAL(18,5) 
			,@BreakQty10 DECIMAL(18,5) 
			,@BreakQty11 DECIMAL(18,5) 
			,@Amount02 DECIMAL(18,5) 
			,@Amount03 DECIMAL(18,5) 
			,@Amount04 DECIMAL(18,5) 
			,@Amount05 DECIMAL(18,5) 
			,@Amount06 DECIMAL(18,5) 
			,@Amount07 DECIMAL(18,5) 
			,@Amount08 DECIMAL(18,5) 
			,@Amount09 DECIMAL(18,5) 
			,@Amount10 DECIMAL(18,5) 
			,@Amount11 DECIMAL(18,5) 
			,@PriceBasis01 NVARCHAR(50) 
			,@PriceBasis02 NVARCHAR(50) 
			,@PriceBasis03 NVARCHAR(50) 
			,@PriceBasis04 NVARCHAR(50) 
			,@PriceBasis05 NVARCHAR(50) 
			,@PriceBasis06 NVARCHAR(50) 
			,@PriceBasis07 NVARCHAR(50) 
			,@PriceBasis08 NVARCHAR(50) 
			,@PriceBasis09 NVARCHAR(50) 
			,@PriceBasis10 NVARCHAR(50) 
			,@PriceBasis11 NVARCHAR(50) 
			,@AdjustmentType01 NVARCHAR(50)
			,@AdjustmentType02 NVARCHAR(50)
			,@AdjustmentType03 NVARCHAR(50)
			,@AdjustmentType04 NVARCHAR(50)
			,@AdjustmentType05 NVARCHAR(50)
			,@AdjustmentType06 NVARCHAR(50)
			,@AdjustmentType07 NVARCHAR(50)
			,@AdjustmentType08 NVARCHAR(50)
			,@AdjustmentType09 NVARCHAR(50)
			,@AdjustmentType10 NVARCHAR(50)
			,@AdjustmentType11 NVARCHAR(50)
			
			-- variables for app settings
			,@ERP_Warehouse NVARCHAR(MAX)
			,@ERP_DefaultCurrencyCode NVARCHAR(MAX)
			
			-- variables to be used in cursor
			,@CustomerId UNIQUEIDENTIFIER
			,@ProductId UNIQUEIDENTIFIER
			,@RunDateTime DATETIME
			
			,@RecordCount INT
			,@RecordPageSize INT
		
		SET @RunDateTime = CONVERT(nvarchar(20), GetDate(), 101)
		
		-- table to temporarily hold price matrix data
		CREATE TABLE #PriceMatrixData
		(
			  CustNum NVARCHAR(50)
			  ,EffectiveDate DATETIME
			  ,DiscontinueDate DATETIME
			  ,PriceCode NVARCHAR(50)
			  ,CustType NVARCHAR(50)
			  ,RecordType NVARCHAR(50)
			  ,ProdName NVARCHAR(50)
			  ,UnitOfMeasure NVARCHAR(50)
			  ,CurrencyCode NVARCHAR(50)
			  ,UnitPrice DECIMAL(18,5)
			  ,BreakQty02 DECIMAL(18,5) 
			  ,BreakQty03 DECIMAL(18,5) 
			  ,BreakQty04 DECIMAL(18,5) 
			  ,BreakQty05 DECIMAL(18,5) 
			  ,BreakQty06 DECIMAL(18,5) 
			  ,BreakQty07 DECIMAL(18,5) 
			  ,BreakQty08 DECIMAL(18,5) 
			  ,BreakQty09 DECIMAL(18,5) 
			  ,BreakQty10 DECIMAL(18,5) 
			  ,BreakQty11 DECIMAL(18,5) 
			  ,Amount02 DECIMAL(18,5) 
			  ,Amount03 DECIMAL(18,5) 
			  ,Amount04 DECIMAL(18,5) 
			  ,Amount05 DECIMAL(18,5) 
			  ,Amount06 DECIMAL(18,5) 
			  ,Amount07 DECIMAL(18,5) 
			  ,Amount08 DECIMAL(18,5) 
			  ,Amount09 DECIMAL(18,5) 
			  ,Amount10 DECIMAL(18,5) 
			  ,Amount11 DECIMAL(18,5) 
			  ,PriceBasis01 NVARCHAR(50) 
			  ,PriceBasis02 NVARCHAR(50) 
			  ,PriceBasis03 NVARCHAR(50) 
			  ,PriceBasis04 NVARCHAR(50) 
			  ,PriceBasis05 NVARCHAR(50) 
			  ,PriceBasis06 NVARCHAR(50) 
			  ,PriceBasis07 NVARCHAR(50) 
			  ,PriceBasis08 NVARCHAR(50) 
			  ,PriceBasis09 NVARCHAR(50) 
			  ,PriceBasis10 NVARCHAR(50) 
			  ,PriceBasis11 NVARCHAR(50) 
			  ,AdjustmentType01 NVARCHAR(50)
			  ,AdjustmentType02 NVARCHAR(50)
			  ,AdjustmentType03 NVARCHAR(50)
			  ,AdjustmentType04 NVARCHAR(50)
			  ,AdjustmentType05 NVARCHAR(50)
			  ,AdjustmentType06 NVARCHAR(50)
			  ,AdjustmentType07 NVARCHAR(50)
			  ,AdjustmentType08 NVARCHAR(50)
			  ,AdjustmentType09 NVARCHAR(50)
			  ,AdjustmentType10 NVARCHAR(50)
			  ,AdjustmentType11 NVARCHAR(50)
		)
		
		CREATE INDEX ix_PriceMatrixData_CustNum ON #PriceMatrixData (CustNum)
		CREATE INDEX ix_PriceMatrixData_ProdName ON #PriceMatrixData (ProdName)
		CREATE INDEX ix_PriceMatrixData_RecordType ON #PriceMatrixData (RecordType)
		
		INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
			VALUES (0, 'INFO', 'RefreshPricing_Visual', 'Start reading XML data')

		IF NOT @XMLString IS NULL
		BEGIN
			  -- get the app settings
			  SELECT @ERP_DefaultCurrencyCode = Value FROM ApplicationSetting WHERE Name = 'ERP_DefaultCurrencyCode'
			  IF @ERP_DefaultCurrencyCode IS NULL
					SET @ERP_DefaultCurrencyCode = 'USD'
			  
			  SELECT @ERP_Warehouse = Value FROM ApplicationSetting WHERE Name = 'ERP_Warehouse'
			  IF @ERP_Warehouse IS NULL
					SET @ERP_Warehouse = 'unknown'
					
			  -- parse the xml doc
			  EXEC sp_xml_preparedocument @XMLHandle output, @XMLString
			  
			  -- get xml data into temporary table
			  INSERT INTO #PriceMatrixData
					SELECT
						  CustNum
						  ,EffectiveDate
						  ,DiscontinueDate
						  ,PriceCode
						  ,CustType
						  ,RecordType
						  ,ProdName
						  ,UnitOfMeasure
						  ,CurrencyCode
						  ,UnitPrice
						  ,BreakQty02
						  ,BreakQty03
						  ,BreakQty04
						  ,BreakQty05
						  ,BreakQty06
						  ,BreakQty07
						  ,BreakQty08
						  ,BreakQty09
						  ,BreakQty10
						  ,BreakQty11
						  ,Amount02
						  ,Amount03
						  ,Amount04
						  ,Amount05
						  ,Amount06
						  ,Amount07
						  ,Amount08
						  ,Amount09
						  ,Amount10
						  ,Amount11
						  ,PriceBasis01
						  ,PriceBasis02
						  ,PriceBasis03
						  ,PriceBasis04
						  ,PriceBasis05
						  ,PriceBasis06
						  ,PriceBasis07
						  ,PriceBasis08
						  ,PriceBasis09
						  ,PriceBasis10
						  ,PriceBasis11
						  ,AdjustmentType01
						  ,AdjustmentType02
						  ,AdjustmentType03
						  ,AdjustmentType04
						  ,AdjustmentType05
						  ,AdjustmentType06
						  ,AdjustmentType07
						  ,AdjustmentType08
						  ,AdjustmentType09
						  ,AdjustmentType10
						  ,AdjustmentType11
						  
			  FROM OPENXML(@XMLHandle, '/NewDataSet/PriceMatrix', 1)
					WITH
					(
						  CustNum NVARCHAR(50) 'CustNum'
						  ,EffectiveDate DATETIME 'EffectiveDate'
						  ,DiscontinueDate DATETIME 'DiscontinueDate'
						  ,PriceCode NVARCHAR(50) 'PriceCode'
						  ,CustType NVARCHAR(50) 'CustType'
						  ,RecordType NVARCHAR(50) 'RecordType'
						  ,ProdName NVARCHAR(50) 'ProdName'
						  ,UnitOfMeasure NVARCHAR(50) 'UnitOfMeasure'
						  ,CurrencyCode NVARCHAR(50) 'CurrencyCode'
						  ,UnitPrice DECIMAL(18,5) 'UnitPrice'
						  ,BreakQty02 DECIMAL(18,5) 'BreakQty02'
						  ,BreakQty03 DECIMAL(18,5) 'BreakQty03'
						  ,BreakQty04 DECIMAL(18,5) 'BreakQty04'
						  ,BreakQty05 DECIMAL(18,5) 'BreakQty05'
						  ,BreakQty06 DECIMAL(18,5) 'BreakQty06'
						  ,BreakQty07 DECIMAL(18,5) 'BreakQty07'
						  ,BreakQty08 DECIMAL(18,5) 'BreakQty08'
						  ,BreakQty09 DECIMAL(18,5) 'BreakQty09'
						  ,BreakQty10 DECIMAL(18,5) 'BreakQty10'
						  ,BreakQty11 DECIMAL(18,5) 'BreakQty11'
						  ,Amount02 DECIMAL(18,5) 'Amount02'
						  ,Amount03 DECIMAL(18,5) 'Amount03'
						  ,Amount04 DECIMAL(18,5) 'Amount04'
						  ,Amount05 DECIMAL(18,5) 'Amount05'
						  ,Amount06 DECIMAL(18,5) 'Amount06'
						  ,Amount07 DECIMAL(18,5) 'Amount07'
						  ,Amount08 DECIMAL(18,5) 'Amount08'
						  ,Amount09 DECIMAL(18,5) 'Amount09'
						  ,Amount10 DECIMAL(18,5) 'Amount10'
						  ,Amount11 DECIMAL(18,5) 'Amount11'
						  ,PriceBasis01 NVARCHAR(50) 'PriceBasis01'
						  ,PriceBasis02 NVARCHAR(50) 'PriceBasis02'
						  ,PriceBasis03 NVARCHAR(50) 'PriceBasis03'
						  ,PriceBasis04 NVARCHAR(50) 'PriceBasis04'
						  ,PriceBasis05 NVARCHAR(50) 'PriceBasis05'
						  ,PriceBasis06 NVARCHAR(50) 'PriceBasis06'
						  ,PriceBasis07 NVARCHAR(50) 'PriceBasis07'
						  ,PriceBasis08 NVARCHAR(50) 'PriceBasis08'
						  ,PriceBasis09 NVARCHAR(50) 'PriceBasis09'
						  ,PriceBasis10 NVARCHAR(50) 'PriceBasis10'
						  ,PriceBasis11 NVARCHAR(50) 'PriceBasis11'
						  ,AdjustmentType01 NVARCHAR(50) 'AdjustmentType01'
						  ,AdjustmentType02 NVARCHAR(50) 'AdjustmentType02'
						  ,AdjustmentType03 NVARCHAR(50) 'AdjustmentType03'
						  ,AdjustmentType04 NVARCHAR(50) 'AdjustmentType04'
						  ,AdjustmentType05 NVARCHAR(50) 'AdjustmentType05'
						  ,AdjustmentType06 NVARCHAR(50) 'AdjustmentType06'
						  ,AdjustmentType07 NVARCHAR(50) 'AdjustmentType07'
						  ,AdjustmentType08 NVARCHAR(50) 'AdjustmentType08'
						  ,AdjustmentType09 NVARCHAR(50) 'AdjustmentType09'
						  ,AdjustmentType10 NVARCHAR(50) 'AdjustmentType10'
						  ,AdjustmentType11 NVARCHAR(50) 'AdjustmentType11'
					)
			  
			  -- Delete existing PriceMatrix records
			  TRUNCATE TABLE PriceMatrix_Batch
			  
			  INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
				VALUES (0, 'INFO', 'RefreshPricing_Visual', 'Finished reading XML data')

			  SET @RecordCount = 0
			  SET @RecordPageSize = 1000
			  BEGIN TRANSACTION
		
			  -- cursor to loop through records
			  DECLARE PriceMatrixDataCursor CURSOR LOCAL STATIC READ_ONLY FOR SELECT * FROM #PriceMatrixData
			  OPEN PriceMatrixDataCursor
			  WHILE 1 = 1
			  BEGIN
					FETCH NEXT FROM PriceMatrixDataCursor INTO
						  @CustNum
						  ,@EffectiveDate
						  ,@DiscontinueDate
						  ,@PriceCode
						  ,@CustType
						  ,@RecordType
						  ,@ProdName
						  ,@UnitOfMeasure
						  ,@CurrencyCode
						  ,@UnitPrice
						  ,@BreakQty02
						  ,@BreakQty03
						  ,@BreakQty04
						  ,@BreakQty05
						  ,@BreakQty06
						  ,@BreakQty07
						  ,@BreakQty08
						  ,@BreakQty09
						  ,@BreakQty10
						  ,@BreakQty11
						  ,@Amount02
						  ,@Amount03
						  ,@Amount04
						  ,@Amount05
						  ,@Amount06
						  ,@Amount07
						  ,@Amount08
						  ,@Amount09
						  ,@Amount10
						  ,@Amount11
						  ,@PriceBasis01
						  ,@PriceBasis02
						  ,@PriceBasis03
						  ,@PriceBasis04
						  ,@PriceBasis05
						  ,@PriceBasis06
						  ,@PriceBasis07
						  ,@PriceBasis08
						  ,@PriceBasis09
						  ,@PriceBasis10
						  ,@PriceBasis11
						  ,@AdjustmentType01
						  ,@AdjustmentType02
						  ,@AdjustmentType03
						  ,@AdjustmentType04
						  ,@AdjustmentType05
						  ,@AdjustmentType06
						  ,@AdjustmentType07
						  ,@AdjustmentType08
						  ,@AdjustmentType09
						  ,@AdjustmentType10
						  ,@AdjustmentType11
						  
					IF @@FETCH_STATUS <> 0
						  BREAK
					
					-- nullify customerid and productid
					SET @CustomerId = NULL
					SET @ProductId = NULL
					
					-- check for blank currency code
					IF ISNULL(@CurrencyCode,'') = '' SET @CurrencyCode = @ERP_DefaultCurrencyCode
					
					-- Customer/Product
					IF @RecordType = 'Customer/Product'
					BEGIN
						  -- get the customerid for the CustomerKeyPart field
						  SELECT @CustomerId = CustomerId FROM Customer WHERE CustomerNumber = @CustNum AND CustomerSequence = '0'
						  
						  -- get the productid for the ProductKeyPart field
						  SELECT @ProductId = ProductId FROM Product WHERE ERPNumber = @ProdName
						  
						  if(@ProductId IS NOT NULL)
						  BEGIN
						  -- insert record into PriceMatrix
						  INSERT INTO PriceMatrix_Batch(
								RecordType
								,CurrencyCode
								,Warehouse
								,UnitOfMeasure
								,CustomerKeyPart
								,ProductKeyPart
								,Active
								,Deactivate
								,CalculationFlags
								,PriceBasis01
								,PriceBasis02
								,PriceBasis03
								,PriceBasis04
								,PriceBasis05
								,PriceBasis06
								,PriceBasis07
								,PriceBasis08
								,PriceBasis09
								,PriceBasis10
								,PriceBasis11
								,AdjustmentType01
								,AdjustmentType02
								,AdjustmentType03
								,AdjustmentType04
								,AdjustmentType05
								,AdjustmentType06
								,AdjustmentType07
								,AdjustmentType08
								,AdjustmentType09
								,AdjustmentType10
								,AdjustmentType11
								,BreakQty01
								,BreakQty02
								,BreakQty03
								,BreakQty04
								,BreakQty05
								,BreakQty06
								,BreakQty07
								,BreakQty08
								,BreakQty09
								,BreakQty10
								,BreakQty11
								,Amount01
								,Amount02
								,Amount03
								,Amount04
								,Amount05
								,Amount06
								,Amount07
								,Amount08
								,Amount09
								,Amount10
								,Amount11
						  )
						  Values(
								@RecordType
								,@CurrencyCode
								,@ERP_Warehouse
								,@UnitOfMeasure
								,@CustomerId
								,@ProductId
								,ISNULL(@EffectiveDate, @RunDateTime)
								,@DiscontinueDate
								,''
								,@PriceBasis01
								,@PriceBasis02
								,@PriceBasis03
								,@PriceBasis04
								,@PriceBasis05
								,@PriceBasis06
								,@PriceBasis07
								,@PriceBasis08
								,@PriceBasis09
								,@PriceBasis10
								,@PriceBasis11
								,@AdjustmentType01
								,@AdjustmentType02
								,@AdjustmentType03
								,@AdjustmentType04
								,@AdjustmentType05
								,@AdjustmentType06
								,@AdjustmentType07
								,@AdjustmentType08
								,@AdjustmentType09
								,@AdjustmentType10
								,@AdjustmentType11
								,0
								,ISNULL(@BreakQty02,0)
								,ISNULL(@BreakQty03,0)
								,ISNULL(@BreakQty04,0)
								,ISNULL(@BreakQty05,0)
								,ISNULL(@BreakQty06,0)
								,ISNULL(@BreakQty07,0)
								,ISNULL(@BreakQty08,0)
								,ISNULL(@BreakQty09,0)
								,ISNULL(@BreakQty10,0)
								,ISNULL(@BreakQty11,0)
								,@UnitPrice
								,ISNULL(@Amount02,0)
								,ISNULL(@Amount03,0)
								,ISNULL(@Amount04,0)
								,ISNULL(@Amount05,0)
								,ISNULL(@Amount06,0)
								,ISNULL(@Amount07,0)
								,ISNULL(@Amount08,0)
								,ISNULL(@Amount09,0)
								,ISNULL(@Amount10,0)
								,ISNULL(@Amount11,0)
						  )
						  END
					END
					
					-- Customer Price Code/Product
					IF @RecordType = 'Customer Price Code/Product'
					BEGIN
						  -- get the productid for the ProductKeyPart field
						  SELECT @ProductId = ProductId FROM Product WHERE ERPNumber = @ProdName

						  if(@ProductId IS NOT NULL)
						  BEGIN
						  -- insert record into PriceMatrix
						  INSERT INTO PriceMatrix_Batch(
								RecordType
								,CurrencyCode
								,Warehouse
								,UnitOfMeasure
								,CustomerKeyPart
								,ProductKeyPart
								,Active
								,Deactivate
								,CalculationFlags
								,PriceBasis01
								,PriceBasis02
								,PriceBasis03
								,PriceBasis04
								,PriceBasis05
								,PriceBasis06
								,PriceBasis07
								,PriceBasis08
								,PriceBasis09
								,PriceBasis10
								,PriceBasis11
								,AdjustmentType01
								,AdjustmentType02
								,AdjustmentType03
								,AdjustmentType04
								,AdjustmentType05
								,AdjustmentType06
								,AdjustmentType07
								,AdjustmentType08
								,AdjustmentType09
								,AdjustmentType10
								,AdjustmentType11
								,BreakQty01
								,BreakQty02
								,BreakQty03
								,BreakQty04
								,BreakQty05
								,BreakQty06
								,BreakQty07
								,BreakQty08
								,BreakQty09
								,BreakQty10
								,BreakQty11
								,Amount01
								,Amount02
								,Amount03
								,Amount04
								,Amount05
								,Amount06
								,Amount07
								,Amount08
								,Amount09
								,Amount10
								,Amount11
						  )
						  Values(
								@RecordType
								,@CurrencyCode
								,@ERP_Warehouse
								,@UnitOfMeasure
								,@PriceCode
								,@ProductId
								,ISNULL(@EffectiveDate, @RunDateTime)
								,@DiscontinueDate
								,''
								,@PriceBasis01
								,@PriceBasis02
								,@PriceBasis03
								,@PriceBasis04
								,@PriceBasis05
								,@PriceBasis06
								,@PriceBasis07
								,@PriceBasis08
								,@PriceBasis09
								,@PriceBasis10
								,@PriceBasis11
								,@AdjustmentType01
								,@AdjustmentType02
								,@AdjustmentType03
								,@AdjustmentType04
								,@AdjustmentType05
								,@AdjustmentType06
								,@AdjustmentType07
								,@AdjustmentType08
								,@AdjustmentType09
								,@AdjustmentType10
								,@AdjustmentType11
								,0
								,ISNULL(@BreakQty02,0)
								,ISNULL(@BreakQty03,0)
								,ISNULL(@BreakQty04,0)
								,ISNULL(@BreakQty05,0)
								,ISNULL(@BreakQty06,0)
								,ISNULL(@BreakQty07,0)
								,ISNULL(@BreakQty08,0)
								,ISNULL(@BreakQty09,0)
								,ISNULL(@BreakQty10,0)
								,ISNULL(@BreakQty11,0)
								,@UnitPrice
								,ISNULL(@Amount02,0)
								,ISNULL(@Amount03,0)
								,ISNULL(@Amount04,0)
								,ISNULL(@Amount05,0)
								,ISNULL(@Amount06,0)
								,ISNULL(@Amount07,0)
								,ISNULL(@Amount08,0)
								,ISNULL(@Amount09,0)
								,ISNULL(@Amount10,0)
								,ISNULL(@Amount11,0)
						  )
						  END
					END
					
					-- Customer Type/Product
					IF @RecordType = 'Customer Type/Product'
					BEGIN
						  -- get the productid for the ProductKeyPart field
						  SELECT @ProductId = ProductId FROM Product WHERE ERPNumber = @ProdName
						  
						  if(@ProductId IS NOT NULL)
						  BEGIN
						  -- insert record into PriceMatrix
						  INSERT INTO PriceMatrix_Batch(
								RecordType
								,CurrencyCode
								,Warehouse
								,UnitOfMeasure
								,CustomerKeyPart
								,ProductKeyPart
								,Active
								,Deactivate
								,CalculationFlags
								,PriceBasis01
								,PriceBasis02
								,PriceBasis03
								,PriceBasis04
								,PriceBasis05
								,PriceBasis06
								,PriceBasis07
								,PriceBasis08
								,PriceBasis09
								,PriceBasis10
								,PriceBasis11
								,AdjustmentType01
								,AdjustmentType02
								,AdjustmentType03
								,AdjustmentType04
								,AdjustmentType05
								,AdjustmentType06
								,AdjustmentType07
								,AdjustmentType08
								,AdjustmentType09
								,AdjustmentType10
								,AdjustmentType11
								,BreakQty01
								,BreakQty02
								,BreakQty03
								,BreakQty04
								,BreakQty05
								,BreakQty06
								,BreakQty07
								,BreakQty08
								,BreakQty09
								,BreakQty10
								,BreakQty11
								,Amount01
								,Amount02
								,Amount03
								,Amount04
								,Amount05
								,Amount06
								,Amount07
								,Amount08
								,Amount09
								,Amount10
								,Amount11
						  )
						  Values(
								@RecordType
								,@CurrencyCode
								,@ERP_Warehouse
								,@UnitOfMeasure
								,@CustType
								,@ProductId
								,ISNULL(@EffectiveDate, @RunDateTime)
								,@DiscontinueDate
								,''
								,@PriceBasis01
								,@PriceBasis02
								,@PriceBasis03
								,@PriceBasis04
								,@PriceBasis05
								,@PriceBasis06
								,@PriceBasis07
								,@PriceBasis08
								,@PriceBasis09
								,@PriceBasis10
								,@PriceBasis11
								,@AdjustmentType01
								,@AdjustmentType02
								,@AdjustmentType03
								,@AdjustmentType04
								,@AdjustmentType05
								,@AdjustmentType06
								,@AdjustmentType07
								,@AdjustmentType08
								,@AdjustmentType09
								,@AdjustmentType10
								,@AdjustmentType11
								,0
								,ISNULL(@BreakQty02,0)
								,ISNULL(@BreakQty03,0)
								,ISNULL(@BreakQty04,0)
								,ISNULL(@BreakQty05,0)
								,ISNULL(@BreakQty06,0)
								,ISNULL(@BreakQty07,0)
								,ISNULL(@BreakQty08,0)
								,ISNULL(@BreakQty09,0)
								,ISNULL(@BreakQty10,0)
								,ISNULL(@BreakQty11,0)
								,@UnitPrice
								,ISNULL(@Amount02,0)
								,ISNULL(@Amount03,0)
								,ISNULL(@Amount04,0)
								,ISNULL(@Amount05,0)
								,ISNULL(@Amount06,0)
								,ISNULL(@Amount07,0)
								,ISNULL(@Amount08,0)
								,ISNULL(@Amount09,0)
								,ISNULL(@Amount10,0)
								,ISNULL(@Amount11,0)
						  )
					  END
				END

				SET @RecordCount = @RecordCount + 1
				IF @RecordCount % @RecordPageSize = 0
				BEGIN
					COMMIT TRANSACTION

					INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
						VALUES (0, 'INFO', 'RefreshPricing_Visual', 'Processing record ' + CAST(@RecordCount AS NVARCHAR(50)))

					BEGIN TRANSACTION	
				END
				
		  END
  		  IF @@TRANCOUNT > 0
			  COMMIT TRANSACTION
		  
		  -- clean up cursor
		  CLOSE PriceMatrixDataCursor
		  DEALLOCATE PriceMatrixDataCursor
		  
		  -- release the xml doc from memory
		  EXEC sp_xml_removedocument @XMLHandle
		  INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
			  VALUES (0, 'INFO', 'RefreshPricing_Visual', 'Finished Processing, total records processed ' + CAST(@RecordCount AS NVARCHAR(50)) + ' copying from PriceMatrix_Batch to PriceMatrix')

		  BEGIN TRANSACTION
		  TRUNCATE TABLE PriceMatrix
		  INSERT INTO PriceMatrix SELECT * FROM PriceMatrix_Batch
		  COMMIT TRANSACTION

		  INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
			  VALUES (0, 'INFO', 'RefreshPricing_Visual', 'Finished')

	END
			
END

GO
/****** Object:  StoredProcedure [dbo].[RefreshProducts]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:      Andrew Stein
-- Create date: 2/24/2010
-- Description: Refresh Products
--
-- This file contains a stored procedure for refreshing products according to the needs of Epicor Commerce
--
-- =============================================
CREATE PROCEDURE [dbo].[RefreshProducts]
    @webSiteId UNIQUEIDENTIFIER,
    @erpProductName NVARCHAR(50),
    @xmlString NVARCHAR(MAX),
    @runBatch INT
AS
BEGIN

    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Abort procedure on error. Remove this if you want the procedure to continue in the face of errors.
    SET XACT_ABORT ON;

    -- Check the arguments
    IF @erpProductName IS NULL OR @xmlString IS NULL OR @runBatch IS NULL
    BEGIN
        INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
            VALUES (@runBatch, 'Error', 'ProductRefresh', 'RefreshProducts called with NULL argument(s)')
        RETURN
    END

    -- Log start message
    IF @erpProductName = ''
        INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
            VALUES (@runBatch, 'Info', 'ProductRefresh', 'Starting Full Product Refresh (Stored Proc)')
    ELSE
        INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
            VALUES (@runBatch, 'Info', 'ProductRefresh', 'Starting Single Product Refresh for ' + @erpProductName + ' (Stored Proc)')

    -- Are we logging debug messages
    DECLARE @logDebug TINYINT
    SET @logDebug = 0
    IF EXISTS (SELECT 1 FROM ApplicationSetting WHERE Name = 'ApplicationLog_LogDebugMessages')
        SELECT @logDebug = CASE LOWER(Value) WHEN 'true' THEN 1 ELSE 0 END
          FROM ApplicationSetting WHERE Name = 'ApplicationLog_LogDebugMessages'

    -- Are we mapping cross sells?
    IF NOT EXISTS (SELECT 1 FROM ApplicationSetting WHERE Name = 'ERP_RefreshProductCrossSells')
       INSERT INTO ApplicationSetting (Name, Value, Description)
              VALUES ('ERP_RefreshProductCrossSells', 'false', '')
    DECLARE @refreshProductCrossSells TINYINT
    SELECT @refreshProductCrossSells = CASE LOWER(Value) WHEN 'true' THEN 1 ELSE 0 END
      FROM ApplicationSetting WHERE Name = 'ERP_RefreshProductCrossSells'

    -- Will we need to map products to categories?
    DECLARE @mapProductsToCategories TINYINT
    SELECT @mapProductsToCategories = MapProductsToCategories FROM WebSite WHERE WebSiteId = @webSiteId

    -- Are the categories coming in as product codes (TW Medical) or as product/category code pairs (US Safety Gear)?
    DECLARE @mapProductsToCategoriesWithSeveralCodes TINYINT
    SET @mapProductsToCategoriesWithSeveralCodes = 0
    IF @mapProductsToCategories = 1
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM ApplicationSetting WHERE Name = 'ERP_RefreshProductCategoryWithSeveralCodes')
            INSERT INTO ApplicationSetting (Name, Value, Description)
                VALUES ('ERP_RefreshProductCategoryWithSeveralCodes', 'false', '')
        SELECT @mapProductsToCategoriesWithSeveralCodes = CASE LOWER(Value) WHEN 'true' THEN 1 ELSE 0 END
          FROM ApplicationSetting WHERE Name = 'ERP_RefreshProductCategoryWithSeveralCodes'
    END

    -- Debug messages about what we are doing.
    IF @logDebug = 1 AND @mapProductsToCategories = 1 AND @mapProductsToCategoriesWithSeveralCodes = 0
        INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
            VALUES (@runBatch, 'Debug', 'ProductRefresh', 'Mapping Product.ProductCode to Category')
    IF @logDebug = 1 AND @mapProductsToCategories = 1 AND @mapProductsToCategoriesWithSeveralCodes = 1
        INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
            VALUES (@runBatch, 'Debug', 'ProductRefresh', 'Mapping Product / CategoryCode pairs to Category')


    DECLARE @xmlHandle INT
    EXEC sp_xml_preparedocument @xmlHandle OUTPUT, @xmlString

    -- Read the ERP products from the XML into a temporary table
    SELECT
        Name AS ERPNumber,
        ERPDescription,
        ShortDescription,
        ProductCode,
        PriceCode,
        BasicListPrice,
        CustomPropertyPartType,
        UnitOfMeasure,
        TaxCategory,
        ShippingWeight,
        ShippingWidth,
        ShippingLength,
        ShippingHeight,
        MetaKeywords,
        CASE LOWER(DisplayPricePerPiece) WHEN 'true' THEN 1 ELSE 0 END AS DisplayPricePerPiece,
        CASE LOWER(TrackInventory) WHEN 'true' THEN 1 ELSE 0 END AS TrackInventory,
        UPCCode,
        CASE LOWER(IsActive) WHEN 'true' THEN 1 ELSE 0 END AS IsActive,
        ISNULL(CustomPropertyERP_SafetyStock,'0') AS CustomPropertyERP_SafetyStock
      INTO #erpProducts
      FROM OPENXML (@xmlHandle, '/NewDataSet/Product', 1)
      WITH (
        Name NVARCHAR(50) 'Name',
        ERPDescription NVARCHAR(100) 'ERPDescription',
        ShortDescription NVARCHAR(255) 'ShortDescription',
        ProductCode NVARCHAR(50) 'ProductCode',
        PriceCode NVARCHAR(50) 'PriceCode',
        BasicListPrice DECIMAL(18, 5) 'BasicListPrice',
        CustomPropertyPartType NVARCHAR(MAX) 'CustomPropertyPartType',
        UnitOfMeasure NVARCHAR(50) 'UnitOfMeasure',
        TaxCategory NVARCHAR(50) 'TaxCategory',
        ShippingWeight DECIMAL(18, 5) 'ShippingWeight',
        ShippingWidth DECIMAL(18, 5) 'ShippingWidth',
        ShippingLength DECIMAL(18, 5) 'ShippingLength',
        ShippingHeight DECIMAL(18, 5) 'ShippingHeight',
        MetaKeywords NVARCHAR(MAX) 'MetaKeywords',
        DisplayPricePerPiece NVARCHAR(10) 'DisplayPricePerPiece',
        TrackInventory NVARCHAR(10) 'TrackInventory',
        UPCCode NVARCHAR(50) 'UPCCode',
        IsActive NVARCHAR(10) 'IsActive',
        CustomPropertyERP_SafetyStock NVARCHAR(MAX) 'CustomPropertyERP_SafetyStock'
      )

    DECLARE @count INT
    IF @erpProductName = ''
    BEGIN
        SELECT @count = COUNT(*) FROM #erpProducts
        INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
            VALUES (@runBatch, 'Info', 'ProductRefresh', 'DataSet has ' + CAST(@count AS NVARCHAR(20)) + ' Products')
    END

    IF @refreshProductCrossSells = 1
    BEGIN
        -- Read the ERP cross sells from the XML into a temporary table
        SELECT
          ERPNumber,
          CrossSellERPNumber
        INTO #erpCrossSells
        FROM OPENXML (@xmlHandle, '/NewDataSet/CrossSell', 1)
        WITH (
          ERPNumber NVARCHAR(50) 'ERPNumber',
          CrossSellERPNumber NVARCHAR(50) 'CrossSellERPNumber'
        )

        IF @erpProductName = ''
        BEGIN
            SELECT @count = COUNT(*) FROM #erpCrossSells
            INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
                   VALUES (@runBatch, 'Info', 'ProductRefresh', 'DataSet has ' + CAST(@count AS NVARCHAR(20)) + ' Cross Sells')
        END
    END

    IF @mapProductsToCategoriesWithSeveralCodes = 1
    BEGIN
        -- Read the ERP product / category code pairs from the XML into a temporary table
        SELECT
          ERPNumber,
          CategoryCode
        INTO #erpProductCategoryCodes
        FROM OPENXML (@xmlHandle, '/NewDataSet/ProductCategoryCode', 1)
        WITH (
          ERPNumber NVARCHAR(50) 'ERPNumber',
          CategoryCode NVARCHAR(50) 'CategoryCode'
        )

        IF @erpProductName = ''
        BEGIN
            SELECT @count = COUNT(*) FROM #erpProductCategoryCodes
            INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
                   VALUES (@runBatch, 'Info', 'ProductRefresh', 'DataSet has ' + CAST(@count AS NVARCHAR(20)) + ' Product - Product Codes')
        END

        -- We are going to need this in the ERP product loop
        CREATE TABLE #webCategories (CategoryId UNIQUEIDENTIFIER)
    END

    EXEC sp_xml_removedocument @xmlHandle


    -- Create and open a cursor on the ERP products
    DECLARE erpProductCursor CURSOR FOR SELECT * FROM #erpProducts
    OPEN erpProductCursor

    -- Loop on the ERP products
    SET @count = 0
    WHILE 1 = 1
    BEGIN

        DECLARE @erpNumber NVARCHAR(50)
        DECLARE @erpDescription NVARCHAR(100)
        DECLARE @shortDescription NVARCHAR(255)
        DECLARE @productCode NVARCHAR(50)
        DECLARE @priceCode NVARCHAR(50)
        DECLARE @basicListPrice DECIMAL(18, 5)
        DECLARE @customPropertyPartType NVARCHAR(MAX)
        DECLARE @unitOfMeasure NVARCHAR(50)
        DECLARE @taxCategory NVARCHAR(50)
        DECLARE @shippingWeight DECIMAL(18, 5)
        DECLARE @shippingWidth DECIMAL(18, 5)
        DECLARE @shippingLength DECIMAL(18, 5)
        DECLARE @shippingHeight DECIMAL(18, 5)
        DECLARE @metaKeywords NVARCHAR(MAX)
        DECLARE @displayPricePerPiece TINYINT
        DECLARE @trackInventory TINYINT
        DECLARE @upcCode NVARCHAR(50)
        DECLARE @isActive TINYINT
        DECLARE @customPropertyERP_SafetyStock NVARCHAR(MAX)

        FETCH NEXT FROM erpProductCursor INTO
            @erpNumber,
            @erpDescription,
            @shortDescription,
            @productCode,
            @priceCode,
            @basicListPrice,
            @customPropertyPartType,
            @unitOfMeasure,
            @taxCategory,
            @shippingWeight,
            @shippingWidth,
            @shippingLength,
            @shippingHeight,
            @metaKeywords,
            @displayPricePerPiece,
            @trackInventory,
            @uPCCode,
            @isActive,
            @customPropertyERP_SafetyStock

        IF @@FETCH_STATUS <> 0
           BREAK

        IF @erpProductName <> '' AND @erpProductName <> @erpNumber -- Single refresh, wrong product
            CONTINUE

        -- If a product with the ERP Number does not exist, create it
        IF NOT EXISTS (SELECT 1 FROM Product WHERE ERPNumber = @erpNumber)
            INSERT INTO Product (Name, ERPNumber, ERPManaged)
                VALUES (@erpNumber, @erpNumber, 1)

        -- Retrieve the product's ID and whether it is managed by the ERP
        -- TODO: Handle more than one product with the same ERP Number
        DECLARE @productId UNIQUEIDENTIFIER
        DECLARE @erpManaged TINYINT
        SET @productId = NULL
        SET @erpManaged = 1
        SELECT @productId = ProductId, @erpManaged = ERPManaged
          FROM Product
         WHERE ERPNumber = @erpNumber
        IF @productId IS NULL
        BEGIN
            INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
                VALUES (@runBatch, 'Error', 'ProductRefresh', 'Could not retrieve the Product ID for ' + @erpNumber)
            RETURN
        END

        -- Do not modify products not managed by the ERP.
        -- NOTE: This is different from the handling by ProductRefresh_Generic.cs,
        --       which creates an ERP managed product with the same ERP Number
        IF @erpManaged = 0
            CONTINUE

        -- Update the standard fields of the product
        UPDATE Product
        SET
            ERPNumber = @erpNumber,
            ERPDescription = @erpDescription,
            ShortDescription = @shortDescription,
            ProductCode = @productCode,
            PriceCode = @priceCode,
            BasicListPrice = @basicListPrice,
            UnitOfMeasure = @unitOfMeasure,
            TaxCategory = @taxCategory,
            ShippingWeight = @shippingWeight,
            ShippingWidth = @shippingWidth,
            ShippingLength = @shippingLength,
            ShippingHeight = @shippingHeight,
            MetaKeywords = @metaKeywords,
            DisplayPricePerPiece = @displayPricePerPiece,
            TrackInventory = @trackInventory,
            UPCCode = @upcCode
        WHERE ProductId = @productId

        -- Modify the Deactivate date according to whether the product is active.
        -- NOTE: This is different from the handling by ProductUpdate_Generic.cs,
        --       which sets Deactivate without comparing the date to GETDATE()/DateTime.Now.
        --       This handling is more consistent with the 'deactivate products that were not returned' logic.
        IF @isActive = 1
            UPDATE Product
               SET Deactivate = NULL
             WHERE ProductId = @productId AND (Deactivate IS NOT NULL AND Deactivate <= GETDATE())
        ELSE
            UPDATE Product
               SET Deactivate = GETDATE()
             WHERE ProductId = @productId AND (Deactivate IS NULL OR Deactivate > GETDATE())

        -- Create / modify custom properties

        IF EXISTS (SELECT 1 FROM ProductProperty WHERE ProductId = @productId AND Name = 'PartType')
            UPDATE ProductProperty SET Value = @customPropertyPartType
                WHERE ProductId = @productId AND Name = 'PartType'
        ELSE
            INSERT INTO ProductProperty (ProductId, Name, Value)
                VALUES (@productId, 'PartType', @customPropertyPartType)

        IF EXISTS (SELECT 1 FROM ProductProperty WHERE ProductId = @productId AND Name = 'ERP_SafetyStock')
            UPDATE ProductProperty SET Value = @customPropertyERP_SafetyStock
                WHERE ProductId = @productId AND Name = 'ERP_SafetyStock'
        ELSE
            INSERT INTO ProductProperty (ProductId, Name, Value)
                VALUES (@productId, 'ERP_SafetyStock', @customPropertyERP_SafetyStock)


        -- Map/unmap categories using product codes
        IF @mapProductsToCategories = 1 AND @mapProductsToCategoriesWithSeveralCodes = 0
        BEGIN

            -- Map the product to categories to which it belongs
            INSERT INTO CategoryProduct (CategoryId, ProductId)
                SELECT CategoryId, @productId
                  FROM Category
                 WHERE WebSiteId = @webSiteId
                   AND ( ERPProductValues = @productCode
                      OR ERPProductValues LIKE @productCode + ',%'
                      OR ERPProductValues LIKE '%,' + @productCode
                      OR ERPProductValues LIKE '%,' + @productCode + ',%')
                   AND CategoryId NOT IN (SELECT CategoryId FROM CategoryProduct WHERE ProductId = @productId)

            -- Unmap the product from categories to which it no longer belongs
            DELETE FROM CategoryProduct
                WHERE CategoryId IN (
                    SELECT CategoryId
                      FROM Category
                     WHERE WebSiteId = @webSiteId
                       AND ERPProductValues <> ''
                       AND ( ERPProductValues <> @productCode
                         AND ERPProductValues NOT LIKE @productCode + ',%'
                         AND ERPProductValues NOT LIKE '%,' + @productCode
                         AND ERPProductValues NOT LIKE '%,' + @productCode + ',%'))
                  AND ProductId = @productId

        END

        -- Map/unmap categories using product / category code pairs
        ELSE IF @mapProductsToCategories = 1 AND @mapProductsToCategoriesWithSeveralCodes = 1
        BEGIN

            -- Remember the ERP mapped categories to which the product belongs
            INSERT INTO #webCategories (CategoryId)
              SELECT cp.CategoryId
                FROM CategoryProduct cp
                INNER JOIN Category c ON c.CategoryId = cp.CategoryId
               WHERE c.WebSiteId = @webSiteId
                 AND c.ERPProductValues <> ''
                 AND cp.ProductId = @productId

            DECLARE erpProdcutCodeCursor CURSOR FOR
                SELECT CategoryCode FROM #erpProductCategoryCodes WHERE ERPNumber = @erpNumber
            OPEN erpProdcutCodeCursor

            WHILE 1 = 1
            BEGIN
                DECLARE @categoryCode NVARCHAR(50)
                FETCH NEXT FROM erpProdcutCodeCursor INTO @categoryCode
                IF @@FETCH_STATUS <> 0
                   BREAK

                -- Map the product to categories to which it belongs
                INSERT INTO CategoryProduct (CategoryId, ProductId)
                    SELECT CategoryId, @productId
                      FROM Category
                    WHERE WebSiteId = @webSiteId
                      AND ( ERPProductValues = @categoryCode
                         OR ERPProductValues LIKE @categoryCode + ',%'
                         OR ERPProductValues LIKE '%,' + @categoryCode
                         OR ERPProductValues LIKE '%,' + @categoryCode + ',%')
                      AND CategoryId NOT IN (SELECT CategoryId FROM CategoryProduct WHERE ProductId = @productId)

                 -- Delete the categories from the remembered list
                 DELETE FROM #webCategories
                     WHERE CategoryId IN (
                        SELECT CategoryId
                          FROM Category
                        WHERE WebSiteId = @webSiteId
                          AND ( ERPProductValues = @categoryCode
                             OR ERPProductValues LIKE @categoryCode + ',%'
                             OR ERPProductValues LIKE '%,' + @categoryCode
                             OR ERPProductValues LIKE '%,' + @categoryCode + ',%')
                     )
            END

            CLOSE erpProdcutCodeCursor
            DEALLOCATE erpProdcutCodeCursor

            -- Unmap the product from categories to which it no longer belongs
            DELETE FROM CategoryProduct
                WHERE CategoryId IN (SELECT * FROM #webCategories)
                  AND ProductId = @productId

            -- Clean up our list
            DELETE FROM #webCategories

        END

        -- Log status message
        SET @count = @count + 1
        IF @logDebug = 1 AND @count % 1000 = 0
            INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
                VALUES (@runBatch, 'Debug', 'ProductRefresh', 'Status Product: ' + CAST(@count AS NVARCHAR))

    END

    -- Close and deallcate the cursor
    CLOSE erpProductCursor
    DEALLOCATE erpProductCursor

    -- Refresh Cross Sells
    IF @refreshProductCrossSells = 1
    BEGIN

        DECLARE erpNumberCursor CURSOR FOR SELECT ERPNumber FROM #erpProducts
        OPEN erpNumberCursor

        SET @count = 0
        WHILE 1 = 1
        BEGIN
            FETCH NEXT FROM erpNumberCursor INTO @erpNumber
            IF @@FETCH_STATUS <> 0
               BREAK

            SET @productId = NULL
            SELECT @productId = ProductId
              FROM Product
             WHERE ERPNumber = @erpNumber AND ERPManaged = 1

           IF @productId IS NULL -- Should not happen
              CONTINUE

            INSERT INTO ProductProductCrossSell (ProductId, CrossSellProductId)
                SELECT @productId, ProductId
                  FROM Product p
                  INNER JOIN #erpCrossSells cs ON cs.ERPNumber = @erpNumber AND cs.CrossSellERPNumber = p.ERPNumber
                 WHERE ProductId NOT IN (
                     SELECT CrossSellProductId FROM ProductProductCrossSell WHERE ProductId = @productId
                 )

           DELETE FROM ProductProductCrossSell
               WHERE ProductId = @productId
                 AND CrossSellProductId NOT IN (
                    SELECT ProductId
                      FROM Product p
                    INNER JOIN #erpCrossSells cs ON cs.ERPNumber = @erpNumber AND cs.CrossSellERPNumber = p.ERPNumber
                 )

            -- Log status message
            SET @count = @count + 1
            IF @logDebug = 1 AND @count % 1000 = 0
                INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
                    VALUES (@runBatch, 'Debug', 'ProductRefresh', 'Status Product Cross Sell: ' + CAST(@count AS NVARCHAR))

        END

        CLOSE erpNumberCursor
        DEALLOCATE erpNumberCursor

    END

    -- Deactivate products that were not returned
    IF NOT EXISTS (SELECT 1 FROM ApplicationSetting WHERE Name = 'AutoDeactivateProducts')
       INSERT INTO ApplicationSetting (Name, Value, Description)
              VALUES ('AutoDeactivateProducts', 'true', 'If true, refresh will deactivate products not found in the dataset, must be false for large datasets that are sent in in batches')
    DECLARE @autoDeactivateProducts NVARCHAR(MAX)
    SELECT @autoDeactivateProducts = Value FROM ApplicationSetting WHERE Name = 'AutoDeactivateProducts'
    IF LOWER(@autoDeactivateProducts) = 'true'
    BEGIN
        IF @logDebug = 1
            INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
                VALUES (@runBatch, 'Debug', 'ProductRefresh', 'Deactivate products that were not returned')
        UPDATE Product
           SET Deactivate = GETDATE()
         WHERE ERPManaged = 1
           AND (Deactivate IS NULL OR Deactivate > GETDATE())
           AND (@erpProductName = '' OR @erpProductName = ERPNumber)
           AND ERPNumber NOT IN (SELECT ERPNumber FROM #erpProducts)
    END

    -- Log finish message
    INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
        VALUES (@runBatch, 'Info', 'ProductRefresh', 'Finishing Refresh Products Stored Proc')

END

GO
/****** Object:  StoredProcedure [dbo].[RollupInventory]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Darwin Zins
-- Create date: 2/12/2009
-- Description:	Stored Procedure that accepts DataSet and Refreshes and Rolls up Inventory
-- =============================================
CREATE PROCEDURE [dbo].[RollupInventory] 
  @XMLString NVARCHAR(MAX) = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE 
        @QtyOnHand DECIMAL(19,5),
		@ProductId UNIQUEIDENTIFIER,
		@RetentionWindow INT,
		@RetentionDate DATETIME

	DECLARE @InventoryData TABLE
    (
		ERPNumber NVARCHAR(100),
        QtyAvailable DECIMAL(19,5),
        Warehouse NVARCHAR(100)
    )

	-- Rollup Inventory Transaction Records
	IF NOT EXISTS(SELECT 1 FROM ApplicationSetting WHERE Name = 'InventoryTransactionRetentionDays')
		INSERT INTO ApplicationSetting (Name, Value) VALUES ('InventoryTransactionRetentionDays', '14')

	SELECT @RetentionWindow = CAST(Value AS INT) FROM ApplicationSetting WHERE Name = 'InventoryTransactionRetentionDays'
	IF @RetentionWindow > 0
	BEGIN
		SET @RetentionWindow = -1 * @RetentionWindow
		SET @RetentionDate = DATEADD(day, @RetentionWindow, GETDATE())
		DECLARE ProductCursor CURSOR LOCAL STATIC READ_ONLY FOR SELECT ProductId FROM Product
		OPEN ProductCursor
		WHILE 1 = 1
		BEGIN
			FETCH NEXT FROM ProductCursor INTO @ProductId
			IF @@FETCH_STATUS <> 0
				BREAK
			SET @QtyOnHand = NULL
			SELECT @QtyOnHand = SUM(Amount) FROM InventoryTransaction it WHERE it.ProductId = @ProductId AND it.TransactionDate < @RetentionDate
			IF NOT @QtyOnHand IS NULL
			BEGIN
				BEGIN TRANSACTION
					DELETE it FROM InventoryTransaction it WHERE it.ProductId = @ProductId AND it.TransactionDate < @RetentionDate
					INSERT INTO InventoryTransaction (ProductId, TransactionDate, Description, Amount) VALUES (@ProductId, @RetentionDate, 'Rollup', @QtyOnHand)
				COMMIT TRANSACTION
			END
		END
		CLOSE ProductCursor
		DEALLOCATE ProductCursor
	END

END

GO
/****** Object:  StoredProcedure [dbo].[Roundup_Sx]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*-------------------------------------------------------------------------------
Copyright © Insite Software Solutions, Inc. 2009 - All Rights Reserved

Name: RoundUp_Sx - roundup of decimal input
Written By: Bill Behning
Dated: 11/01/2009

Revision History
----------------
--------------------------------------------------------------------------------*/

create PROCEDURE [dbo].[Roundup_Sx]
	@test decimal(18,6),
	@DecimalPlace real,
	@returnValue decimal(18,6) output
as
begin

declare @roundToNearest decimal(18,6)
declare @offset decimal (18,6)

set @roundToNearest = round(@test,@DecimalPlace)

-- get the decimals
set @offset = @test - @roundToNearest

if @test = @roundToNearest
begin
	-- no rounding occured
	set @returnValue = @test
end
else if @offset > 0	-- test number was larger - round up
begin
	-- add the offest to the rounded down numbner
	set @returnvalue = @roundToNearest + power(10.000000,-@decimalplace)
end
else
	-- naturally rounded up
	set @returnValue = @roundToNearest

--select @test 'Input'
--select @decimalplace 'decimalplace'

--select @roundToNearest  'Round_to__nearest'
--select @returnvalue 'Round_up'
end

GO
/****** Object:  StoredProcedure [dbo].[TableSpaceUsed]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[TableSpaceUsed]
AS

-- Create the temporary table...
CREATE TABLE #tblResults
(
   [name]   nvarchar(200),
   [rows]   int,
   [reserved]   varchar(180),
   [reserved_int]   int default(0),
   [data]   varchar(180),
   [data_int]   int default(0),
   [index_size]   varchar(180),
   [index_size_int]   int default(0),
   [unused]   varchar(180),
   [unused_int]   int default(0)
)


-- Populate the temp table...
EXEC sp_MSforeachtable @command1=
         "INSERT INTO #tblResults
           ([name],[rows],[reserved],[data],[index_size],[unused])
          EXEC sp_spaceused '?'"
   
-- Strip out the " KB" portion from the fields
UPDATE #tblResults SET
   [reserved_int] = CAST(SUBSTRING([reserved], 1, 
                             CHARINDEX(' ', [reserved])) AS int),
   [data_int] = CAST(SUBSTRING([data], 1, 
                             CHARINDEX(' ', [data])) AS int),
   [index_size_int] = CAST(SUBSTRING([index_size], 1, 
                             CHARINDEX(' ', [index_size])) AS int),
   [unused_int] = CAST(SUBSTRING([unused], 1, 
                             CHARINDEX(' ', [unused])) AS int)
   
-- Return the results...
SELECT * FROM #tblResults




GO
/****** Object:  StoredProcedure [dbo].[UpdateItemCustPrice_Batch]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Bill Behning
-- Create date: 10/06/2010
-- Description:	Stored Procedure that accepts DataSet and Updates the PriceMatrix_batch table
--				Later used to update the PriceMatrix table
--				Ref : StoredProcedure [dbo].[UpdatePriceMatrix_Vantage]
-- =============================================

create PROCEDURE [dbo].[UpdateItemCustPrice_Batch] 
  @XMLString NVARCHAR(MAX) = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    DECLARE 
		@XMLHandle INT,
		@Message nvarchar(250)

	-- Delcare the table values
	declare 
		@item nvarchar(30),
		@cust_num nvarchar(7),
		@cont_price decimal(18, 8),
		@effect_date nvarchar(50),
		@brk_qty1 decimal(18, 8),
		@brk_qty2 decimal(18, 8),
		@brk_qty3 decimal(18, 8),
		@brk_qty4 decimal(18, 8),
		@brk_qty5 decimal(18, 8),
		@brk_price1 decimal(18, 8),
		@brk_price2 decimal(18, 8),
		@brk_price3 decimal(18, 8),
		@brk_price4 decimal(18, 8),
		@brk_price5 decimal(18, 8),
		@base_code1 nvarchar(2),
		@base_code2 nvarchar(2),
		@base_code3 nvarchar(2),
		@base_code4 nvarchar(2),
		@base_code5 nvarchar(2),
		@dol_percent1 nchar(1) ,
		@dol_percent2 nchar(1) ,
		@dol_percent3 nchar(1) ,
		@dol_percent4 nchar(1) ,
		@dol_percent5 nchar(1) ,
		@RowPointer nvarchar(36),
		@cust_item_seq int ,
		@include_tax_in_price tinyint
		

	set @Message = 'Starting UpdateCustPrice_batch'
	INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
			VALUES (0, 'Info', 'Pricing Refresh Stored Proc',@Message)

	DECLARE @refreshData TABLE
	(
		item nvarchar(30),
		cust_num nvarchar(7),
		cont_price decimal(18, 8),
		effect_date varchar(50),
		brk_qty1 decimal(18, 8),
		brk_qty2 decimal(18, 8),
		brk_qty3 decimal(18, 8),
		brk_qty4 decimal(18, 8) ,
		brk_qty5 decimal(18, 8),
		brk_price1 decimal(18, 8) ,
		brk_price2 decimal(18, 8) ,
		brk_price3 decimal(18, 8) ,
		brk_price4 decimal(18, 8) ,
		brk_price5 decimal(18, 8) ,
		base_code1 nvarchar(2) ,
		base_code2 nvarchar(2) ,
		base_code3 nvarchar(2) ,
		base_code4 nvarchar(2) ,
		base_code5 nvarchar(2) ,
		dol_percent1 nchar(1)  ,
		dol_percent2 nchar(1)  ,
		dol_percent3 nchar(1)  ,
		dol_percent4 nchar(1)  ,
		dol_percent5 nchar(1)  ,
		RowPointer nvarchar(36),
		cust_item_seq int ,
		include_tax_in_price tinyint
	)

	-- XML DataSet sent in
	IF NOT @XMLString IS NULL
	BEGIN
		EXEC sp_xml_preparedocument @XMLHandle output, @XMLString 
	
		INSERT INTO @refreshData
		SELECT
			item,cust_num,cont_price,effect_date,
			brk_qty1 ,brk_qty2 ,brk_qty3 ,brk_qty4 ,brk_qty5,
			brk_price1,brk_price2,brk_price3,brk_price4,brk_price5,
			base_code1,base_code2,base_code3,base_code4,base_code5,
			dol_percent1,dol_percent2,dol_percent3,dol_percent4,dol_percent5,
			RowPointer,cust_item_seq,include_tax_in_price
		FROM OPENXML (@XMLHandle, '/NewDataSet/Pricing',1) 
		WITH 
		(
			item nvarchar(30) 'item',
			cust_num nvarchar(7) 'cust_num',
			cont_price decimal(18, 8) 'cont_price',
			effect_date nvarchar(50) 'effect_date',
			brk_qty1 decimal(18, 8) 'brk_qty1',
			brk_qty2 decimal(18, 8) 'brk_qty2',
			brk_qty3 decimal(18, 8) 'brk_qty3',
			brk_qty4 decimal(18, 8) 'brk_qty4',
			brk_qty5 decimal(18, 8) 'brk_qty5',
			brk_price1 decimal(18, 8) 'brk_price1',
			brk_price2 decimal(18, 8) 'brk_price2',
			brk_price3 decimal(18, 8) 'brk_price3',
			brk_price4 decimal(18, 8) 'brk_price4',
			brk_price5 decimal(18, 8) 'brk_price5',
			base_code1 nvarchar(2) 'base_code1',
			base_code2 nvarchar(2) 'base_code2',
			base_code3 nvarchar(2) 'base_code3',
			base_code4 nvarchar(2) 'base_code4',
			base_code5 nvarchar(2) 'base_code5',
			--dol_percent1 nchar(1) 'base_code1',
			--dol_percent2 nchar(1) 'base_code2',
			--dol_percent3 nchar(1) 'base_code3',
			--dol_percent4 nchar(1) 'base_code4',
			--dol_percent5 nchar(1) 'base_code5',
			dol_percent1 nchar(1) 'dol_percent1',
			dol_percent2 nchar(1) 'dol_percent2',
			dol_percent3 nchar(1) 'dol_percent3',
			dol_percent4 nchar(1) 'dol_percent4',
			dol_percent5 nchar(1) 'dol_percent5',
			RowPointer nvarchar(36) 'RowPointer',
			cust_item_seq int 'cust_item_seq',
			include_tax_in_price tinyint 'include_tax_in_price'
		)

		IF @@ERROR <> 0
		begin
			set @Message = 'Error (' + @@ERROR + ')'
			INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
				VALUES (0, 'Error', 'Pricing Refresh Stored Proc',@Message)
			return
		end
	end

	DECLARE RefreshDataCursor CURSOR FOR SELECT * FROM @refreshData
	OPEN RefreshDataCursor
	WHILE 1 = 1
	BEGIN
		FETCH NEXT FROM RefreshDataCursor 
			INTO @item, @cust_num,@cont_price, @effect_date,
				@brk_qty1 ,@brk_qty2 ,@brk_qty3 ,@brk_qty4 ,@brk_qty5 ,
				@brk_price1,@brk_price2,@brk_price3,@brk_price4,@brk_price5,
				@base_code1,@base_code2,@base_code3,@base_code4,@base_code5,
				@dol_percent1,@dol_percent2,@dol_percent3,@dol_percent4,@dol_percent5,
				@RowPointer, @cust_item_seq ,@include_tax_in_price

		IF @@ERROR <>0
		begin
			set @Message = 'Error (' + @@ERROR + ')'
			INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
				VALUES (0, 'Error', 'Pricing Refresh Stored Proc',@Message)
			break
		end

		IF @@FETCH_STATUS <> 0
		begin
			BREAK
		end

		-- Locate the existing pricing batch  record
		Declare @exists int
		set @exists = 0
		select @exists = count(*) 
				from ItemCustPrice_Batch 
				where RowPointer = @RowPointer
		IF @@ERROR <>0
		begin
			set @Message = 'ItemCustPrice_Batch recored Exists query failed.  Error (' + @@ERROR + ')'
			INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
				VALUES (0, 'Error', 'Pricing Refresh Stored Proc',@Message)
			continue
		end

		if @exists = 0
		begin
			INSERT INTO ItemCustPrice_Batch
			   ([item] ,[cust_num],[cont_price],[effect_date]
			   ,[brk_qty1],[brk_qty2],[brk_qty3],[brk_qty4],[brk_qty5]
			   ,[brk_price1],[brk_price2],[brk_price3],[brk_price4],[brk_price5]
			   ,[base_code1],[base_code2],[base_code3],[base_code4],[base_code5]
			   ,[dol_percent1],[dol_percent2],[dol_percent3],[dol_percent4],[dol_percent5]
			   ,[RowPointer],[cust_item_seq],[include_tax_in_price])
			VALUES
			   (@item, @cust_num,@cont_price, cast(substring(@effect_date,1,10) as datetime),
				@brk_qty1 ,@brk_qty2 ,@brk_qty3 ,@brk_qty4 ,@brk_qty5 ,
				@brk_price1,@brk_price2,@brk_price3,@brk_price4,@brk_price5,
				@base_code1,@base_code2,@base_code3,@base_code4,@base_code5,
				@dol_percent1,@dol_percent2,@dol_percent3,@dol_percent4,@dol_percent5,
				@RowPointer, @cust_item_seq , @include_tax_in_price
				)

			IF @@ERROR <> 0
			begin
				set @Message = 'Insert PriceMatrix_Batch failed.  Error (' + @@ERROR + ')'
				INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
					VALUES (0, 'Error', 'Pricing Refresh Stored Proc',@Message)
				continue
			end

		end
		IF @@ERROR <>0
		begin
			set @Message = 'Update PriceMatrix_Batch failed.  Error (' + @@ERROR + ')'
			INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
				VALUES (0, 'Error', 'Pricing Refresh Stored Proc',@Message)
			continue
		end
		-- end of processing
	end

	CLOSE refreshDataCursor
	DEALLOCATE refreshDataCursor

	EXEC sp_xml_removedocument @XMLHandle
END

GO
/****** Object:  StoredProcedure [dbo].[UpdateItemPrice_Batch]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Bill Behning
-- Create date: 10/06/2010
-- Description:	Stored Procedure that accepts DataSet and Updates the PriceMatrix_batch table
--				Later used to update the PriceMatrix table
--				Ref : StoredProcedure [dbo].[UpdatePriceMatrix_Vantage]
-- =============================================


CREATE PROCEDURE [dbo].[UpdateItemPrice_Batch] 
  @XMLString NVARCHAR(MAX) = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    DECLARE 
		@XMLHandle INT,
		@Message nvarchar(250)

	-- Delcare the table values
	declare 
		@item nvarchar(30),
		@effect_date nvarchar(50),
		@curr_code nvarchar(3),
		@unit_price1 decimal(18,8),
		@unit_price2 decimal(18,8),
		@unit_price3 decimal(18,8),
		@unit_price4 decimal(18,8),
		@unit_price5 decimal(18,8),
		@unit_price6 decimal(18,8),
		@reprice tinyint,
		@brk_qty1 decimal(18, 8),
		@brk_qty2 decimal(18, 8),
		@brk_qty3 decimal(18, 8),
		@brk_qty4 decimal(18, 8),
		@brk_qty5 decimal(18, 8),
		@brk_price1 decimal(18, 8),
		@brk_price2 decimal(18, 8),
		@brk_price3 decimal(18, 8),
		@brk_price4 decimal(18, 8),
		@brk_price5 decimal(18, 8),
		@base_code1 nvarchar(2),
		@base_code2 nvarchar(2),
		@base_code3 nvarchar(2),
		@base_code4 nvarchar(2),
		@base_code5 nvarchar(2),
		@dol_percent1 nchar(1) ,
		@dol_percent2 nchar(1) ,
		@dol_percent3 nchar(1) ,
		@dol_percent4 nchar(1) ,
		@dol_percent5 nchar(1) ,
		@pricecode nvarchar(3) ,
		@RowPointer nvarchar(36)  

	set @Message = 'Starting UpdatePricing_batch'
	INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
			VALUES (0, 'Info', 'Pricing Refresh Stored Proc',@Message)

	DECLARE @refreshData TABLE
	(
		item nvarchar(30) ,
		effect_date nvarchar(50),
		curr_code nvarchar(3) ,
		unit_price1 decimal(18,8),
		unit_price2 decimal(18,8),
		unit_price3 decimal(18,8),
		unit_price4 decimal(18,8),
		unit_price5 decimal(18,8),
		unit_price6 decimal(18,8),
		reprice tinyint ,
		brk_qty1 decimal(18, 8) ,
		brk_qty2 decimal(18, 8) ,
		brk_qty3 decimal(18, 8) ,
		brk_qty4 decimal(18, 8) ,
		brk_qty5 decimal(18, 8) ,
		brk_price1 decimal(18, 8) ,
		brk_price2 decimal(18, 8) ,
		brk_price3 decimal(18, 8)  ,
		brk_price4 decimal(18, 8)  ,
		brk_price5 decimal(18, 8)  ,
		base_code1 nvarchar(2) ,
		base_code2 nvarchar(2) ,
		base_code3 nvarchar(2) ,
		base_code4 nvarchar(2) ,
		base_code5 nvarchar(2) ,
		dol_percent1 nchar(1)  ,
		dol_percent2 nchar(1)  ,
		dol_percent3 nchar(1)  ,
		dol_percent4 nchar(1)  ,
		dol_percent5 nchar(1)  ,
		pricecode nvarchar(3) ,
		RowPointer nvarchar(36)  
	)

	-- XML DataSet sent in
	IF NOT @XMLString IS NULL
	BEGIN
		EXEC sp_xml_preparedocument @XMLHandle output, @XMLString 
	
		INSERT INTO @refreshData
		SELECT
			item,effect_date,curr_code,
			unit_price1,unit_price2,unit_price3,unit_price4,unit_price5,unit_price6,
			reprice,
			brk_qty1 ,brk_qty2 ,brk_qty3 ,brk_qty4 ,brk_qty5,
			brk_price1,brk_price2,brk_price3,brk_price4,brk_price5,
			base_code1,base_code2,base_code3,base_code4,base_code5,
			dol_percent1,dol_percent2,dol_percent3,dol_percent4,dol_percent5,
			pricecode,RowPointer
		FROM OPENXML (@XMLHandle, '/NewDataSet/Pricing',1) 
		WITH 
		(
			item nvarchar(30) 'item',
			effect_date nvarchar(50) 'effect_date',
			curr_code nvarchar(3) 'curr_code',
			unit_price1 decimal(18,8) 'unit_price1',
			unit_price2 decimal(18,8) 'unit_price2',
			unit_price3 decimal(18,8) 'unit_price3',
			unit_price4 decimal(18,8) 'unit_price4',
			unit_price5 decimal(18,8) 'unit_price5',
			unit_price6 decimal(18,8) 'unit_price6',
			reprice tinyint 'reprice',
			brk_qty1 decimal(18, 8) 'brk_qty1',
			brk_qty2 decimal(18, 8) 'brk_qty2',
			brk_qty3 decimal(18, 8) 'brk_qty3',
			brk_qty4 decimal(18, 8) 'brk_qty4',
			brk_qty5 decimal(18, 8) 'brk_qty5',
			brk_price1 decimal(18, 8) 'brk_price1',
			brk_price2 decimal(18, 8) 'brk_price2',
			brk_price3 decimal(18, 8) 'brk_price3',
			brk_price4 decimal(18, 8) 'brk_price4',
			brk_price5 decimal(18, 8) 'brk_price5',
			base_code1 nvarchar(2) 'base_code1',
			base_code2 nvarchar(2) 'base_code2',
			base_code3 nvarchar(2) 'base_code3',
			base_code4 nvarchar(2) 'base_code4',
			base_code5 nvarchar(2) 'base_code5',
			dol_percent1 nchar(1) 'dol_percent1',
			dol_percent2 nchar(1) 'dol_percent2',
			dol_percent3 nchar(1) 'dol_percent3',
			dol_percent4 nchar(1) 'dol_percent4',
			dol_percent5 nchar(1) 'dol_percent5',
			--dol_percent1 nchar(1) 'base_code1',
			--dol_percent2 nchar(1) 'base_code2',
			--dol_percent3 nchar(1) 'base_code3',
			--dol_percent4 nchar(1) 'base_code4',
			--dol_percent5 nchar(1) 'base_code5',
			
			
			pricecode nvarchar(3) 'pricecode',
			RowPointer nvarchar(36)  'RowPointer'
		)

		IF @@ERROR <> 0
		begin
			set @Message = 'Error (' + @@ERROR + ')'
			INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
				VALUES (0, 'Error', 'Pricing Refresh Stored Proc',@Message)
			return
		end
	end

	DECLARE RefreshDataCursor CURSOR FOR SELECT * FROM @refreshData
	OPEN RefreshDataCursor
	WHILE 1 = 1
	BEGIN
		FETCH NEXT FROM RefreshDataCursor 
			INTO @item,@effect_date,@curr_code,
				@unit_price1,@unit_price2,@unit_price3,@unit_price4,@unit_price5,@unit_price6,
				@reprice,
				@brk_qty1 ,@brk_qty2 ,@brk_qty3 ,@brk_qty4 ,@brk_qty5 ,
				@brk_price1,@brk_price2,@brk_price3,@brk_price4,@brk_price5,
				@base_code1,@base_code2,@base_code3,@base_code4,@base_code5,
				@dol_percent1,@dol_percent2,@dol_percent3,@dol_percent4,@dol_percent5,
				@pricecode,@RowPointer

		IF @@ERROR <>0
		begin
			set @Message = 'Error (' + @@ERROR + ')'
			INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
				VALUES (0, 'Error', 'Pricing Refresh Stored Proc',@Message)
			break
		end

		IF @@FETCH_STATUS <> 0
		begin
			BREAK
		end

		-- Locate the existing pricing batch  record
		Declare @exists int
		set @exists = 0
		select @exists = count(*) 
				from ItemPrice_Batch 
				where RowPointer = @RowPointer
		IF @@ERROR <>0
		begin
			set @Message = 'ItemPrice_Batch recored Exists query failed.  Error (' + @@ERROR + ')'
			INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
				VALUES (0, 'Error', 'Pricing Refresh Stored Proc',@Message)
			continue
		end

		if @exists = 0
		begin
			INSERT INTO ItemPrice_Batch
			   (item ,effect_date,curr_code
			   ,unit_price1,unit_price2,unit_price3,unit_price4,unit_price5,unit_price6
			   ,reprice
			   ,brk_qty1,brk_qty2,brk_qty3,brk_qty4,brk_qty5
			   ,brk_price1,brk_price2,brk_price3,brk_price4,brk_price5
			   ,base_code1,base_code2,base_code3,base_code4,base_code5
			   ,dol_percent1,dol_percent2,dol_percent3,dol_percent4,dol_percent5
			   ,pricecode,RowPointer)
			VALUES
			   (@item, cast(substring(@effect_date,1,10) as datetime),@curr_code,
				isnull(@unit_price1,0),isnull(@unit_price2,0),isnull(@unit_price3,0),isnull(@unit_price4,0),isnull(@unit_price5,0),isnull(@unit_price6,0),
				isnull(@reprice,0),
				isnull(@brk_qty1 ,0),isnull(@brk_qty2 ,0),isnull(@brk_qty3 ,0),isnull(@brk_qty4 ,0),isnull(@brk_qty5 ,0),
				isnull(@brk_price1,0),isnull(@brk_price2,0),isnull(@brk_price3,0),isnull(@brk_price4,0),isnull(@brk_price5,0),
				@base_code1,@base_code2,@base_code3,@base_code4,@base_code5,
				@dol_percent1,@dol_percent2,@dol_percent3,@dol_percent4,@dol_percent5,
				@pricecode,@RowPointer
				)

			IF @@ERROR <> 0
			begin
				set @Message = 'Insert PriceMatrix_Batch failed.  Error (' + @@ERROR + ')'
				INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
					VALUES (0, 'Error', 'Pricing Refresh Stored Proc',@Message)
				continue
			end

		end
		IF @@ERROR <>0
		begin
			set @Message = 'Update PriceMatrix_Batch failed.  Error (' + @@ERROR + ')'
			INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
				VALUES (0, 'Error', 'Pricing Refresh Stored Proc',@Message)
			continue
		end
		-- end of processing
	end

	CLOSE refreshDataCursor
	DEALLOCATE refreshDataCursor

	EXEC sp_xml_removedocument @XMLHandle
END

GO
/****** Object:  StoredProcedure [dbo].[UpdatePriceFormula_Batch]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Bill Behning
-- Create date: 10/06/2010
-- Description:	Stored Procedure that accepts DataSet and Updates the PriceMatrix_batch table
--				Later used to update the PriceMatrix table
--				Ref : StoredProcedure [dbo].[UpdatePriceMatrix_Vantage]
-- =============================================

create PROCEDURE [dbo].[UpdatePriceFormula_Batch] 
  @XMLString NVARCHAR(MAX) = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    DECLARE 
		@XMLHandle INT,
		@Message nvarchar(100)

	-- Delcare the table values
	declare 
		@cust_pricecode nvarchar(3),
		@item_pricecode nvarchar(3),
		@priceformula nvarchar(3),
		@effect_date nvarchar(30),
		@curr_code nvarchar(3),
		@brk_qty1 decimal(18, 8),
		@brk_qty2 decimal(18, 8),
		@brk_qty3 decimal(18, 8),
		@brk_qty4 decimal(18, 8),
		@brk_qty5 decimal(18, 8),
		@brk_price1 decimal(18, 8),
		@brk_price2 decimal(18, 8),
		@brk_price3 decimal(18, 8),
		@brk_price4 decimal(18, 8),
		@brk_price5 decimal(18, 8),
		@base_code1 nvarchar(2),
		@base_code2 nvarchar(2),
		@base_code3 nvarchar(2),
		@base_code4 nvarchar(2),
		@base_code5 nvarchar(2),
		@dol_percent1 nchar(1) ,
		@dol_percent2 nchar(1) ,
		@dol_percent3 nchar(1) ,
		@dol_percent4 nchar(1) ,
		@dol_percent5 nchar(1) ,
		@first_base nvarchar(2),
		@first_dol_percent nchar(1),
		@first_price decimal(18,8),
		@RowPointer nvarchar(36)  

	set @Message = 'Starting UpdatePriceFormaula_batch'
	INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
			VALUES (0, 'Info', 'Pricing Refresh Stored Proc',@Message)

	DECLARE @refreshData TABLE
	( 
		priceformula nvarchar(3),
		effect_date nvarchar(30),		
		curr_code nvarchar(3),		
		cust_pricecode nvarchar(3),
		item_pricecode nvarchar(3),
		brk_qty1 decimal(18, 8) ,
		brk_qty2 decimal(18, 8) ,
		brk_qty3 decimal(18, 8) ,
		brk_qty4 decimal(18, 8) ,
		brk_qty5 decimal(18, 8) ,
		brk_price1 decimal(18, 8) ,
		brk_price2 decimal(18, 8) ,
		brk_price3 decimal(18, 8) ,
		brk_price4 decimal(18, 8) ,
		brk_price5 decimal(18, 8) ,
		base_code1 nvarchar(2),
		base_code2 nvarchar(2),
		base_code3 nvarchar(2),
		base_code4 nvarchar(2),
		base_code5 nvarchar(2),
		dol_percent1 nchar(1)  ,
		dol_percent2 nchar(1)  ,
		dol_percent3 nchar(1)  ,
		dol_percent4 nchar(1)  ,
		dol_percent5 nchar(1)  ,
		first_base nvarchar(2),
		first_dol_percent nchar(1),
		first_price decimal(18,8),
		rowpointer nvarchar(36) 
	)

	-- XML DataSet sent in
	IF NOT @XMLString IS NULL
	BEGIN
		EXEC sp_xml_preparedocument @XMLHandle output, @XMLString 
	
		INSERT INTO @refreshData
		SELECT
			priceformula,effect_date,curr_code,cust_pricecode,item_pricecode,
			brk_qty1 ,brk_qty2 ,brk_qty3 ,brk_qty4 ,brk_qty5,
			brk_price1,brk_price2,brk_price3,brk_price4,brk_price5,
			base_code1,base_code2,base_code3,base_code4,base_code5,
			dol_percent1,dol_percent2,dol_percent3,dol_percent4,dol_percent5,
			first_base,first_dol_percent,first_price,rowpointer
		FROM OPENXML (@XMLHandle, '/NewDataSet/Pricing',1) 
		WITH 
		(
			priceformula nvarchar(3) 'priceformula',			
			effect_date nvarchar(30) 'effect_date',
			curr_code nvarchar(3) 'curr_code',
			cust_pricecode nvarchar(3) 'cust_pricecode',
			item_pricecode nvarchar(3) 'item_pricecode',
			brk_qty1 decimal(18, 8) 'brk_qty1',
			brk_qty2 decimal(18, 8) 'brk_qty2',
			brk_qty3 decimal(18, 8) 'brk_qty3',
			brk_qty4 decimal(18, 8) 'brk_qty4',
			brk_qty5 decimal(18, 8) 'brk_qty5',
			brk_price1 decimal(18, 8) 'brk_price1',
			brk_price2 decimal(18, 8) 'brk_price2',
			brk_price3 decimal(18, 8) 'brk_price3',
			brk_price4 decimal(18, 8) 'brk_price4',
			brk_price5 decimal(18, 8) 'brk_price5',
			base_code1 nvarchar(2) 'base_code1',
			base_code2 nvarchar(2) 'base_code2',
			base_code3 nvarchar(2) 'base_code3',
			base_code4 nvarchar(2) 'base_code4',
			base_code5 nvarchar(2) 'base_code5',
			dol_percent1 nchar(1) 'dol_percent1',
			dol_percent2 nchar(1) 'dol_percent2',
			dol_percent3 nchar(1) 'dol_percent3',
			dol_percent4 nchar(1) 'dol_percent4',
			dol_percent5 nchar(1) 'dol_percent5',
			--dol_percent1 nchar(1) 'base_code1',
			--dol_percent2 nchar(1) 'base_code2',
			--dol_percent3 nchar(1) 'base_code3',
			--dol_percent4 nchar(1) 'base_code4',
			--dol_percent5 nchar(1) 'base_code5',
			first_base nvarchar(2) 'first_base',
			first_dol_percent nchar(1) 'first_dol_percent',
			first_price decimal(18,8) 'first_price',
			rowpointer nvarchar(36)  'rowpointer'
		)

		IF @@ERROR <> 0
		begin
			set @Message = 'Error (' + cast(@@ERROR as varchar(100)) + ')'
			INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
				VALUES (0, 'Error', 'Pricing Refresh Stored Proc',@Message)
			--return
		end
	end

	DECLARE RefreshDataCursor CURSOR FOR SELECT * FROM @refreshData
	OPEN RefreshDataCursor
	WHILE 1 = 1
	BEGIN
		FETCH NEXT FROM RefreshDataCursor 
			INTO @Priceformula,@effect_date,@curr_code,@cust_pricecode,@item_pricecode,
				@brk_qty1 ,@brk_qty2 ,@brk_qty3 ,@brk_qty4 ,@brk_qty5 ,
				@brk_price1,@brk_price2,@brk_price3,@brk_price4,@brk_price5,
				@base_code1,@base_code2,@base_code3,@base_code4,@base_code5,
				@dol_percent1,@dol_percent2,@dol_percent3,@dol_percent4,@dol_percent5,
				@first_base,@first_dol_percent,@first_price,@RowPointer

		IF @@ERROR <>0
		begin
			set @Message = 'Error ' + cast(@@ERROR as varchar(100))
			INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
				VALUES (0, 'Error', 'Pricing Refresh Stored Proc',@Message)
			break
		end

		IF @@FETCH_STATUS <> 0
		begin
			BREAK
		end

		-- Locate the existing pricing batch  record
		Declare @exists int
		set @exists = 0
		select @exists = count(*) 
				from PriceFormula_Batch 
				where priceformula = @priceformula and curr_code = @curr_code and cust_pricecode = @cust_pricecode and item_pricecode = @item_pricecode
		IF @@ERROR <>0
		begin
			set @Message = 'PriceFormula_Batch recored Exists query failed.  Error (' + @@ERROR + ')'
			INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
				VALUES (0, 'Error', 'Pricing Refresh Stored Proc',@Message)
			continue
		end

		if @exists = 0

--			set @Message = 'PriceFormula_Batch record values:' + ' priceformula,cust_pricecode,item_pricecode ,effect_date,curr_code,first_base,first_dol_percent,first_price,rowpointer' 
--			+ @priceformula + @cust_pricecode + @item_pricecode + cast(substring(@effect_date,1,10) as datetime) + @curr_code + @first_base + @first_dol_percent + @first_price + @RowPointer
--			INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
--				VALUES (0, 'Error', 'Pricing Refresh Stored Proc',@Message)
--			continue

		begin
			INSERT INTO PriceFormula_Batch
			   (priceformula,cust_pricecode,item_pricecode ,effect_date,curr_code
			   ,brk_qty1,brk_qty2,brk_qty3,brk_qty4,brk_qty5
			   ,brk_price1,brk_price2,brk_price3,brk_price4,brk_price5
			   ,base_code1,base_code2,base_code3,base_code4,base_code5
			   ,dol_percent1,dol_percent2,dol_percent3,dol_percent4,dol_percent5
			   ,first_base,first_dol_percent,first_price,rowpointer)
			VALUES
			   (@priceformula,@cust_pricecode,@item_pricecode, cast(substring(@effect_date,1,10) as datetime),@curr_code,
				@brk_qty1 ,@brk_qty2 ,@brk_qty3 ,@brk_qty4 ,@brk_qty5 ,
				@brk_price1,@brk_price2,@brk_price3,@brk_price4,@brk_price5,
				@base_code1,@base_code2,@base_code3,@base_code4,@base_code5,
				@dol_percent1,@dol_percent2,@dol_percent3,@dol_percent4,@dol_percent5,
				@first_base,@first_dol_percent,@first_price,@RowPointer)
				

			IF @@ERROR <> 0
			begin
				set @Message = 'Insert PriceMatrix_Batch failed.  Error (' + @@ERROR + ')'
				INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
					VALUES (0, 'Error', 'Pricing Refresh Stored Proc',@Message)
				continue
			end

		end
		IF @@ERROR <>0
		begin
			set @Message = 'Update PriceMatrix_Batch failed.  Error (' + @@ERROR + ')'
			INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
				VALUES (0, 'Error', 'Pricing Refresh Stored Proc',@Message)
			continue
		end
		-- end of processing
	end

	CLOSE refreshDataCursor
	DEALLOCATE refreshDataCursor

	EXEC sp_xml_removedocument @XMLHandle

end

GO
/****** Object:  StoredProcedure [dbo].[UpdatePriceMatrix_Batch]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Bill Behning
-- Create date: 10/06/2010
-- Description:	Stored Procedure that accepts DataSet and Updates the PriceMatrix_batch table
--				Later used to update the PriceMatrix table
--				Ref : StoredProcedure [dbo].[UpdatePriceMatrix_Epicor]
-- =============================================

--PriceMatrix.CustomerProductRecordType						KeyType.Guid, KeyType.Guid
--PriceMatrix.CustomerProductPriceCodeRecordType,           KeyType.Guid, KeyType.Code),
--PriceMatrix.CustomerRecordType,                           KeyType.Guid, KeyType.None),
--PriceMatrix.CustomerPriceCodeProductRecordType,           KeyType.Code, KeyType.Guid),
--PriceMatrix.CustomerPriceCodeProductPriceCodeRecordType,  KeyType.Code, KeyType.Code),
--PriceMatrix.CustomerPriceCodeRecordType,                  KeyType.Code, KeyType.None),
--PriceMatrix.ProductRecordType,                            KeyType.None, KeyType.Guid),
--PriceMatrix.ProductPriceCodeRecordType,					KeyType.None, KeyType.Code)


CREATE PROCEDURE [dbo].[UpdatePriceMatrix_Batch] 
  @XMLString NVARCHAR(MAX) = null,
  @RecordType nvarchar(50) = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET XACT_ABORT ON;

	SET NOCOUNT ON;
    DECLARE 
		@XMLHandle INT,
        @ProductName nvarchar(100),
		@PriceBasis nvarchar(100),
		@AdjustmentType nvarchar(100),
		@BreakQty nvarchar(100),
		@Amount nvarchar(100),
		@AltAmount nvarchar(100),
		@CustomerKeyType nvarchar(10),
		@ProductKeyType nvarchar(10),
		@ProductPriceCode nvarchar(100),
		@CustomerPriceCode nvarchar (100),
		@CustomerNumberSequence NVARCHAR(100),
		@CustomerNumber nvarchar(100),
		@CustomerSequence nvarchar(100),
		@Message nvarchar(100),
		@ActiveDate nvarchar(100),
		@DeactiveDate nvarchar(100)


	-- Delcare the table values
	declare @CurrencyCode nvarchar(50)
           ,@Warehouse nvarchar(50)
           ,@UnitOfMeasure nvarchar(50)
           ,@CustomerKeyPart nvarchar(50)
           ,@ProductKeyPart nvarchar(50)
           ,@Active datetime
           ,@Deactivate datetime
           ,@CalculationFlags nvarchar(50)
           ,@PriceBasis01 nvarchar(50)
           ,@PriceBasis02 nvarchar(50)
           ,@PriceBasis03 nvarchar(50)
           ,@PriceBasis04 nvarchar(50)
           ,@PriceBasis05 nvarchar(50)
           ,@PriceBasis06 nvarchar(50)
           ,@PriceBasis07 nvarchar(50)
           ,@PriceBasis08 nvarchar(50)
           ,@PriceBasis09 nvarchar(50)
           ,@PriceBasis10 nvarchar(50)
           ,@PriceBasis11 nvarchar(50)
           ,@AdjustmentType01 nvarchar(50)
           ,@AdjustmentType02 nvarchar(50)
           ,@AdjustmentType03 nvarchar(50)
           ,@AdjustmentType04 nvarchar(50)
           ,@AdjustmentType05 nvarchar(50)
           ,@AdjustmentType06 nvarchar(50)
           ,@AdjustmentType07 nvarchar(50)
           ,@AdjustmentType08 nvarchar(50)
           ,@AdjustmentType09 nvarchar(50)
           ,@AdjustmentType10 nvarchar(50)
           ,@AdjustmentType11 nvarchar(50)
           ,@BreakQty01 decimal(18,5)
           ,@BreakQty02 decimal(18,5)
           ,@BreakQty03 decimal(18,5)
           ,@BreakQty04 decimal(18,5)
           ,@BreakQty05 decimal(18,5)
           ,@BreakQty06 decimal(18,5)
           ,@BreakQty07 decimal(18,5)
           ,@BreakQty08 decimal(18,5)
           ,@BreakQty09 decimal(18,5)
           ,@BreakQty10 decimal(18,5)
           ,@BreakQty11 decimal(18,5)
           ,@Amount01 decimal(18,5)
           ,@Amount02 decimal(18,5)
           ,@Amount03 decimal(18,5)
           ,@Amount04 decimal(18,5)
           ,@Amount05 decimal(18,5)
           ,@Amount06 decimal(18,5)
           ,@Amount07 decimal(18,5)
           ,@Amount08 decimal(18,5)
           ,@Amount09 decimal(18,5)
           ,@Amount10 decimal(18,5)
           ,@Amount11 decimal(18,5)
           ,@AltAmount01 decimal(18,5)
           ,@AltAmount02 decimal(18,5)
           ,@AltAmount03 decimal(18,5)
           ,@AltAmount04 decimal(18,5)
           ,@AltAmount05 decimal(18,5)
           ,@AltAmount06 decimal(18,5)
           ,@AltAmount07 decimal(18,5)
           ,@AltAmount08 decimal(18,5)
           ,@AltAmount09 decimal(18,5)
           ,@AltAmount10 decimal(18,5)
           ,@AltAmount11 decimal(18,5)
           ,@erp_recordid nvarchar(100)

	DECLARE @refreshData TABLE
    (
		ProductName nvarchar(100),
		CurrencyCode nvarchar(50),
		WareHouse nvarchar(50),
		UnitOfMeasure nvarchar(50),
		PriceBasis nvarchar(100),
		AdjustmentType nvarchar(100),
		Amount nvarchar(100),
		Active nvarchar(100),
		Deactivate nvarchar(100),
		BreakQty nvarchar(100),
		AltAmount nvarchar(100),
		CustomerNumberSequence NVARCHAR(100),
		ProductPriceCode nvarchar(100),
		CustomerPriceCode nvarchar(100)
    )

	set @Message = 'Starting UpdatePriceMatrix_batch'
	INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
			VALUES (0, 'Info', 'Pricing Refresh Stored Proc',@Message)

	if @RecordType = 'Customer/Product'			
	begin		
		set @CustomerKeyType = 'Guid'
		set @ProductKeyType = 'Guid'
	end
	else if @RecordType = 'Customer/Product Price Code'			
	begin
		set @CustomerKeyType = 'Guid'
		set @ProductKeyType = 'Code'
	end
	else if @RecordType = 'Customer'							
	begin
		set @CustomerKeyType = 'Guid'
		set @ProductKeyType = 'None'
	end
	else if @RecordType = 'Customer Price Code/Product'			
	begin
		set @CustomerKeyType = 'Code'
		set @ProductKeyType = 'Guid'
	end
	else if @RecordType = 'Customer Price Code/Product Price Code'	
	begin
		set @CustomerKeyType = 'Code'
		set @ProductKeyType = 'Code'
	end
	else if @RecordType = 'Customer Price Code'					
	begin
		set @CustomerKeyType = 'Code'
		set @ProductKeyType = 'None'
	end
	else if @RecordType = 'Product'							
	begin
		set @CustomerKeyType = 'None'
		set @ProductKeyType = 'Guid'
	end
	else if @RecordType = 'Product Price Code'					
	begin
		set @CustomerKeyType = 'None'
		set @ProductKeyType = 'Code'
	end
	else
	begin
		-- Unknown RecordType
		set @Message = 'Invalid Record Type (' + isnull(@RecordType,'') + ')'
		INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
				VALUES (0, 'Info', 'Pricing Refresh Stored Proc',@Message)
		return
	end

	-- XML DataSet sent in
	IF NOT @XMLString IS NULL
	BEGIN
		EXEC sp_xml_preparedocument @XMLHandle output, @XMLString 
		
		INSERT INTO @refreshData
		SELECT
			ProductName,
			CurrencyCode ,
			Warehouse ,			
			UnitOfMeasure,
			PriceBasis,
			AdjustmentType,
			Amount,
			Active ,
			Deactivate ,
			BreakQty,
			AltAmount,
			CustomerNumberSequence ,
			ProductPriceCode,
			CustomerPriceCode
		FROM OPENXML (@XMLHandle, '/NewDataSet/Pricing',1) 
			WITH 
			(
				ProductName nvarchar(100) 'ProductName' ,
				CurrencyCode nvarchar(50) 'CurrencyCode',
				Warehouse nvarchar(50) 'Warehouse',
				UnitOfMeasure nvarchar(50) 'UnitOfMeasure',
				PriceBasis nvarchar(100) 'PriceBasis',
				AdjustmentType nvarchar(100) 'AdjustmentType',
				Amount nvarchar(100) 'Amount',
				Active nvarchar(100) 'Active',
				Deactivate nvarchar(100) 'Deactivate',
				BreakQty nvarchar(100) 'BreakQty',
				AltAmount nvarchar(100) 'AltAmount',
				CustomerNumberSequence NVARCHAR(100) 'CustomerNumberSequence',
				ProductPriceCode nvarchar(100) 'ProductPriceCode',
				CustomerPriceCode nvarchar(100) 'CustomerPriceCode'
			)

		IF @@ERROR <> 0
		begin
			set @Message = 'Error (' + @@ERROR + ')'
			INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
				VALUES (0, 'Error', 'Pricing Refresh Stored Proc',@Message)
			return

		end

		set @CalculationFlags = ''

		DECLARE RefreshDataCursor CURSOR FOR SELECT * FROM @refreshData
		OPEN RefreshDataCursor
		WHILE 1 = 1
		BEGIN
			FETCH NEXT FROM RefreshDataCursor 
				INTO @ProductName,@CurrencyCode,@WareHouse,@UnitOfMeasure,@PriceBasis,@AdjustmentType,@Amount,@ActiveDate,
						@DeactiveDate,@BreakQty,@AltAmount,@CustomerNumberSequence,@ProductPriceCode,@CustomerPriceCode


			IF @@ERROR <>0
			begin
				set @Message = 'Error (' + @@ERROR + ')'
				INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
					VALUES (0, 'Error', 'Pricing Refresh Stored Proc',@Message)
				break
			end

			IF @@FETCH_STATUS <> 0
			begin
				BREAK
			end

			if @CurrencyCode is null
			begin
				set @CurrencyCode = ''
			end

			if @WareHouse is null
			begin
				set @WareHouse = ''
			end

			if @UnitOfMeasure is null
			begin
				set @UnitOfMeasure = ''
			end

			set @Active = null
			set @Deactivate = null
			
			if isnull(@ActiveDate,'') = ''
			begin
				set @Active = GetDate()
			end
			else if isdate(@ActiveDate) = 1
			begin
				set @Active = cast(@ActiveDate as datetime)
			end
			else
			begin
				set @Message = 'ActiveDate = ' + isnull(@ActiveDate,'')
				INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
					VALUES (0, 'Error', 'Pricing Refresh Stored Proc',@Message)
		

				set @Message = 'Active Date is invalid ' + isnull(@ActiveDate,'') + ' for item ' + @ProductName
				INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
					VALUES (0, 'Info', 'Pricing Refresh Stored Proc',@Message)
				continue
			end										

			if isnull(@DeactiveDate,'') = ''
			begin
				set @DeactiveDate = null
			end
			else if isdate(@DeactiveDate) = 1
			begin
				set @Deactivate = cast(@DeactiveDate as datetime)
			end

			-- Get the CustomerKey value
			set @CustomerKeyPart = null;
			
			if @CustomerKeyType = 'None'
			begin
				set @CustomerKeyPart = ''
			end
			else if @CustomerKeyType = 'Code'
			begin
				set @CustomerKeyPart = @CustomerPriceCode
			end
			else if @CustomerKeyType = 'Guid'
			begin
				set @CustomerNumber = dbo.GetStringPart(@CustomerNumberSequence,':',1,'')
				set @CustomerSequence = dbo.GetStringPart(@CustomerNumberSequence,':',2,'')
								
				select @CustomerKeyPart = cast(customerid as nvarchar(100)) 
					from customer 
					where customernumber = @CustomerNumber and customerSequence = @CustomerSequence

				IF @@ERROR <>0
				begin
					set @Message = 'CustomerKeyPart query failed.  Error (' + @@ERROR + ')'
					INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
						VALUES (0, 'Error', 'Pricing Refresh Stored Proc',@Message)
					continue

				end
			end

			if @CustomerKeyPart is null
			begin
				set @Message = 'Unable to find customer key part for Customer Number ' + isnull(@CustomerNumber,'') + ', Sequence ' + isnull(@CustomerSequence,'')
				INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
					VALUES (0, 'Error', 'Pricing Refresh Stored Proc',@Message)
				continue
			end

			-- Get the ProductKey value
			set @ProductKeyPart = null
			if @ProductKeyType = 'None'
			begin
				set @ProductKeyPart = ''
			end
			else if @ProductKeyPart = 'Code'
			begin
				set @ProductKeyPart = @ProductPriceCode
			end
			else if @ProductKeyType = 'Guid'
			begin
				Select @ProductKeyPart = cast(productid as nvarchar(100))
					from product
					where product.name = @ProductName

				IF @@ERROR <>0
				begin
					set @Message = 'ProductKeyPart query failed.  Error (' + @@ERROR + ')'
					INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
						VALUES (0, 'Error', 'Pricing Refresh Stored Proc',@Message)
					continue
				end
			end

			if @ProductKeyPart is null
			begin
				set @Message = 'Unable to find Product key part for Product Number ' + isnull(@ProductName,'')
				INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
					VALUES (0, 'Info', @Message ,'Pricing Refresh Stored Proc')
				continue
			end

			-- Get the rest of the table values
			Declare @FieldNumber int, @FieldValue nvarchar(100)
			set @FieldNumber = 0
			WHILE @FieldNumber < 11
			BEGIN
				set @FieldNumber = @FieldNumber + 1
				
				if @FieldNumber = 1
				begin
					set @PriceBasis01 = dbo.GetStringPart(@PriceBasis,';',@FieldNumber,'')
					set @AdjustmentType01 = dbo.GetStringPart(@AdjustmentType,';',@FieldNumber,'')
					set @BreakQty01 = cast(dbo.GetStringPart(@BreakQty,';',@FieldNumber,'0') as decimal(18,5))
					set @Amount01 = cast(dbo.GetStringPart(@Amount,';',@FieldNumber,'0') as decimal(18,5))
					set @AltAmount01 = cast(dbo.GetStringPart(@AltAmount,';',@FieldNumber,'0') as decimal(18,5))
				end
				if @FieldNumber = 2
				begin
					set @PriceBasis02 = dbo.GetStringPart(@PriceBasis,';',@FieldNumber,'')
					set @AdjustmentType02 = dbo.GetStringPart(@AdjustmentType,';',@FieldNumber,'')
					set @BreakQty02 = cast(dbo.GetStringPart(@BreakQty,';',@FieldNumber,'0') as decimal(18,5))
					set @Amount02 = cast(dbo.GetStringPart(@Amount,';',@FieldNumber,'0') as decimal(18,5))
					set @AltAmount02 = cast(dbo.GetStringPart(@AltAmount,';',@FieldNumber,'0') as decimal(18,5))
				end
				if @FieldNumber = 3
				begin
					set @PriceBasis03 = dbo.GetStringPart(@PriceBasis,';',@FieldNumber,'')
					set @AdjustmentType03 = dbo.GetStringPart(@AdjustmentType,';',@FieldNumber,'')
					set @BreakQty03 = cast(dbo.GetStringPart(@BreakQty,';',@FieldNumber,'0') as decimal(18,5))
					set @Amount03 = cast(dbo.GetStringPart(@Amount,';',@FieldNumber,'0') as decimal(18,5))
					set @AltAmount03 = cast(dbo.GetStringPart(@AltAmount,';',@FieldNumber,'0') as decimal(18,5))
				end
				if @FieldNumber = 4
				begin
					set @PriceBasis04 = dbo.GetStringPart(@PriceBasis,';',@FieldNumber,'')
					set @AdjustmentType04 = dbo.GetStringPart(@AdjustmentType,';',@FieldNumber,'')
					set @BreakQty04 = cast(dbo.GetStringPart(@BreakQty,';',@FieldNumber,'0') as decimal(18,5))
					set @Amount04 = cast(dbo.GetStringPart(@Amount,';',@FieldNumber,'0') as decimal(18,5))
					set @AltAmount04= cast(dbo.GetStringPart(@AltAmount,';',@FieldNumber,'0') as decimal(18,5))
				end
				if @FieldNumber = 5
				begin
					set @PriceBasis05 = dbo.GetStringPart(@PriceBasis,';',@FieldNumber,'')
					set @AdjustmentType05 = dbo.GetStringPart(@AdjustmentType,';',@FieldNumber,'')
					set @BreakQty05 = cast(dbo.GetStringPart(@BreakQty,';',@FieldNumber,'0') as decimal(18,5))
					set @Amount05 = cast(dbo.GetStringPart(@Amount,';',@FieldNumber,'0') as decimal(18,5))
					set @AltAmount05 = cast(dbo.GetStringPart(@AltAmount,';',@FieldNumber,'0') as decimal(18,5))
				end
				if @FieldNumber = 6
				begin
					set @PriceBasis06 = dbo.GetStringPart(@PriceBasis,';',@FieldNumber,'')
					set @AdjustmentType06 = dbo.GetStringPart(@AdjustmentType,';',@FieldNumber,'')
					set @BreakQty06 = cast(dbo.GetStringPart(@BreakQty,';',@FieldNumber,'0') as decimal(18,5))
					set @Amount06 = cast(dbo.GetStringPart(@Amount,';',@FieldNumber,'0') as decimal(18,5))
					set @AltAmount06 = cast(dbo.GetStringPart(@AltAmount,';',@FieldNumber,'0') as decimal(18,5))
				end
				if @FieldNumber = 7
				begin
					set @PriceBasis07 = dbo.GetStringPart(@PriceBasis,';',@FieldNumber,'')
					set @AdjustmentType07 = dbo.GetStringPart(@AdjustmentType,';',@FieldNumber,'')
					set @BreakQty07 = cast(dbo.GetStringPart(@BreakQty,';',@FieldNumber,'0') as decimal(18,5))
					set @Amount07 = cast(dbo.GetStringPart(@Amount,';',@FieldNumber,'0') as decimal(18,5))
					set @AltAmount07 = cast(dbo.GetStringPart(@AltAmount,';',@FieldNumber,'0') as decimal(18,5))
				end
				if @FieldNumber = 8
				begin
					set @PriceBasis08 = dbo.GetStringPart(@PriceBasis,';',@FieldNumber,'')
					set @AdjustmentType08 = dbo.GetStringPart(@AdjustmentType,';',@FieldNumber,'')
					set @BreakQty08 = cast(dbo.GetStringPart(@BreakQty,';',@FieldNumber,'0') as decimal(18,5))
					set @Amount08 = cast(dbo.GetStringPart(@Amount,';',@FieldNumber,'0') as decimal(18,5))
					set @AltAmount08 = cast(dbo.GetStringPart(@AltAmount,';',@FieldNumber,'0') as decimal(18,5))
				end
				if @FieldNumber = 9
				begin
					set @PriceBasis09 = dbo.GetStringPart(@PriceBasis,';',@FieldNumber,'')
					set @AdjustmentType09 = dbo.GetStringPart(@AdjustmentType,';',@FieldNumber,'')
					set @BreakQty09 = cast(dbo.GetStringPart(@BreakQty,';',@FieldNumber,'0') as decimal(18,5))
					set @Amount09 = cast(dbo.GetStringPart(@Amount,';',@FieldNumber,'0') as decimal(18,5))
					set @AltAmount09 = cast(dbo.GetStringPart(@AltAmount,';',@FieldNumber,'0') as decimal(18,5))
				end
				if @FieldNumber = 10
				begin
					set @PriceBasis10 = dbo.GetStringPart(@PriceBasis,';',@FieldNumber,'')
					set @AdjustmentType10 = dbo.GetStringPart(@AdjustmentType,';',@FieldNumber,'')
					set @BreakQty10 = cast(dbo.GetStringPart(@BreakQty,';',@FieldNumber,'0') as decimal(18,5))
					set @Amount10 = cast(dbo.GetStringPart(@Amount,';',@FieldNumber,'0') as decimal(18,5))
					set @AltAmount10 = cast(dbo.GetStringPart(@AltAmount,';',@FieldNumber,'0') as decimal(18,5))
				end
				if @FieldNumber = 11
				begin
					set @PriceBasis11 = dbo.GetStringPart(@PriceBasis,';',@FieldNumber,'')
					set @AdjustmentType11 = dbo.GetStringPart(@AdjustmentType,';',@FieldNumber,'')
					set @BreakQty11 = cast(dbo.GetStringPart(@BreakQty,';',@FieldNumber,'0') as decimal(18,5))
					set @Amount11 = cast(dbo.GetStringPart(@Amount,';',@FieldNumber,'0') as decimal(18,5))
					set @AltAmount11 = cast(dbo.GetStringPart(@AltAmount,';',@FieldNumber,'0') as decimal(18,5))
				end
			end

			-- Locate the existing price matrix record
			Declare @exists int
			set @exists = 0
			select @exists = count(*) 
					from pricematrix_batch 
					where recordtype = @RecordType and 
						currencycode = @CurrencyCode and
						warehouse = @Warehouse and
						unitofmeasure = @UnitOfMeasure and
						customerkeypart = @CustomerKeyPart and
						productkeypart = @ProductKeyPart and
						active = @Active

			IF @@ERROR <>0
			begin
				set @Message = 'PriceMatrix_Batch Exists query failed.  Error (' + @@ERROR + ')'
				INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
					VALUES (0, 'Error', 'Pricing Refresh Stored Proc',@Message)
				continue
			end


			if @exists = 0
			begin
				INSERT INTO PriceMatrix_batch
				   ([RecordType],[CurrencyCode],[Warehouse],[UnitOfMeasure],
					[CustomerKeyPart],[ProductKeyPart],[Active],[Deactivate],[CalculationFlags],
					[PriceBasis01],[PriceBasis02],[PriceBasis03],[PriceBasis04],[PriceBasis05],[PriceBasis06],[PriceBasis07],[PriceBasis08],[PriceBasis09],[PriceBasis10],[PriceBasis11],
					[AdjustmentType01],[AdjustmentType02],[AdjustmentType03],[AdjustmentType04],[AdjustmentType05],[AdjustmentType06],[AdjustmentType07],[AdjustmentType08],[AdjustmentType09],[AdjustmentType10],[AdjustmentType11],
					[BreakQty01],[BreakQty02],[BreakQty03],[BreakQty04],[BreakQty05],[BreakQty06],[BreakQty07],[BreakQty08],[BreakQty09],[BreakQty10],[BreakQty11],
					[Amount01],[Amount02],[Amount03],[Amount04],[Amount05],[Amount06],[Amount07],[Amount08],[Amount09],[Amount10],[Amount11],
					[AltAmount01],[AltAmount02],[AltAmount03],[AltAmount04],[AltAmount05],[AltAmount06],[AltAmount07],[AltAmount08],[AltAmount09],[AltAmount10],[AltAmount11]
					)
				 VALUES
				   (@RecordType,@CurrencyCode,@Warehouse,@UnitOfMeasure,
					@CustomerKeyPart,@ProductKeyPart,@Active,@Deactivate,@CalculationFlags,
					@PriceBasis01,@PriceBasis02,@PriceBasis03,@PriceBasis04,@PriceBasis05,@PriceBasis06,@PriceBasis07,@PriceBasis08,@PriceBasis09,@PriceBasis10,@PriceBasis11,
					@AdjustmentType01,@AdjustmentType02,@AdjustmentType03,@AdjustmentType04,@AdjustmentType05,@AdjustmentType06,@AdjustmentType07,@AdjustmentType08,@AdjustmentType09,@AdjustmentType10,@AdjustmentType11,
					@BreakQty01,@BreakQty02,@BreakQty03,@BreakQty04,@BreakQty05,@BreakQty06,@BreakQty07,@BreakQty08,@BreakQty09,@BreakQty10,@BreakQty11,
					@Amount01,@Amount02,@Amount03,@Amount04,@Amount05,@Amount06,@Amount07,@Amount08,@Amount09,@Amount10,@Amount11,
					@AltAmount01,@AltAmount02,@AltAmount03,@AltAmount04,@AltAmount05,@AltAmount06,@AltAmount07,@AltAmount08,@AltAmount09,@AltAmount10,@AltAmount11
					)

				IF @@ERROR <> 0
				begin
					set @Message = 'Insert PriceMatrix_Batch failed.  Error (' + @@ERROR + ')'
					INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
						VALUES (0, 'Error', 'Pricing Refresh Stored Proc',@Message)
					continue
				end

			end
			else
			begin
				UPDATE PriceMatrix_batch
				   SET [Deactivate] = @Deactivate
					  ,[CalculationFlags] = @CalculationFlags
					  ,[PriceBasis01] = @PriceBasis01
					  ,[PriceBasis02] = @PriceBasis02
					  ,[PriceBasis03] = @PriceBasis03
					  ,[PriceBasis04] = @PriceBasis04
					  ,[PriceBasis05] = @PriceBasis05
					  ,[PriceBasis06] = @PriceBasis06
					  ,[PriceBasis07] = @PriceBasis07
					  ,[PriceBasis08] = @PriceBasis08
					  ,[PriceBasis09] = @PriceBasis09
					  ,[PriceBasis10] = @PriceBasis10
					  ,[PriceBasis11] = @PriceBasis11
					  ,[AdjustmentType01] = @AdjustmentType01
					  ,[AdjustmentType02] = @AdjustmentType02
					  ,[AdjustmentType03] = @AdjustmentType03
					  ,[AdjustmentType04] = @AdjustmentType04
					  ,[AdjustmentType05] = @AdjustmentType05
					  ,[AdjustmentType06] = @AdjustmentType06
					  ,[AdjustmentType07] = @AdjustmentType07
					  ,[AdjustmentType08] = @AdjustmentType08
					  ,[AdjustmentType09] = @AdjustmentType09
					  ,[AdjustmentType10] = @AdjustmentType10
					  ,[AdjustmentType11] = @AdjustmentType11
					  ,[BreakQty01] = @BreakQty01
					  ,[BreakQty02] = @BreakQty02
					  ,[BreakQty03] = @BreakQty03
					  ,[BreakQty04] = @BreakQty04
					  ,[BreakQty05] = @BreakQty05
					  ,[BreakQty06] = @BreakQty06
					  ,[BreakQty07] = @BreakQty07
					  ,[BreakQty08] = @BreakQty08
					  ,[BreakQty09] = @BreakQty09
					  ,[BreakQty10] = @BreakQty10
					  ,[BreakQty11] = @BreakQty11
					  ,[Amount01] = @Amount01
					  ,[Amount02] = @Amount02
					  ,[Amount03] = @Amount03
					  ,[Amount04] = @Amount04
					  ,[Amount05] = @Amount05
					  ,[Amount06] = @Amount06
					  ,[Amount07] = @Amount07
					  ,[Amount08] = @Amount08
					  ,[Amount09] = @Amount09
					  ,[Amount10] = @Amount10
					  ,[Amount11] = @Amount11
					  ,[AltAmount01] = @AltAmount01
					  ,[AltAmount02] = @AltAmount02
					  ,[AltAmount03] = @AltAmount03
					  ,[AltAmount04] = @AltAmount04
					  ,[AltAmount05] = @AltAmount05
					  ,[AltAmount06] = @AltAmount06
					  ,[AltAmount07] = @AltAmount07
					  ,[AltAmount08] = @AltAmount08
					  ,[AltAmount09] = @AltAmount09
					  ,[AltAmount10] = @AltAmount10
					  ,[AltAmount11] = @AltAmount11
					where recordtype = @RecordType and 
						currencycode = @CurrencyCode and
						warehouse = @Warehouse and
						unitofmeasure = @UnitOfMeasure and
						customerkeypart = @CustomerKeyPart and
						productkeypart = @ProductKeyPart and
						active = @Active

			end

			IF @@ERROR <>0
			begin
				set @Message = 'Update PriceMatrix_Batch failed.  Error (' + @@ERROR + ')'
				INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
					VALUES (0, 'Error', 'Pricing Refresh Stored Proc',@Message)
				continue
			end
		-- end of processing
		end

		CLOSE refreshDataCursor
		DEALLOCATE refreshDataCursor

		EXEC sp_xml_removedocument @XMLHandle

	END
end

GO
/****** Object:  StoredProcedure [dbo].[UpdatePricing_Batch]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Bill Behning
-- Create date: 10/06/2010
-- Description:	Stored Procedure that accepts DataSet and Updates the PriceMatrix_batch table
--				Later used to update the PriceMatrix table
--				Ref : StoredProcedure [dbo].[UpdatePriceMatrix_Vantage]
-- =============================================

CREATE PROCEDURE [dbo].[UpdatePricing_Batch] 
  @XMLString NVARCHAR(MAX) = null,
  @TableName nvarchar(50) = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	declare @Message nvarchar(100)

	set @Message = 'Starting UpdateCustPrice_batch for table ' + @TableName
	INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
			VALUES (0, 'Info', 'Pricing Refresh Stored Proc',@Message)

	if @TableName = 'ItemCustPrice'
	begin

		set @Message = 'Calling UpdateItemCustPrice_Batch'
		INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
				VALUES (0, 'Info', 'Pricing Refresh Stored Proc',@Message)

		exec UpdateItemCustPrice_Batch @XMLString

		set @Message = 'Finished UpdateItemCustPrice_Batch'
		INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
				VALUES (0, 'Info', 'Pricing Refresh Stored Proc',@Message)

	end
	else if @TableName = 'ItemPrice'
	begin
		set @Message = 'Calling UpdateItemPrice_Batch'
		INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
				VALUES (0, 'Info', 'Pricing Refresh Stored Proc',@Message)

		exec UpdateItemPrice_Batch @XMLString

		set @Message = 'Finished UpdateItemCust_Batch'
		INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
				VALUES (0, 'Info', 'Pricing Refresh Stored Proc',@Message)

	end
	else if @TableName = 'PriceFormula'
	begin
		set @Message = 'Calling UpdatePriceFormula_Batch'

		INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
				VALUES (0, 'Info', 'Pricing Refresh Stored Proc',@Message)

		exec UpdatePriceFormula_Batch @XMLString

		set @Message = 'Finished UpdatePriceFormula_Batch'
		INSERT INTO ApplicationLog (BatchNumber, Type, Source, Message)
				VALUES (0, 'Info', 'Pricing Refresh Stored Proc',@Message)

	end

end

GO
/****** Object:  Trigger [dbo].[ApplicationLog_InsteadOf_Insert]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[ApplicationLog_InsteadOf_Insert]
	ON  [dbo].[ApplicationLog]
	INSTEAD OF INSERT
AS 
BEGIN
	SET NOCOUNT ON;

	INSERT INTO ApplicationLog (BatchNumber, Source, Message, Type, ErrorCount) SELECT BatchNumber, Source, left(Message, 100000), Type, ErrorCount FROM INSERTED
END

IF EXISTS (SELECT * FROM SYS.TRIGGERS WHERE NAME = 'IntegrationJobLog_After_Insert')
DROP TRIGGER [IntegrationJobLog_After_Insert]
IF EXISTS (SELECT * FROM SYS.TRIGGERS WHERE NAME = 'IntegrationJobLog_InsteadOf_Insert')
DROP TRIGGER [IntegrationJobLog_InsteadOf_Insert]


SET ANSI_NULLS ON

GO
/****** Object:  Trigger [dbo].[Category_After_Delete]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Darwin Zins
-- Create date: 1/4/2011
-- Description:	If there are any child Categories, set their ParentId to Null
-- =============================================
CREATE TRIGGER [dbo].[Category_After_Delete]
   ON  [dbo].[Category] 
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    UPDATE Category SET ParentId = NULL WHERE ParentId IN (SELECT CategoryId FROM DELETED)	
	DELETE rm FROM RuleManager rm INNER JOIN DELETED d ON d.RuleManagerId = rm.RuleManagerId
END

GO
/****** Object:  Trigger [dbo].[Content_After_Update]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Peter Gaard
-- Create date: 8/25/2014
-- Description:	Content Change Trigger
-- =============================================
CREATE TRIGGER [dbo].[Content_After_Update] 
   ON  [dbo].[Content]
   AFTER INSERT,UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
	UPDATE p SET p.IndexStatus = 1 FROM Product p 
		JOIN Content c ON c.ContentManagerId = p.ContentManagerId
		JOIN INSERTED i ON i.ContentId = c.ContentId
		WHERE p.IndexStatus = 0	
END

GO
/****** Object:  Trigger [dbo].[Customer_After_Insert]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[Customer_After_Insert] 
   ON  [dbo].[Customer]
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    UPDATE c SET c.ParentId = p.CustomerId FROM Customer c 
		INNER JOIN INSERTED i ON i.CustomerId = c.CustomerId
		INNER JOIN Customer p ON p.CustomerNumber = c.CustomerNumber AND 
			p.CustomerId <> c.CustomerId AND 
			(p.ParentId IS NULL OR p.ParentId = p.CustomerId)

END

GO
/****** Object:  Trigger [dbo].[Customer_After_InsertUpdate]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[Customer_After_InsertUpdate] 
   ON  [dbo].[Customer]
   AFTER INSERT, UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	UPDATE c SET c.ModifyDate = GETDATE() FROM Customer c JOIN INSERTED i ON i.CustomerId = c.CustomerId

END

GO
/****** Object:  Trigger [dbo].[CustomerProduct_After_Update]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Peter Gaard
-- Create date: 8/25/2014
-- Description:	CustomerProduct Change Trigger
-- =============================================
CREATE TRIGGER [dbo].[CustomerProduct_After_Update] 
   ON  [dbo].[CustomerProduct]
   AFTER INSERT,UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    
	UPDATE p SET p.IndexStatus = 1 FROM Product p 		
		JOIN INSERTED i ON i.ProductId = p.ProductId
		WHERE p.IndexStatus = 0	
END

GO
/****** Object:  Trigger [dbo].[Dealer_After_Delete]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Darwin Zins
-- Create date: 5/2/2014
-- Description:	Delete contained ContentManager
-- =============================================
CREATE TRIGGER [dbo].[Dealer_After_Delete]
   ON  [dbo].[Dealer]
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    DELETE cm FROM ContentManager cm INNER JOIN DELETED d ON d.ContentManagerId = cm.ContentManagerId

END

GO
/****** Object:  Trigger [dbo].[EmailTemplate_After_Delete]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Darwin Zins
-- Create date: 4/7/2014
-- Description:	Delete contained ContentManager
-- =============================================
CREATE TRIGGER [dbo].[EmailTemplate_After_Delete]
   ON  [dbo].[EmailTemplate] 
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DELETE cm FROM ContentManager cm INNER JOIN DELETED d ON d.ContentManagerId = cm.ContentManagerId

END
GO
/****** Object:  Trigger [dbo].[NewsArticle_After_Delete]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[NewsArticle_After_Delete]
   ON  [dbo].[NewsArticle]
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    DELETE cm FROM ContentManager cm INNER JOIN DELETED d ON d.ContentManagerId = cm.ContentManagerId

END

GO
/****** Object:  Trigger [dbo].[OrderHistory_After_InsertUpdate]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[OrderHistory_After_InsertUpdate] 
   ON  [dbo].[OrderHistory]
   AFTER INSERT, UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	UPDATE o SET o.ModifyDate = GETDATE() FROM OrderHistory o JOIN INSERTED i ON i.OrderHistoryId = o.OrderHistoryId

END

GO
/****** Object:  Trigger [dbo].[Product_After_Delete]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[Product_After_Delete]
   ON  [dbo].[Product]
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    DELETE cm FROM ContentManager cm INNER JOIN DELETED d ON d.ContentManagerId = cm.ContentManagerId
    DELETE dm FROM DocumentManager dm INNER JOIN DELETED d ON d.DocumentManagerId = dm.DocumentManagerId

    -- When an deleting a StyleParent, null out StyleParentId on StyleChildren
	UPDATE p SET StyleParentId = NULL FROM Product p, DELETED d WHERE p.StyleParentId = d.ProductId
	
END

GO
/****** Object:  Trigger [dbo].[Product_After_Insert]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Peter Gaard
-- Create date: 08/25/2014
-- Description:	Product Insert Trigger
-- =============================================
CREATE TRIGGER [dbo].[Product_After_Insert]
   ON  [dbo].[Product]
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Set Product.IndexStatus to 1 when products and children are created
	UPDATE p SET p.IndexStatus = 1 FROM Product p JOIN INSERTED i ON 
		p.ProductId = i.ProductId OR p.ProductId = i.StyleParentId
		WHERE i.IndexStatus = 0	
END

GO
/****** Object:  Trigger [dbo].[Product_After_Update]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Darwin Zins
-- Create date: 08/18/2010
-- Description:	Product Update Trigger
-- =============================================
CREATE TRIGGER [dbo].[Product_After_Update]
   ON  [dbo].[Product]
   AFTER UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- When an update is made where the StyleClass is removed from the Product, null out StyleParentId on StyleChildren
	UPDATE p SET StyleParentId = NULL FROM Product p INNER JOIN INSERTED i ON i.ProductId = p.StyleParentId 
		INNER JOIN DELETED d ON d.ProductId = p.StyleParentId WHERE (NOT d.StyleClassId IS NULL) AND i.StyleClassId IS NULL

	-- Set Product.IndexStatus to 1 when products and children are updated, but not if IndexStatus is manually being set to 0
	UPDATE p SET p.IndexStatus = 1 FROM Product p JOIN DELETED d ON 
		p.ProductId = d.ProductId OR p.ProductId = d.StyleParentId
		WHERE d.IndexStatus = 0	
END

GO
/****** Object:  Trigger [dbo].[Review_After_Delete]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Darwin Zins
-- Create date: 4/7/2014
-- Description:	Delete contained ContentManager
-- =============================================
CREATE TRIGGER [dbo].[Review_After_Delete]
   ON  [dbo].[Review]
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    DELETE cm FROM ContentManager cm INNER JOIN DELETED d ON d.ContentManagerId = cm.ContentManagerId

END

GO
/****** Object:  Trigger [dbo].[Specification_After_Delete]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Darwin Zins
-- Create date: 4/7/2014
-- Description:	Delete contained ContentManager
-- =============================================
CREATE TRIGGER [dbo].[Specification_After_Delete]
   ON  [dbo].[Specification]
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    DELETE cm FROM ContentManager cm INNER JOIN DELETED d ON d.ContentManagerId = cm.ContentManagerId

END

GO
/****** Object:  Trigger [dbo].[UserProfile_After_Delete]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Darwin Zins
-- Create date: 08/19/2010
-- Description:	UserProfile Delete Trigger
-- =============================================
CREATE TRIGGER [dbo].[UserProfile_After_Delete]
   ON  [dbo].[UserProfile]
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
	DELETE p FROM aspnet_Profile p INNER JOIN  aspnet_Users u ON u.UserId = p.UserId INNER JOIN DELETED up ON up.UserName = u.UserName
	DELETE p FROM aspnet_Membership p INNER JOIN  aspnet_Users u ON u.UserId = p.UserId INNER JOIN DELETED up ON up.UserName = u.UserName
	DELETE p FROM aspnet_UsersInRoles p INNER JOIN  aspnet_Users u ON u.UserId = p.UserId INNER JOIN DELETED up ON up.UserName = u.UserName
	DELETE p FROM aspnet_Users p INNER JOIN DELETED up ON up.UserName = p.UserName

END

GO
/****** Object:  Trigger [dbo].[WebPage_After_Delete]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[WebPage_After_Delete]
   ON  [dbo].[WebPage]
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    DELETE cm FROM ContentManager cm INNER JOIN DELETED d ON d.ContentManagerId = cm.ContentManagerId

END

GO
/****** Object:  Trigger [dbo].[WebPageContent_After_Delete]    Script Date: 3/18/2016 10:25:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[WebPageContent_After_Delete]
   ON  [dbo].[WebPageContent]
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    DELETE cm FROM ContentManager cm INNER JOIN DELETED d ON d.ContentManagerId = cm.ContentManagerId

END

GO
