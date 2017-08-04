library(ggplot2)
MG1 <- read.csv("Netlogo_MG_v1.csv")
Sharing1 <- read.csv("Netlogo_Sharing_v1.csv")
MGSharing1 <- read.csv("Netlogo_MGSharing_v1.csv")

MG2 <- read.csv("Netlogo_MG_v2.csv")
Sharing2 <- read.csv("Netlogo_Sharing_v2.csv")
MGSharing2 <- read.csv("Netlogo_MGSharing_v2.csv")

Sharing3 <- read.csv("Netlogo_Sharing_v3.csv")

MGSharing3 <- read.csv("Netlogo_MGSharing_v3.csv")

ggplot(data=MG1, aes(x=X.step., y=count.consumers, group=Population)) + 
  geom_line(aes(colour = Population))
ggsave("MG1_1.png")

ggplot(data=MG1, aes(x=X.step., y=profit, group=Population)) + 
  geom_line(aes(colour = Population))
ggsave("MG1_2.png")

ggplot(data=MG1, aes(x=X.step., y=count.consumers, group=X.run.number.)) + 
  geom_line(aes(colour = X.run.number.))
ggsave("MG1_3.png")

ggplot(data=MG1, aes(x=X.step., y=profit, group=X.run.number.)) + 
  geom_line(aes(colour = X.run.number.))
ggsave("MG1_4.png")

ggplot(data=MG1, aes(x=X.step., y=count.consumers, group=Population)) + 
  geom_line(aes(colour = X.run.number.))
ggsave("MG1_5.png")

ggplot(data=MG1, aes(x=X.step., y=profit, group=Population)) + 
  geom_line(aes(colour = X.run.number.))
ggsave("MG1_6.png")

ggplot(data=Sharing1, aes(x=X.step., y=count.producers, group=Population)) + 
  geom_line(aes(colour = Population))
ggsave("Sharing1_1.png")

ggplot(data=Sharing1, aes(x=X.step., y=consumers, group=Population)) + 
  geom_line(aes(colour = Population))
ggsave("Sharing1_2.png")

ggplot(data=Sharing1, aes(x=X.step., y=count.producers, group=X.run.number.)) + 
  geom_line(aes(colour = X.run.number.))
ggsave("Sharing1_3.png")

ggplot(data=Sharing1, aes(x=X.step., y=consumers, group=X.run.number.)) + 
  geom_line(aes(colour = X.run.number.))
ggsave("Sharing1_4.png")

ggplot(data=Sharing1, aes(x=X.step., y=count.producers, group=Population)) + 
  geom_line(aes(colour = X.run.number.))
ggsave("Sharing1_5.png")

ggplot(data=Sharing1, aes(x=X.step., y=consumers, group=Population)) + 
  geom_line(aes(colour = X.run.number.))
ggsave("Sharing1_6.png")

ggplot(data=MGSharing1, aes(x=X.step., y=count.producers, group=Population)) + 
  geom_line(aes(colour = Population))
ggsave("MGSharing1_1.png")

ggplot(data=MGSharing1, aes(x=X.step., y=consumers, group=Population)) + 
  geom_line(aes(colour = Population))
ggsave("MGSharing1_2.png")

ggplot(data=MGSharing1, aes(x=X.step., y=count.producers, group=X.run.number.)) + 
  geom_line(aes(colour = X.run.number.))
ggsave("MGSharing1_3.png")

ggplot(data=MGSharing1, aes(x=X.step., y=consumers, group=X.run.number.)) + 
  geom_line(aes(colour = X.run.number.))
ggsave("MGSharing1_4.png")

ggplot(data=MGSharing1, aes(x=X.step., y=count.producers, group=Population)) + 
  geom_line(aes(colour = X.run.number.))
ggsave("MGSharing1_5.png")
#############################################################################################
ggplot(data=MGSharing1, aes(x=X.step., y=consumers, group=Population)) + 
  geom_line(aes(colour = X.run.number.))
ggsave("MGSharing1_6.png")

ggplot(data=MG2, aes(x=X.step., y=count.consumers, group=Population)) + 
  geom_line(aes(colour = Population))
ggsave("MG2_1.png")

ggplot(data=MG2, aes(x=X.step., y=profit, group=Population)) + 
  geom_line(aes(colour = Population))
ggsave("MG2_2.png")

ggplot(data=MG2, aes(x=X.step., y=count.consumers, group=X.run.number.)) + 
  geom_line(aes(colour = X.run.number.))
ggsave("MG2_3.png")

ggplot(data=MG2, aes(x=X.step., y=profit, group=X.run.number.)) + 
  geom_line(aes(colour = X.run.number.))
ggsave("MG2_4.png")

ggplot(data=MG2, aes(x=X.step., y=count.consumers, group=Population)) + 
  geom_line(aes(colour = X.run.number.))
ggsave("MG2_5.png")

ggplot(data=MG2, aes(x=X.step., y=profit, group=Population)) + 
  geom_line(aes(colour = X.run.number.))
ggsave("MG2_6.png")

ggplot(data=Sharing2, aes(x=X.step., y=count.producers, group=Population)) + 
  geom_line(aes(colour = Population))
ggsave("Sharing2_1.png")

ggplot(data=Sharing2, aes(x=X.step., y=consumers, group=Population)) + 
  geom_line(aes(colour = Population))
ggsave("Sharing2_2.png")

ggplot(data=Sharing2, aes(x=X.step., y=count.producers, group=X.run.number.)) + 
  geom_line(aes(colour = X.run.number.))
ggsave("Sharing2_3.png")

ggplot(data=Sharing2, aes(x=X.step., y=consumers, group=X.run.number.)) + 
  geom_line(aes(colour = X.run.number.))
ggsave("Sharing2_4.png")

ggplot(data=Sharing2, aes(x=X.step., y=count.producers, group=Population)) + 
  geom_line(aes(colour = X.run.number.))
ggsave("Sharing2_5.png")

ggplot(data=Sharing2, aes(x=X.step., y=consumers, group=Population)) + 
  geom_line(aes(colour = X.run.number.))
ggsave("Sharing2_6.png")

ggplot(data=MGSharing2, aes(x=X.step., y=count.producers, group=Population)) + 
  geom_line(aes(colour = Population))
ggsave("MGSharing2_1.png")

ggplot(data=MGSharing2, aes(x=X.step., y=consumers, group=Population)) + 
  geom_line(aes(colour = Population))
ggsave("MGSharing2_2.png")

ggplot(data=MGSharing2, aes(x=X.step., y=count.producers, group=X.run.number.)) + 
  geom_line(aes(colour = X.run.number.))
ggsave("MGSharing2_3.png")

ggplot(data=MGSharing2, aes(x=X.step., y=consumers, group=X.run.number.)) + 
  geom_line(aes(colour = X.run.number.))
ggsave("MGSharing2_4.png")

ggplot(data=MGSharing2, aes(x=X.step., y=count.producers, group=Population)) + 
  geom_line(aes(colour = X.run.number.))
ggsave("MGSharing2_5.png")

ggplot(data=MGSharing2, aes(x=X.step., y=consumers, group=Population)) + 
  geom_line(aes(colour = X.run.number.))
ggsave("MGSharing2_6.png")

##########################################################################
ggplot(data=MG2, aes(x=X.step., y=profit, group=subsidy.rooftop)) + 
  geom_line(aes(colour = subsidy.rooftop))
ggsave("MGS2_8.png")

ggplot(data=MGSharing2, aes(x=X.step., y=count.producers, group=subsidy.rooftop)) + 
  geom_line(aes(colour = subsidy.rooftop))
ggsave("MGSharing2_8.png")

ggplot(data=Sharing3, aes(x=X.step., y=count.producers, group=subsidy.rooftop)) + 
  geom_line(aes(colour = subsidy.rooftop))
ggsave("Sharing3_8.png")

##########################################################################
ggplot(data=Sharing3, aes(x=X.step., y=consumers, group=subsidy.rooftop)) + 
  geom_line(aes(colour = subsidy.rooftop))
ggsave("Sharing3_7.png")

Sharing3_small <- Sharing3[which(Sharing3$subsidy.rooftop == "FALSE"),]

ggplot(data=Sharing3_small, aes(x=X.step., y=consumers, group=subsidy.rooftop)) + 
  geom_line(aes(colour = subsidy.rooftop))
ggsave("Sharing3_7.png")

########################################################################
ggplot(data=MGSharing3, aes(x=X.step., y=consumers, group=subsidy.rooftop)) + 
  geom_line(aes(colour = subsidy.rooftop))
