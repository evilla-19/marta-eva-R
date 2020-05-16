# marta-eva-R
## R usage for tidy table formats
### Main functions used in these exercises  
Filter(): to find rows/cases where conditions are true.  
Arrange():to sort a variable in ascending order. Desc() in descending.  
Mutate():to add new variables or change existing ones  
Summarise(): to produce stratified summary statistics  
Select():to keep only the variables you mention  
Distinct(): to keep only unique rows from an input  
Separate(): to turn a single character column into multiple columns.  
Group_by(): to convert the existing table into a grouped one where operations are performed "by group"  

-	**Move rows to columns and viceversa**:  
Gather(): to move information from the columns to the rows. It takes multiple columns and gathers them into a single column by adding rows.  
Pivot_longer(): Same as gather()!  
Pivot_wider(): The inverse transformation!  

-	**Join tables**:  
Right_join(): to return all rows from the right table, and any rows with matching keys from the left table.  
Left_join(): to return all rows from the left table, and any rows with matching keys from the right table.

#### Important exercises  
Initial data: Database with 47211 observations of 7 variables. Variables: Organism, Groups, Size, Chromosomes, Organelles, Plasmids, Assemblies.  
![Table1]()
1. **Task**: Do any organisms containing a plasmid, also have more than one chromosome?  
Solution:  
***Filter according to plasmid and chromosome number, and select only the columns of interest***  
`genomes %>%
  filter(Plasmids > 0) %>%
  filter(Chromosomes > 1) %>% select(Organism, Chromosomes, Plasmids)`  
![First modification] ()

2. **Task**: Make a list of the 10 organisms with the largest genomes  
Solution: ***Sort Size in descending order and selecting the 10 first rows, and the columns of interes***  
`genomes %>%
  arrange(desc(Size)) %>%
  slice(1:10) %>%
  select(Organism, Size)`  
  ![Second modification] ()
 
 3. **Task**: Select only one organism for each chromosome number. When deduplicating keep only the smallest genome for each chromosome number. Exclude organisms with no listed chromosomes.  
 Solution: ***For each chromosome number, we select only one organism, that is going to be the one with the smallest genome because the size is sorted in ascending order***  
 `genomes %>%
  arrange(Size)%>%
  filter(Chromosomes > 0)%>%
  distinct(Chromosomes, .keep_all = TRUE)`  
  ![Thrid modification] () 
 
 Initial data: Database with 174 observations for 8 variables. ID and symbol of measurements in WT (n=3) and KO (n=3) samples.  
 4. **Task**: Tidy the data!  
 `tidy_data %>%
  gather(key="Sample", value, WT_1:KO_3)`  
 or  
 `tidy_data%>%
  pivot_longer(cols=WT_1:KO_3, names_to = "sample", values_to = "value")`  
 Solution: ***Same functions, maybe eassier to work with pivot_longer. To go back to the previous table, use the opposite function: pivot_wider***  
![Fourth modification]()
 
 

 




   
