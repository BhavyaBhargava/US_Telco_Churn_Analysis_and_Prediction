# Churn Analysis and Prediction for US Telecom Data by IBM

## Project Overview
This project focuses on analyzing customer churn in the **IBM Cognos Churn Dataset**, with a special emphasis on the telecom industry. The primary goal is to leverage the existing dataset to gain insights into churn behavior and build a predictive machine learning (ML) model. The project seeks to create an optimized metric tailored specifically for telecom data, surpassing the effectiveness of the original "churn score" metric provided in the IBM Cognos dataset.

---

## Objectives
1. **Churn Analysis**:
   - Understand customer behavior based on metrics such as contract type, tenure, payment methods, and additional services (e.g., online security, tech support).
   - Identify patterns and key drivers of customer churn.

2. **ML Model Development**:
   - Build and train a machine learning model to predict the probability of a customer churning.
   - Optimize the model for telecom-specific customer metrics to ensure better predictive performance.

3. **Custom Metric Creation**:
   - Replace the existing "churn score" with a new, optimized churn metric designed specifically for the telecom industry.
   - Provide actionable insights to stakeholders for churn mitigation.

---

## Dataset Description
The IBM Cognos Churn Dataset contains customer data for churn analysis. Key fields include:
- **Demographics**: Gender, Senior Citizen status, Partner status, and Dependents.
- **Account Information**: Tenure, Contract type, Monthly charges, Total charges, Payment method.
- **Services Signed Up**: Internet service type, online security, device protection, etc.
- **Churn Indicator**: Whether the customer churned (`Yes`) or not (`No`).

---

## Key Features of the Project
### 1. Data Analysis:
   - **Exploratory Data Analysis (EDA)**:
     - Visualize patterns in churn behavior using heatmaps, bar charts, and scatter plots.
     - Analyze correlations between churn and other variables like tenure, monthly charges, and services signed up.
   - **Insights Extraction**:
     - Identify features that most influence churn (e.g., contract type, tenure length).

### 2. Machine Learning:
   - **Preprocessing**:
     - Handle missing values, normalize numerical features, and encode categorical data.
   - **Model Development**:
     - Train multiple models (e.g., Logistic Regression, Random Forest, Gradient Boosting) to predict churn probabilities.
     - Compare models using metrics such as accuracy, F1-score, and AUC-ROC.
   - **Feature Engineering**:
     - Engineer new features specific to the telecom industry (e.g., bundled service score, average tenure for a contract type).
   - **Optimization**:
     - Fine-tune the model for better predictive performance using hyperparameter tuning (e.g., GridSearch, RandomizedSearch).

### 3. Custom Churn Metric:
   - Introduce a custom churn probability score tailored for telecom customers.
   - Evaluate the effectiveness of the custom metric against the "churn score" metric from the dataset.

---

## Project Workflow
1. **Data Preparation**:
   - Import and clean the dataset.
   - Perform exploratory data analysis (EDA) to identify trends and outliers.
2. **Churn Analysis**:
   - Examine churn percentages and analyze churn-driving factors.
3. **Machine Learning Pipeline**:
   - Split the data into training and testing sets.
   - Train and evaluate models.
   - Select the best model and deploy it for churn prediction.
4. **Custom Metric Development**:
   - Derive a new churn metric optimized for telecom-specific data.
   - Validate the metric using domain knowledge and feedback loops.

---

## Technologies Used
- **Programming Languages**: Python, SQL
- **Libraries**:
  - Data Analysis: Pandas, NumPy
  - Data Visualization: Matplotlib, Seaborn
  - Machine Learning: Random Forest, Scikit-learn, XGBoost, LightGBM
  - Model Deployment: Flask, Streamlit (optional for web-based implementation)
- **Tools**: Jupyter Notebook, IBM Cognos Dataset, Microsoft Power BI
- **Version Control**: Git, GitHub