ggsave("MGSharing3_7.png")

ggplot(data=MGSharing3, aes(x=X.step., y=count.producers, group=subsidy.rooftop)) + 
  geom_line(aes(colour = subsidy.rooftop))
ggsave("MGSharing3_8.png")

MGSharing3_small <- MGSharing1[which(MGSharing1$subsidy.rooftop == "FALSE"),]

ggplot(data=MGSharing3_small, aes(x=X.step., y=consumers, group=Population)) + 
  geom_line(aes(colour = Population))
ggsave("MGSharing3_1.png")

ggplot(data=MGSharing3_small, aes(x=X.step., y=count.producers, group=Population)) + 
  geom_line(aes(colour = Population))
ggsave("MGSharing3_2.png")

Sharing3_small <- Sharing1[which(Sharing1$subsidy.rooftop == "FALSE"),]

ggplot(data=Sharing3_small, aes(x=X.step., y=consumers, group=Population)) + 
  geom_line(aes(colour = Population))
ggsave("Sharing3_1.png")

ggplot(data=Sharing3_small, aes(x=X.step., y=count.producers, group=Population)) + 
  geom_line(aes(colour = Population))
ggsave("Sharing3_2.png")

MG3_small <- MG1[which(MG1$subsidy.rooftop == "FALSE"),]

ggplot(data=MG3_small, aes(x=X.step., y=count.consumers, group=Population)) + 
  geom_line(aes(colour = Population))
ggsave("MG3_1.png")

ggplot(data=MG3_small, aes(x=X.step., y=profit, group=Population)) + 
  geom_line(aes(colour = Population))
ggsave("MG3_2.png")

#########################################################################
MGSharing4 <- read.csv("Netlogo_MGSharing_v4.csv")

ggplot(data=MGSharing4, aes(x=X.step., y=count.producers, group=demand.rise)) + 
  geom_line(aes(colour = demand.rise))
ggsave("MGSharing4_1.png")

ggplot(data=MGSharing4, aes(x=X.step., y=consumers, group=demand.rise)) + 
  geom_line(aes(colour = demand.rise))
ggsave("MGSharing4_2.png")

#########################################################################
Sharing4 <- read.csv("Netlogo_Sharing_v4.csv")

ggplot(data=Sharing4, aes(x=X.step., y=count.producers, group=demand.rise)) + 
  geom_line(aes(colour = demand.rise))
ggsave("Sharing4_1.png")

ggplot(data=Sharing4, aes(x=X.step., y=consumers, group=demand.rise)) + 
  geom_line(aes(colour = demand.rise))
ggsave("Sharing4_2.png")

#########################################################################
MG4 <- read.csv("Netlogo_MG_v4.csv")

ggplot(data=MG4, aes(x=X.step., y=count.consumers, group=demand.rise)) + 
  geom_line(aes(colour = demand.rise))
ggsave("MG4_1.png")

ggplot(data=MG4, aes(x=X.step., y=profit, group=demand.rise)) + 
  geom_line(aes(colour = demand.rise))
ggsave("MG4_2.png")

#########################################################################
MGSharing6 <- read.csv("Netlogo_MGSharing_v6.csv")

ggplot(data=MGSharing6, aes(x=X.step., y=count.producers, group=subsidy.rooftop)) + 
  geom_line(aes(colour = subsidy.rooftop))
ggsave("MGSharing4_5.png")
ggplot(data=MGSharing6, aes(x=X.step., y=consumers, group=subsidy.rooftop)) + 
  geom_line(aes(colour = subsidy.rooftop))
ggsave("MGSharing4_6.png")

#########################################################################
MGSharing8<- read.csv("Netlogo_MGSharing_v8.csv")
ggplot(data=MGSharing8, aes(x=X.step., y=count.producers, group=subsidy.rooftop)) + 
  geom_line(aes(colour = subsidy.rooftop))
ggsave("MGSharing5_1.png")
MGSharing7<- read.csv("Netlogo_MGSharing_v7.csv")
ggplot(data=MGSharing7, aes(x=X.step., y=count.producers, group=Population)) + 
  geom_line(aes(colour = Population))
ggsave("MGSharing5_2.png")

#######################################################################
MG10<-read.csv("Netlogo_MG_v5.csv")
ggplot(data=MG10, aes(x=X.step., y=count.consumers, group=subsidy.rooftop)) + 
  geom_line(aes(colour = subsidy.rooftop))
