cat("\014")
rm(list = ls())  
dev.off()  
 
#New exercises Part 1
rio_txt <- import("~/Desktop/expression.txt")
expression <- rio_txt
rio_txt <- import("~/Desktop/final_annotation.txt")
final_annotation <- rio_txt
rio_txt <- import("~/Desktop/methylation.txt")
methylation <- rio_txt

expression %>%
  rename (Probe=Gene)-> expression

expression %>%
  left_join(final_annotation) ->expression2

expression2 %>%
  left_join(methylation) ->expression2
expression2 %>%
filter(!(is.na(Expression) | is.na(Methylation)))->expression2

expression2 %>%
  pivot_wider(names_from = Region, values_from = Methylation)->expression3

expression3 %>%
  rename(Gene_body_meth=Gene_body, Promoter_meth=Promoter) ->expression3

#Clean up the data
expression3 %>%
  mutate(EndStart = End - Start) %>%
  arrange(EndStart) %>%
  filter(!(EndStart < 10000)) -> expression3

expression3 %>%
  filter(!(Promoter_meth == "-1"))->expression3

expression3 %>%
  filter(!str_detect(Probe, "^Gm"))->expression3

#Summarisations
expression3 %>%
  group_by(Chromosome)%>%
  summarise(meanExpression= mean(Expression))%>%
  select(meanExpression, Chromosome)

expression3$Gene_body_meth<- as.numeric(expression3$Gene_body_meth)
expression3$Promoter_meth<- as.numeric(expression3$Promoter_meth)

expression3 %>%
  group_by(Chromosome)%>%
  summarise(meanGeneMet= mean(Gene_body_meth), meanPromtMet= mean(Promoter_meth))%>%
  select(Chromosome, meanGeneMet, meanPromtMet)

expression3 %>%
  pivot_wider(names_from=Strand, values_from = Probe)->expression5

expression5 %>%
  filter(!(is.na(`+`)))%>%
  select(`+`)%>%
  nrow()

expression5 %>%
  filter(!(is.na(`-`)))%>%
  select(`-`)%>%
  nrow()

expression3 %>%
  mutate(HighExpression= Expression > 0)-> expression5

expression5 %>%
  filter(HighExpression == "TRUE")%>%
  summarise(medianGeneBody= median(Gene_body_meth), medianPromot= median(Promoter_meth))->expression5
  
#Part 2: plotting and visualisation
#Distributions
ggplot(expression3, aes(Gene_body_meth))+ geom_histogram(aes(y=..density..))
ggplot(expression3, aes(Expression))+ geom_histogram()+ geom_rect(xmin=-0.1, xmax=0.1, ymin=0, ymax=1100, color="red")

#Summaries
expression3%>%
  group_by(Chromosome)%>%
  summarise(meanGenBM=mean(Gene_body_meth))->expression7
ggplot(expression7, aes(Chromosome, meanGenBM))+geom_col()

expression3%>%
  arrange(desc(Expression))%>%
  slice(1:500)%>%
  rename(HighExpressed = Expression)-> expression7

expression3%>%
  arrange((Expression))%>%
  slice(1:500)%>%
  rename(LowExpressed = Expression)-> expression8

ggplot(expression7, aes(x= Chromosome, y=Promoter_meth, col= Chromosome)) + geom_point()

#Comparisons
ggplot(expression3, aes(x=Gene_body_meth, y=Promoter_meth, color=Expression))+ geom_point(alpha= 0.5, position= "jitter") +scale_color_gradient("Expression", low = "blue", high = "red")

ggplot(expression3, aes(x= Gene_body_meth, y= Expression))+ geom_point(alpha= 0.5, position= "jitter")

expression3 %>%
  filter(Expression >=	5.650535 | Expression <= -6.032713)%>%
  mutate(Expression2= if_else(str_detect(Expression, "-", negate= FALSE), "low", "high"))-> expression9
  
expression9$Expression2 <- as.factor(expression9$Expression2)
class(expression9$Expression2)

ggplot(expression9, aes(x= Expression2, y=Gene_body_meth)) + geom_violin(trim=FALSE)

expression9 %>%
  group_by(Expression2)%>%
  summarise(meanExpression= mean(Expression),sdExpression=sd(Expression))-> expression10

ggplot(expression10) + geom_bar(aes(x= Expression2, y= meanExpression), stat = "identity") + geom_errorbar(aes(x= Expression2, ymin= meanExpression - sdExpression, ymax= meanExpression + sdExpression))


       