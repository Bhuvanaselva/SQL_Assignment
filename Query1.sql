USE world;

                  /* #SQL select query exercise */
                  
# 1. Get a query to return "Hello World", 123

SELECT "hello world" as message , 123 as id;

# 2. Get everything from the city table 

SELECT * FROM city;

# 3: Get everything on the cities whose district is "aceh"

SELECT * FROM city 
WHERE District = 'aceh';

# 4: Get only the name of the cities where the countrycode is "bfa"

SELECT Name FROM city 
WHERE CountryCode = 'bfa';

# 5: Get both the name and district of the cities where the countrycode is "tto"

SELECT Name, District FROM city
WHERE CountryCode = 'tto';

# 6: Get the name and district named as nm,dist from the cities where the countrycode is "arm"

SELECT Name as nm, District as dist FROM city 
WHERE CountryCode = 'arm';

# 7: Get the cities with a name that starts with "bor"

SELECT * FROM city
WHERE Name LIKE 'bor%';

# 8: Get the cities with a name that contains the string "orto"

SELECT * FROM city
WHERE Name LIKE '%orto%';

# 9: Get the cities that has a population below 1000

SELECT * FROM city 
WHERE Population <1000;

# 10: Get the unique countrycodes from the cities that has a population below 1000

SELECT DISTINCT CountryCode FROM city 
WHERE Population <1000;

# 11: Get the cities with the countrycode UKR that has more than 1000000 (one million) in population

SELECT * FROM city 
WHERE CountryCode = 'UKR' AND Population >1000000;

# 12: Get the cities with a population of below 200 or above 9500000 (9.5 million)

SELECT * FROM city 
WHERE Population <200 OR Population > 9500000;

# 13: Get the cities with the countrycodes TJK, MRT, AND, PNG, SJM

SELECT * FROM city 
WHERE CountryCode IN('TJK', 'MRT', 'AND','PNG','SJM');

# 14: Get the cities with a population between 200 and 700 inclusive

SELECT * FROM city 
WHERE Population BETWEEN 200 AND 700;

# 15: Get the countries with a population between 8000 and 20000 inclusive

SELECT * FROM country 
WHERE Population BETWEEN 8000 AND 20000;

# 16: Get the name of the countries with a independence year (indepyear) before year 0

SELECT Name FROM country 
WHERE indepyear < 0;

# 17: Get the countries that has no recorded independence year and a population above 1000000

SELECT * FROM country 
WHERE indepyear IS NULL 
AND Population > 1000000 ;

# 18: Get countries with a SurfaceArea below 10 and a defined LifeExpectancy

SELECT * FROM country 
WHERE  SurfaceArea < 10 
AND LifeExpectancy IS NOT NULL;

                  /* # SQL Join exercise */
# 1: Get the cities with a name starting with ping sorted by their population with the least populated cities first

SELECT * FROM city 
WHERE Name LIKE 'ping%' 
ORDER BY Population;

# 2: Get the cities with a name starting with ran sorted by their population with the most populated cities first

SELECT * FROM city 
WHERE Name LIKE 'ran%' 
ORDER BY Population DESC;

# 3: Count all cities
SELECT COUNT(*) FROM city;

# 4: Get the average population of all cities

SELECT AVG(Population) FROM city;

# 5: Get the biggest population found in any of the cities

SELECT MAX(Population) FROM city;

# 6: Get the smallest population found in any of the cities

SELECT MIN(Population) FROM city;

# 7: Sum the population of all cities with a population below 10000

SELECT SUM(Population) FROM city 
WHERE Population < 10000;

# 8: Count the cities with the countrycodes MOZ and VNM

SELECT COUNT(*) FROM city 
WHERE CountryCode IN( 'MOZ',  'VNM');

# 9: Get individual count of cities for the countrycodes MOZ and VNM

SELECT CountryCode, COUNT(*) as city_count FROM city 
WHERE CountryCode IN( 'MOZ',  'VNM')
GROUP BY CountryCode;

# 10: Get average population of cities in MOZ and VNM

SELECT CountryCode, AVG(Population) AS AvgPopulation
FROM City
WHERE CountryCode IN ('MOZ', 'VNM')
GROUP BY CountryCode;



# 11: Get the countrycodes with more than 200 cities

SELECT CountryCode, COUNT(*) as City_Count FROM city 
GROUP BY CountryCode 
HAVING City_Count > 200;

# 12: Get the countrycodes with more than 200 cities ordered by city count

SELECT CountryCode, COUNT(*) as city_count FROM city 
GROUP BY CountryCode 
HAVING city_count > 200 
ORDER BY city_count;


# 13: What language(s) is spoken in the city with a population between 400 and 500?

SELECT DISTINCT Language
FROM countrylanguage
INNER JOIN city 
ON countrylanguage.CountryCode = city.CountryCode
WHERE city.Population BETWEEN 400 AND 500;

# 14: What are the name(s) of the cities with a population between 500 and 600 people and the language(s) spoken in them

SELECT city.Name AS city_name, countrylanguage.language AS spoken_language, city.Population AS population
FROM city
JOIN countrylanguage ON city.CountryCode = countrylanguage.CountryCode
WHERE population BETWEEN 500 AND 600;

# 15: What names of the cities are in the same country as the city with a population of 122199 (including the that city itself)

SELECT Name FROM city 
WHERE countrycode = (SELECT countrycode FROM city WHERE population = 122199);

# 16. What names of the cities are in the same country as the city with a population of 122199 (excluding the that city itself)

SELECT Name FROM city
WHERE CountryCode = (SELECT CountryCode FROM city WHERE Population = 122199) 
AND Population <> 122199;

# 17.  What are the city names in the country where Luanda is capital?

SELECT Name FROM city
WHERE CountryCode = (SELECT CountryCode FROM country WHERE Capital = (SELECT ID FROM city WHERE Name = 'Luanda'));

# 18. What are the names of the capital cities in countries in the same region as the city named Yaren 

SELECT city.Name FROM city
JOIN country ON city.ID = country.Capital
WHERE country.Region = (SELECT Region FROM city WHERE Name = 'Yaren');

# 19. What unique languages are spoken in the countries in the same region as the city named Riga 

SELECT DISTINCT Language
FROM countrylanguage 
WHERE countrylanguage.CountryCode IN (SELECT Code FROM Country WHERE Region = 
                                     (SELECT Region FROM Country 
                                      WHERE Code = (SELECT CountryCode FROM City WHERE Name = 'Riga')));
                         
                         
# 20. Get the name of the most populous city

SELECT Name
FROM City
WHERE Population = (SELECT MAX(Population) FROM City);