ggsave("MG7_1.png")

ggplot(data=MG10, aes(x=X.step., y=count.consumers, group=Population)) + 
  geom_line(aes(colour = Population))
ggsave("MG7_2.png")

ggplot(data=MG10, aes(x=X.step., y=count.consumers, group=demand.rise)) + 
  geom_line(aes(colour = demand.rise))
ggsave("MG7_3.png")
#######################################################################
Sharing10<-read.csv("Netlogo_Sharing_v5.csv")

Sharing10_small <- Sharing10[which(Sharing10$subsidy.rooftop == "TRUE"),]

ggplot(data=Sharing10, aes(x=X.step., y=consumers, group=Population)) + 
  geom_line(aes(colour = Population))
ggsave("Sharing10_1.png")
#######################################################################
MGSharing10<-read.csv("Netlogo_MGSharing_v10.csv")

ggplot(data=MGSharing10, aes(x=X.step., y=consumers, group=X.run.number.)) + 
  geom_line(aes(colour =X.run.number.))
ggsave("MGSharing10_1.png")

ggplot(data=MGSharing10, aes(x=X.step., y=count.producers, group=X.run.number.)) + 
  geom_line(aes(colour =X.run.number.))
ggsave("MGSharing10_2.png")

#######################################################################
MGSharing12<-read.csv("MGSharingscen_2.csv")
library(ggplot2)
ggplot(data=MGSharing12, aes(x=X.step., y=consumers, group=X.run.number.)) + 
  geom_line(aes(colour =X.run.number.))
ggsave("MGSharing10_1.png")

ggplot(data=MGSharing12, aes(x=X.step., y=count.producers, group=X.run.number.)) + 
  geom_line(aes(colour =X.run.number.))
ggsave("MGSharing10_2.png")

MGSharing12<-read.csv("MGSharingscen_3.csv")
library(ggplot2)
ggplot(data=MGSharing12, aes(x=X.step., y=consumers, group=X.run.number.)) + 
  geom_line(aes(colour =X.run.number.))
ggsave("MGSharing10_3.png")

ggplot(data=MGSharing12, aes(x=X.step., y=count.producers, group=X.run.number.)) + 
  geom_line(aes(colour =X.run.number.))
ggsave("MGSharing10_4.png")
#######################################################################
MGSharing13<-read.csv("MGSharing_pol1.csv")
library(ggplot2)
ggplot(data=MGSharing13, aes(x=X.step., y=consumer.all, group=X.run.number.)) + 
  geom_line(aes(colour =X.run.number.))
ggsave("MGSharing10_1.png")

ggplot(data=MGSharing13, aes(x=X.step., y=count.producers, group=X.run.number.)) + 
  geom_line(aes(colour =X.run.number.))

#######################################################################
MGSharing14<-read.csv("MGSharing_pol2b.csv")
library(ggplot2)
ggplot(data=MGSharing14, aes(x=X.step., y=consumers_all, group=X.run.number.)) + 
  geom_line(aes(colour =X.run.number.))
ggsave("MGSharing10_1.png")

ggplot(data=MGSharing14, aes(x=X.step., y=microgrid.profit, group=X.run.number.)) + 
  geom_line(aes(colour =X.run.number.))

#######################################################################
Sharing_robustness_1<-read.csv("MGSharing_pol3.csv")
library(ggplot2)

ggplot(data=Sharing_robustness_1, aes(x=X.step., y=Access.kits, group=policy)) + 
  geom_line(aes(colour =policy))
ggsave("policy4.png")

ggplot(data=Sharing_robustness_1, aes(x=X.step., y=Producers, group=type)) + 
  geom_line(aes(colour =type))
ggsave("compare_producer_1.png")

ggplot(data=Sharing_robustness_1, aes(x=X.step., y=Profit, group=type)) + 
  geom_line(aes(colour =type))
ggsave("compare_profit_1.png")

ggplot(data=Sharing_robustness_1, aes(x=X.step., y=Afford.kits, group=type)) + 
  geom_line(aes(colour =type))
ggsave("compare_afford_1.png")

ggplot(data=Sharing_robustness_1, aes(x=X.step., y=Access.kits, group=type)) + 
  geom_line(aes(colour =type))
ggsave("compare_access_1.png")
