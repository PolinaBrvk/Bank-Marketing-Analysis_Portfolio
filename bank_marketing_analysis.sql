-- this query calculates the success of the campaign by determining the percentage of customers
-- calculates who subscribed to a term deposit out of everyone who was contacted
SELECT
 COUNT(*) AS total_contacts, -- total of contacted during the campaign
 SUM(CASE WHEN Deposit_Subscription = TRUE THEN 1 ELSE 0 END)  AS total_subscribtions, -- number of customers who said 'yes'
 ROUND(100.0 * SUM(CASE WHEN Deposit_Subscription = TRUE THEN 1 ELSE 0 END)/ COUNT(*), 2) AS success_rate_percent
 FROM `bank-marketing-analysis-464418.bank_marketing.bank_data`;

 -- the calculation shows how effective the marketing campaign was by calculating the percentage of customers who subscribed to a term deposit after being contacted. The marketing campaign resulted in a success rate of 11.69%

 -- this query calculates the subscription rate by age group 
SELECT 
  CASE 
    WHEN age < 25 THEN 'Under 25'
    WHEN age BETWEEN 25 AND 34 THEN '25-34'
    WHEN age BETWEEN 35 AND 44 THEN '35-44'
    WHEN age BETWEEN 45 AND 54 THEN '45-54'
    WHEN age BETWEEN 55 AND 64 THEN '55-64'
    ELSE '65+' -- the CASE statement groups into age ranges to analyze subscription success by age
  END AS age_group,
   COUNT(*) AS total_customers,
  SUM(CASE WHEN deposit_subscription = TRUE THEN 1 ELSE 0 END) AS subscribers,
  ROUND(100.0 * SUM(CASE WHEN deposit_subscription = TRUE THEN 1 ELSE 0 END) / COUNT(*), 2) AS subscription_rate_percent
FROM 
  `bank-marketing-analysis-464418.bank_marketing.bank_data`
GROUP BY 
  age_group
ORDER BY 
  subscription_rate_percent DESC;

-- the 65+ age group had the highest subscription rate (~42%), while younger groups were less responsive. Older customers may be more financially cautious and interested in securing deposits. 


-- this query calculates the subscription rate by job
SELECT
  Job,
  COUNT(*) AS total_customers,
  SUM(CASE WHEN deposit_subscription = TRUE THEN 1 ELSE 0 END) AS subscribers,
  ROUND(100.0 * SUM(CASE WHEN deposit_subscription = TRUE THEN 1 ELSE 0 END)/ COUNT(*), 2) AS subscribtion_rate_percent
FROM 
  `bank-marketing-analysis-464418.bank_marketing.bank_data`
GROUP BY 
  Job
ORDER BY
subscribtion_rate_percent;
-- students and retired individuals, typically show higher subscription rates (23% and 29%), possibly reflecting financial priorities or available time to analyze and consider the offer

-- this query calculates the subscription rate by education
SELECT
  education,
  COUNT(*) AS total_customers,
  SUM(CASE WHEN deposit_subscription = TRUE THEN 1 ELSE 0 END) AS subscribers,
  ROUND(100.0 * SUM(CASE WHEN deposit_subscription = TRUE THEN 1 ELSE 0 END) / COUNT(*), 2) AS subscription_rate_percent
FROM
  `bank-marketing-analysis-464418.bank_marketing.bank_data`
GROUP BY
  education
ORDER BY
  subscription_rate_percent DESC;
-- higher education levels lead to higher subscription rates (15%), while lower or unknown education shows less interest.


-- this query analyzes how the call duration affects the subscription rate. it groups customers into five duration categories based on call time in seconds
SELECT
  CASE
    WHEN Contact_Duration_Seconds < 60 THEN '<1 min'
    WHEN Contact_Duration_Seconds BETWEEN 60 AND 179 THEN '1-3 min'
    WHEN Contact_Duration_Seconds BETWEEN 180 AND 299 THEN '3-5 min'
    WHEN Contact_Duration_Seconds BETWEEN 300 AND 599 THEN '5-10 min'
    ELSE '>10 min' -- the CASE groups call duration into time ranges to analyze subscription success by call length
  END AS duration_group,
  COUNT(*) AS total_customers,
  SUM(CASE WHEN deposit_subscription = TRUE THEN 1 ELSE 0 END) AS subscribers,
  ROUND(100.0 * SUM(CASE WHEN deposit_subscription = TRUE THEN 1 ELSE 0 END) / COUNT(*), 2) AS subscription_rate_percent
FROM
  `bank-marketing-analysis-464418.bank_marketing.bank_data`
GROUP BY 
  duration_group
ORDER BY 
  subscription_rate_percent DESC;
-- longer calls lead to higher subscription rates by increasing engagement, while shorter calls often lead to lower success due to rushed interactions.


-- this query analyzes how the number of contact attempts affects subscription probability
SELECT
  contact_count_current_campaign AS contact_attempts,
  COUNT(*) AS total_customers,
  SUM(CASE WHEN deposit_subscription = TRUE THEN 1 ELSE 0 END) AS subscribers,
  ROUND(100.0 * SUM(CASE WHEN deposit_subscription = TRUE THEN 1 ELSE 0 END) / COUNT(*), 2) AS subscription_rate_percent
FROM
  `bank-marketing-analysis-464418.bank_marketing.bank_data`
GROUP BY 
  contact_count_current_campaign
ORDER BY 
  subscription_rate_percent DESC;
-- customers contacted once or twice tend to have higher subscription rates


-- this query shows how subscription rates vary by the month customers were contacted
SELECT
  EXTRACT(MONTH FROM Contact_Day) AS contact_month, -- the EXTRACT statement was used to isolate the month from a full date
  COUNT(*) AS total_customers,
  SUM(CASE WHEN deposit_subscription = TRUE THEN 1 ELSE 0 END) AS subscribers,
  ROUND(100.0 * SUM(CASE WHEN deposit_subscription = TRUE THEN 1 ELSE 0 END) / COUNT(*), 2) AS subscription_rate_percent
FROM
  `bank-marketing-analysis-464418.bank_marketing.bank_data`
GROUP BY 
  contact_month
ORDER BY 
  subscription_rate_percent DESC;
-- May (52%), December (47%) and September (46%) are peak month for subscription success

-- this query compares subscription rates between customers who have loans and those who don’t
SELECT
  loan,
 COUNT(*) AS total_customers,
  SUM(CASE WHEN deposit_subscription = TRUE THEN 1 ELSE 0 END) AS subscribers,
  ROUND(100.0 * SUM(CASE WHEN deposit_subscription = TRUE THEN 1 ELSE 0 END) / COUNT(*), 2) AS subscription_rate_percent
FROM
  `bank-marketing-analysis-464418.bank_marketing.bank_data`
GROUP BY 
  loan
ORDER BY 
  subscription_rate_percent DESC;
-- customers without loans tend to have higher subscription rates (13%), while those with loans have lower interest in subscribing
SELECT
  housing AS housing_loan,
  COUNT (*) AS total_customers,
  SUM(CASE WHEN deposit_subscription = TRUE THEN 1 ELSE 0 END) AS subscribers,
  ROUND(100.0 * SUM(CASE WHEN deposit_subscription = TRUE THEN 1 ELSE 0 END) / COUNT(*), 2) AS subscription_rate_percent
FROM
  `bank-marketing-analysis-464418.bank_marketing.bank_data`
GROUP BY 
  housing
ORDER BY 
  subscription_rate_percent DESC;
-- customers without housing loans tend to have a higher subscribtion rates (17%)

