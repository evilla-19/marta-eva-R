# **Using the R Tidyverse Packages** 
## **Highlights of these exercises** 
### **Task 1.**  Make a single tibble which has all of the data for methylation and expression in it, as well as the gene annotation information.  *Important*: to merge data they have to have the same name.   
`expression %>%
  rename (Probe=Gene)-> expression
  
expression %>%
  left_join(final_annotation) ->expression2

expression2 %>%
  left_join(methylation) ->expression2`  
![1](https://github.com/evilla-19/marta-eva-R/blob/master/Pictures/Exercises%202.%20Table1.png)
###**Task 2.** Clean up the data: filter out. *Filter(!__).* Examples:  
Remove any genes whose promoter methylation is -1: `filter(!(Promoter_meth == "-1"))`  
Remove any genes whose total length is less than 10kb: `filter(!(EndStart < 10000))`  
###**Task 3.** Number of rows with one condition (Genes on the strand +): 
`expression3 %>%
  pivot_wider(names_from=Strand, values_from = Probe)->expression5`
 `expression5 %>%
  filter(!(is.na(`-`)))%>%
  select(`-`)%>%
  nrow()`
 ![2](https://github.com/evilla-19/marta-eva-R/blob/master/Pictures/Exercises%202.%20Table%202.png)
###**Task 4.** Ploting and visualization: 
#### 1. Distributions of values for the methylation and expression datasets (draw a strong vertical line at 0 to show where we
made the distinction between high and low expressed genes).
![3](https://github.com/evilla-19/marta-eva-R/blob/master/Pictures/Exercises%202.%201.png)
![4](https://github.com/evilla-19/marta-eva-R/blob/master/Pictures/Exercises%202.%202.png)

#### 2. Mean gene body methylation level per chromosome. 
![5](https://github.com/evilla-19/marta-eva-R/blob/master/Pictures/Exercises%202.%203.png)

#### 3. Promoter methylation levels in the 500 highestexpressed genes by chromosome.  
![6](https://github.com/evilla-19/marta-eva-R/blob/master/Pictures/Exercises%202.%204.png)

#### 4. Scatterplot of the relationship between the Promoter methylation and the Gene body methylation.  
![7](https://github.com/evilla-19/marta-eva-R/blob/master/Pictures/Exercises%202.%205.png)

#### 5. Draw side-by-side violin plots of the distributions of gene body methylation for the high and low expressed sets. 
![8](https://github.com/evilla-19/marta-eva-R/blob/master/Pictures/Exercises%202.%207.png)

#### 6. Barplot showing the mean gene body methylation +/- stdev for the high and low expressed groups.  
![9](https://github.com/evilla-19/marta-eva-R/blob/master/Pictures/Exercises%202.%206.png)


 
  
  
