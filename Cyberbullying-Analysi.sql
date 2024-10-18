--1.Distribution of Cyberbullying Types

SELECT 
  cyberbullying_type, 
  COUNT(*) AS total_tweets, 
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM 
  `cyberbullying-identification.analysis.cyberbullying_tweets`
WHERE cyberbullying_type != 'not_cyberbullying'
GROUP BY 
  cyberbullying_type
ORDER BY 
  total_tweets DESC;


--2. Long and Short Tweet Count

SELECT 
  cyberbullying_type, 
  COUNT(CASE WHEN LENGTH(tweet_text) > 100 THEN 1 END) AS long_tweet_count,
  COUNT(CASE WHEN LENGTH(tweet_text) < 10 THEN 1 END) AS short_tweet_count
FROM 
  `cyberbullying-identification.analysis.cyberbullying_tweets`
GROUP BY 
  cyberbullying_type
ORDER BY 
  long_tweet_count DESC, short_tweet_count DESC;  


--3.Prevalence of Key Cyberbullying Terms

SELECT 
    cyberbullying_type, 
    COUNT(*) AS num_tweets
FROM 
    `cyberbullying-identification.analysis.cyberbullying_tweets`
WHERE 
    REGEXP_CONTAINS(LOWER(tweet_text), r'\b(bully|attack|abuse|harass|troll)\b')
GROUP BY 
    cyberbullying_type
ORDER BY 
    num_tweets DESC;


--4.Top Hashtags in Tweets

SELECT 
    hashtag,
    COUNT(*) AS mention_count
FROM (
    SELECT 
        REGEXP_EXTRACT_ALL(tweet_text, r'#[A-Za-z0-9_]+') AS hashtags
    FROM 
        `cyberbullying-identification.analysis.cyberbullying_tweets`
)
CROSS JOIN UNNEST(hashtags) AS hashtag
GROUP BY 
    hashtag
ORDER BY 
    mention_count DESC
LIMIT 10;  


--5.Top Mentions in Tweets

SELECT 
    mention,
    COUNT(*) AS mention_count
FROM (
    SELECT 
        REGEXP_EXTRACT_ALL(tweet_text, r'@[A-Za-z0-9_]+') AS mentions
    FROM 
        `cyberbullying-identification.analysis.cyberbullying_tweets`
)
CROSS JOIN UNNEST(mentions) AS mention
GROUP BY 
    mention
ORDER BY 
    mention_count DESC
LIMIT 10;  

