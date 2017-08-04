  library(lhs)
  
  X<-randomLHS(200,19)
  plot(X)
  Y <- matrix(0, nrow=200, ncol=19)
  rdu<-function(n,k) sample(1:k,n,replace=T)
  
  Y[,1]<- runif(X[,1],min = 10,max = 1000) #population
  Y[,2]<- rdu(200,4) # demand of the user
  Y[,3]<- rdu(200,2) # subsidy present or not
  Y[,4]<- runif(X[,4],min = 1,max = 5) #high case to mid caste connection
  Y[,5]<- runif(X[,5],min = 1,max = 5) #high caste to low caste
  Y[,6]<- runif(X[,6],min = 1,max = 5) #mid caste connected to low caste
  Y[,7]<- runif(X[,7],min = 0,max = 3) #shopkeeper in low caste
  Y[,8]<- runif(X[,8],min = 2,max = 5) #shopkeeper in mid caste
  Y[,9]<- runif(X[,9],min = 2,max = 5) #shopkeeper in high caste
  Y[,10]<- runif(X[,10],min = 1,max = 5) #BF in low caste
  Y[,11]<- runif(X[,11],min = 15,max = 25) #BF in mid caste
  Y[,12]<- runif(X[,12],min = 70,max = 90)  #BF in high caste
  Y[,13]<- runif(X[,13],min = 70,max = 90) #SF in low caste
  Y[,14]<- runif(X[,14],min = 45,max = 65) #SF in mid caste
  Y[,15]<- runif(X[,15],min = 1,max = 5)  #SF in high caste
  Y[,16]<- runif(X[,16],min = 5,max = 20) #Early Adopters in low caste
  Y[,17]<- runif(X[,17],min = 5,max = 30) #Early Adopters in mid caste
  Y[,18]<- runif(X[,18],min = 5,max = 40) #Early Adopters in high caste
  Y[,19]<- rdu(200,4) #Number of manufacturers
  population<-Y[,1]
  EarlyadoptersLowCaste<-Y[,16]
  connectivityHightoMid<-Y[,5]
  write.csv2(Y,"finalexperiments")
  plot(Y)
  plot(population,EarlyadoptersLowCaste)
  hist(connectivityHightoMid)
