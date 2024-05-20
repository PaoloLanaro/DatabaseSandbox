-- Question 4
SELECT photos.id, photos.image_url, COUNT(comments.id) AS comments_count
FROM photos
	LEFT JOIN comments c ON photos.id = c.photo_id
GROUP BY photos.id, photos.image_url, photos.created_at
ORDER BY photos.created_at DESC;

-- Question 5
SELECT DISTINCT users.username
FROM users
JOIN photos ON users.id = photos.user_id
	LEFT OUTER JOIN likes ON photos.id = likes.photo_id
JOIN comments ON photos.id = comments.photo_id
WHERE likes.photo_id IS NULL 
ORDER BY users.username;

-- Question 6
SELECT COUNT(*) AS num_photos
FROM (
         SELECT DISTINCT photo_tags.photo_id
         FROM photo_tags
             JOIN tags ON photo_tags.tag_id = tags.id
         WHERE tags.tag_name = '#BU'
         INTERSECT
         SELECT DISTINCT photo_tags.photo_id
         FROM photo_tags
             JOIN tags ON photo_tags.tag_id = tags.id
         WHERE tags.tag_name = '#NEU'
     ) AS new_table;

-- Question 7
SELECT users.username AS username, comments.comment_text AS comment_text
FROM comments
        JOIN users ON comments.user_id = users.id
WHERE UPPER(comments.comment_text) LIKE '%COLLEGE%'
ORDER BY comments.created_at;

-- Question 8
SELECT users.username AS username, users.created_at AS created_on
FROM users
	LEFT OUTER JOIN photos ON users.id = photos.user_id
WHERE photos.user_id IS NULL
ORDER BY users.username;
