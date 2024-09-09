# E-Commerce Olist Analysis

Olist is a platform that assists small and medium-sized businesses in Brazil with selling on major marketplaces by offering integrated e-commerce, logistics, and management solutions. This analysis uses real anonymized commercial data between 2016 and 2018. This analysis focuses on three key areas: customer behaviour and pricing performance. 

## Customer Behaviour

### What is the geographical distribution of customers, and how does the average order value vary across different regions?

**Number of Customers Across Brazil:**  
  
![Pasted Graphic 3](https://github.com/user-attachments/assets/27fc18c0-1b07-4d5d-ad1f-007dbae3332d)

**Average Order Value Across Brazil:**   

![Pasted Graphic 2](https://github.com/user-attachments/assets/8df5ae9c-59c5-4bef-addb-56fadf25d6e8)  

The average order value is $137.75. The quartile breakdown is as follows: Q1 is $45.9, Q2 (median) is $86.9, and Q3 is $149.9. This indicates that the average is being skewed by a smaller number of very high-value orders.  

The blue map highlights the distribution of customers, with the highest concentration in southeastern Brazil, particularly around São Paulo and Rio de Janeiro. In contrast, the green map shows the average order value across regions, with the southeast still leading in value. Interestingly, while the number of customers in the northern parts of Brazil are low, the average order value in that area is higher compared to other regions.  

### How does customer retention impact overall sales and average order value on Olist?

90% of Olist's customers are one-time buyers, with these customers contributing to 80% of total orders and 85% of total sales. In contrast, only 2% of customers have made 3 or more purchases within the same time period. Interestingly, one-time customers tend to have a significantly higher average order value compared to repeat customers. On average, one-time customers spend 50% more per order than customers who make multiple purchases, as shown below:  
  
<img width="195" alt="Ordered" src="https://github.com/user-attachments/assets/f0e0ae7a-8fe9-40ff-819e-aad27652ae0e">

## Pricing Performance

### Are consumers price sensitive?  


Looking at the prices holistically, consumers overall show low price sensitivity, with a correlation value of 0.16 between price and the number of orders. However, certain product categories display higher levels of price sensitivity. For instance, customers of small appliances (home oven and coffee) and cine photo exhibit strong sensitivity, with correlation values ranging from 0.85 to 0.87. However, the number of products in these categories is small, making it more difficult to definitively assess price sensitivity. Other categories that demonstrate some degree of price sensitivity include industry, commerce and business, art, and food, with correlation values exceeding 0.5.


<img width="602" alt="PRODUCT CATEGORY" src="https://github.com/user-attachments/assets/98aa0417-ee3c-43d5-a069-104317862302">
<img width="877" alt="image" src="https://github.com/user-attachments/assets/e24c548d-9756-4952-a9c0-582a3478f123">  


### At what average order value do customers opt for installment payments, and how prevalent is this behaviour?

Customers opting for installment payments have an average order value of $199.06, while those paying in full average $123.21, indicating that higher-value purchases are more likely to be paid over time. Around 50% of orders were paid in installments. 

![Frequency of Payment Installments](https://github.com/user-attachments/assets/3fa502e0-91c1-4dfa-81b4-63bb84431544)  

## Recommendations & Next Steps

  1. **Improve Customer Retention:** Since 90% of customers are one-time buyers and they contribute the majority of sales, Olist should focus on converting these customers into repeat buyers. Developing loyalty programs, personalized offers, or subscription models could encourage more frequent purchases.  
  2. **Unlocking Northern Brazil:** The analysis reveals a high average order value in northern Brazil despite a lower customer count. This suggests untapped potential in this region. Expanding targeted marketing efforts and localized promotions could drive growth in less saturated regions like the northwest.
  



