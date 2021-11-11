CREATE DATABASE project2;
USE project2;

/* healthymaina a startup foodchain,
want to get data of different foods 
based on different criterias like
health conditions, region, diet, flavour
and so on, we have data of indianfoods and with that 
we will be helping them by data exploration.
The is from a reputed cooking website.
*/

-- selecting table for analysis

SELECT * 
FROM indianfood;

--checking for any duplicates in food name field as this is the main field


SELECT food_name
FROM indianfood
GROUP BY food_name
HAVING COUNT(food_name) > 1;

--there is no duplicate values

-- checking for distinct values in different fields

SELECT DISTINCT diet
FROM indianfood;

SELECT DISTINCT flavor_profile
FROM indianfood;

SELECT DISTINCT course
FROM indianfood;

SELECT DISTINCT state
FROM indianfood;

SELECT DISTINCT region
FROM indianfood;

/* conclusion
there are 2 different diet,
  4 different flavor_profile, 
  4 different course,
  25 different state,
  and 7 different region
*/

--foods based on cooking time and preparation time

-- super qucik recipes
SELECT food_name
FROM indianfood
WHERE prep_time <= 10
AND cook_time  <=10;


--qucik recipes

SELECT food_name
FROM indianfood
WHERE prep_time <= 20
AND cook_time  <=20;


--mediocre recipes

SELECT food_name
FROM indianfood
WHERE prep_time BETWEEN 20 AND 60
AND cook_time  BETWEEN 20 AND 60 
OR cook_time < 20

--lenghty recipes

SELECT food_name
FROM indianfood
WHERE prep_time >= 60
OR cook_time  >=60;

--foods with certain ingredients free from it

-- oil free foods

SELECT food_name
FROM indianfood
WHERE NOT ingredients  LIKE ('%oil%')
AND NOT ingredients LIKE ('%ghee%')
AND NOT ingredients LIKE ('%clarified butter%');

--for people with high cholestrol level and for those opting for no oil diet

--sugar free recipes
SELECT food_name
FROM indianfood
WHERE NOT ingredients  LIKE ('%sugar%')
AND NOT ingredients LIKE ('%sugar syrup%')
AND NOT ingredients LIKE ('%sjaggery%')
AND NOT ingredients LIKE ('%condensed milk%')
AND NOT ingredients LIKE ('%sweetned milk%')
AND NOT ingredients LIKE ('%powdered sugar%')
AND NOT flavor_profile = 'sweet';

--as people with diabetes shouldnt consume more sugar

--lactose free foods

SELECT food_name
FROM indianfood
WHERE NOT ingredients  LIKE ('%milk%')
AND NOT ingredients LIKE ('%yogurt%')
AND NOT ingredients LIKE ('%cottage cheese%')
AND NOT ingredients LIKE ('%condensed milk%');

--lactose free and sweet recipes
SELECT food_name
FROM indianfood
WHERE NOT ingredients  LIKE ('%milk%')
AND NOT ingredients LIKE ('%yogurt%')
AND NOT ingredients LIKE ('%cottage cheese%')
AND NOT ingredients LIKE ('%condensed milk%')
AND flavor_profile = 'sweet';

--lactose free and spicy recipes
SELECT food_name
FROM indianfood
WHERE NOT ingredients  LIKE ('%milk%')
AND NOT ingredients LIKE ('%yogurt%')
AND NOT ingredients LIKE ('%cottage cheese%')
AND NOT ingredients LIKE ('%condensed milk%')
AND flavor_profile = 'spicy';


--gluten free recipes
SELECT food_name
FROM indianfood
WHERE NOT ingredients  LIKE ('%maida flour%')
AND NOT ingredients LIKE ('%plain flour%')
AND NOT ingredients LIKE ('%semolina%')
AND NOT ingredients LIKE ('%maida%')
AND NOT ingredients LIKE ('%refined flour%')
AND NOT ingredients LIKE ('%wheat%');

--gluten free and sweet recipes
SELECT food_name
FROM indianfood
WHERE NOT ingredients  LIKE ('%maida flour%')
AND NOT ingredients LIKE ('%plain flour%')
AND NOT ingredients LIKE ('%semolina%')
AND NOT ingredients LIKE ('%maida%')
AND NOT ingredients LIKE ('%refined flour%')
AND NOT ingredients LIKE ('%wheat%')
AND flavor_profile = 'sweet';

--gluten free and spicy recipes
SELECT food_name
FROM indianfood
WHERE NOT ingredients  LIKE ('%maida flour%')
AND NOT ingredients LIKE ('%plain flour%')
AND NOT ingredients LIKE ('%semolina%')
AND NOT ingredients LIKE ('%maida%')
AND NOT ingredients LIKE ('%refined flour%')
AND NOT ingredients LIKE ('%wheat%')
AND flavor_profile = 'spicy';

--nuts free recipes
SELECT food_name
FROM indianfood
WHERE NOT ingredients  LIKE ('%nuts%')
AND NOT ingredients LIKE ('%dry fruits%');


--foods recipes based on region

--central
SELECT food_name
FROM indianfood
WHERE region = 'central'

--east
SELECT food_name
FROM indianfood
WHERE region = 'east'

--north
SELECT food_name
FROM indianfood
WHERE region = 'north'


--northeast
SELECT food_name
FROM indianfood
WHERE region = 'northeast'


--south
SELECT food_name
FROM indianfood
WHERE region = 'south'


--west
SELECT food_name
FROM indianfood
WHERE region = 'west'

-- foods based on diet
--vegetarian
SELECT food_name
FROM indianfood
WHERE diet = 'vegetarian'

--non vegetarian
SELECT food_name
FROM indianfood
WHERE diet = 'non vegetarian'

/* conclusion
based on the above foods the startup
can build their food menu and deliver
healthy food to every one irrespective of
any health condtion and grow their business.
*/

--end analysis
