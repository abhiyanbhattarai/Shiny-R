**DashBoard Using Shiny R**


---
**Shiny**

Shiny is a web application framework for the R programming language. It allows users to create interactive web applications using R and make them available to others through a web browser. Shiny uses a reactive programming model, which means that the user interface (UI) reacts to changes in the data and updates automatically, without the need for the user to manually refresh the page.

Link to shiny: [Shiny Official Website](https://shiny.rstudio.com/)


---


Package Installation:

- We need to install 2 packages to create a dashboard.

Here is the code to install those packages:

```
#Install shiny
install.packages("shiny")

#Install shinydashboard
install.packages("shinydashboard")

#Install ggplot2 to plot differnt graphs
install.packages("ggplot2")

#Install ggcorrplot to plot correlation between different attributes
install.packages("ggcorrplot")

```
Dataset used: **Wine Quality Dataset** 

Here, you can get information about this dataset from [here](https://archive.ics.uci.edu/ml/datasets/wine+quality).

We used white-wine data. Feel free to use any of them.

Here are some snapshots of our dashboard:

