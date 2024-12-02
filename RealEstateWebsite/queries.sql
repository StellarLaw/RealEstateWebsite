-- 1) Find the addresses of all houses currently listed.
SELECT P.address
FROM Property P
JOIN House H ON P.address = H.address
JOIN Listings L ON P.address = L.address;

-- 2) Find the addresses and MLS numbers of all houses currently listed.
SELECT P.address, L.mlsNumber
FROM Property P
JOIN House H ON P.address = H.address
JOIN Listings L ON P.address = L.address;

-- 3) Find the addresses of all 3-bedroom, 2-bathroom houses currently listed.
SELECT P.address
FROM Property P
JOIN House H ON P.address = H.address
JOIN Listings L ON P.address = L.address
WHERE H.bedrooms = 3 AND H.bathrooms = 2;

-- 4) Find the addresses and prices of all 3-bedroom, 2-bathroom houses with prices in the range $100,000 to $250,000, with the results shown in descending order of price.
SELECT P.address, P.price
FROM Property P
JOIN House H ON P.address = H.address
WHERE H.bedrooms = 3 AND H.bathrooms = 2 AND P.price BETWEEN 100000 AND 250000
ORDER BY P.price DESC;

-- 5) Find the addresses and prices of all business properties that are advertised as office space in descending order of price.
SELECT P.address, P.price
FROM Property P
JOIN BusinessProperty BP ON P.address = BP.address
WHERE BP.type = 'Office'
ORDER BY P.price DESC;

-- 6) Find all the ids, names, and phones of all agents, together with the names of their firms and the dates when they started.
SELECT A.agentId, A.name AS agent_name, A.phone, F.name AS firm_name, A.dateStarted
FROM Agent A
JOIN Firm F ON A.firmId = F.id;

-- 7) Find all the properties currently listed by an agent with id "001" (or some other suitable id).
SELECT P.address, P.price
FROM Property P
JOIN Listings L ON P.address = L.address
WHERE L.agentId = 3; 

-- 8) Find all Agent.name-Buyer.name pairs where the buyer works with the agent, sorted alphabetically by Agent.name.
SELECT A.name AS agent_name, B.name AS buyer_name
FROM Works_With WW
JOIN Agent A ON WW.agentId = A.agentId
JOIN Buyer B ON WW.buyerId = B.id
ORDER BY A.name;

-- 9) For each agent, find the total number of buyers currently working with that agent (Agent.id-count pairs).
SELECT A.agentId, COUNT(WW.buyerId) AS buyer_count
FROM Agent A
LEFT JOIN Works_With WW ON A.agentId = WW.agentId
GROUP BY A.agentId;

-- 10) For a buyer (e.g., identified by id "001"), find all houses that meet the buyer's preferences, with the results shown in descending order of price.
SELECT P.address, P.price
FROM Property P
JOIN House H ON P.address = H.address
JOIN Buyer B ON B.id = 3
WHERE B.propertyType = 'House' 
  AND H.bedrooms = B.bedrooms 
  AND H.bathrooms = B.bathrooms 
  AND P.price BETWEEN B.minimumPreferredPrice AND B.maximumPreferredPrice
ORDER BY P.price DESC;
