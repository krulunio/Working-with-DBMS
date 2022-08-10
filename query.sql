SELECT Main_part_number, Manufacturer, Category, Origin, Price, Deposit, Final_price, Quantity, Warehouse
FROM(
	SELECT *, Price+Deposit AS Final_price
	FROM(
		SELECT
			data.main_part_number AS Main_part_number,
			data.manufacturer AS Manufacturer,
			data.category AS Category,
			data.origin AS Origin,
			price.price AS Price,
			CAST(IFNULL(deposit.deposit,0) AS DECIMAL(9,2)) AS Deposit,
			REPLACE(quantity.quantity,">","") AS Quantity,
			quantity.warehouse AS Warehouse
		FROM
			data INNER JOIN price ON data.part_number = price.part_number
			LEFT JOIN deposit ON data.part_number = deposit.part_number
			INNER JOIN weight ON data.part_number = weight.part_number
			INNER JOIN quantity ON data.part_number = quantity.part_number
	) AS subquery1
	WHERE Warehouse IN ('A','H','J','3','9') AND Quantity <> 0
) AS subquery2
WHERE Final_price >=2;