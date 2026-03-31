#Question 1
SELECT quantityOnHand 
FROM item 
WHERE itemDescription = 'bottle of antibiotics';
#Question 2
SELECT volunteerName 
FROM volunteer 
WHERE volunteerTelephone 
NOT LIKE '2%' AND volunteerName NOT LIKE '%Jones';
#Question 3
SELECT volunteerName 
FROM volunteer 
JOIN assignment 
ON volunteer.volunteerId = assignment.volunteerId 
JOIN task 
ON assignment.taskCode = task.taskCode 
JOIN task_type
ON task_type.taskTypeId = task.taskTypeId
WHERE taskTypeName = 'transporting';
#Question 4
SELECT task.taskDescription 
FROM task 
LEFT JOIN assignment 
ON task.taskCode = assignment.taskCode 
WHERE assignment.taskCode IS NULL;
#Question 5
SELECT DISTINCT package_type.packageTypeName
FROM package_type
JOIN package 
ON package_type.packageTypeId = package.packageTypeId
JOIN package_contents 
ON package.packageId = package_contents.packageId
JOIN item 
ON package_contents.itemId = item.itemId
WHERE item.itemDescription LIKE '%bottle%';
#Question 6
SELECT item.itemDescription 
FROM item 
LEFT JOIN package_contents 
ON package_contents.itemId = item.itemId
WHERE package_contents.itemId IS NULL;
#Question 7
SELECT DISTINCT task.taskDescription 
FROM task 
JOIN assignment 
ON task.taskCode = assignment.taskCode 
JOIN volunteer 
ON assignment.volunteerId = volunteer.volunteerId 
WHERE volunteerAddress LIKE '%NJ%';
#Question 8
SELECT DISTINCT volunteer.volunteerName 
FROM volunteer 
JOIN assignment 
ON assignment.volunteerId = volunteer.volunteerId 
WHERE startDateTime >= '2021-01-01'
  AND startDateTime < '2021-07-01';
#Question 9
SELECT DISTINCT volunteer.volunteerName
FROM volunteer
JOIN assignment 
ON assignment.volunteerId = volunteer.volunteerId
JOIN task 
ON assignment.taskCode = task.taskCode
JOIN task_type
ON task_type.taskTypeId = task.taskTypeId
JOIN package 
ON task.taskCode = package.taskCode
JOIN package_contents 
ON package.packageId = package_contents.packageId
JOIN item 
ON package_contents.itemId = item.itemId
WHERE item.itemDescription LIKE '%spam%' AND taskTypeName = 'packing';
#Question 10
SELECT item.itemDescription
FROM item
JOIN package_contents 
ON item.itemId = package_contents.itemId
GROUP BY item.itemId, package_contents.packageId
HAVING SUM(item.itemValue * package_contents.itemQuantity) = 100;
#Question 11
SELECT task_status.taskStatusName, COUNT(DISTINCT volunteer.volunteerId) AS num_volunteers
FROM volunteer
JOIN assignment 
ON volunteer.volunteerId = assignment.volunteerId
JOIN task 
ON assignment.taskCode = task.taskCode
JOIN task_status
ON task.taskStatusId = task_status.taskStatusId
GROUP BY task_status.taskStatusName
ORDER BY num_volunteers DESC;
#Question 12
SELECT task.taskCode, SUM(package.packageWeight) AS totalWeight 
FROM task 
JOIN package ON task.taskCode = package.taskCode 
GROUP BY task.taskCode 
ORDER BY totalWeight DESC LIMIT 1;
#Question 13
SELECT COUNT(*) AS num_tasks 
FROM task 
JOIN task_type 
ON task.taskTypeId = task_type.taskTypeId 
WHERE task_type.taskTypeName != 'packing';
#Question 14
SELECT item.itemDescription
FROM item 
JOIN package_contents 
ON item.itemId = package_contents.itemId 
JOIN package 
ON package_contents.packageId = package.packageId 
JOIN task 
ON package.taskCode = task.taskCode 
JOIN assignment 
ON assignment.taskCode = task.taskCode 
JOIN volunteer
ON volunteer.volunteerId = assignment.volunteerId
GROUP BY item.itemId, item.itemDescription
HAVING COUNT(DISTINCT volunteer.volunteerId) < 3;
#Question 15
SELECT package.packageId, SUM(item.itemValue * package_contents.itemQuantity) AS totalValue FROM package 
JOIN package_contents
ON package_contents.packageId = package.packageId
JOIN item
ON package_contents.itemId = item.itemId
GROUP BY package.packageId
HAVING totalValue > 100
ORDER BY totalValue ASC;
