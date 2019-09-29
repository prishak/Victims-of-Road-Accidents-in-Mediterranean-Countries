library(shiny)
library(ggplot2)
library(dplyr)
library(eurostat)

library(reshape2)
library(gridExtra)

p1<-get_eurostat("med_rd7",filters = list(geo=c("DZ","EG","IL","JO","MA","LB"),time_format="num"))
View(p1)
p2<-p1[!rowSums(is.na(p1)),]
p2<-label_eurostat(p2)

shinyServer(
    function(input, output) {
        
        output$plot<-renderPlot({
            
            if(input$Choose=="C_Plot"){
                
                p3 <- filter(p2, grepl(input$geo,geo))
                p<-ggplot(data=p3,aes(time,values,fill=values))+
                    geom_bar(stat="identity")+theme_minimal()+theme(axis.text.x=element_text(angle=45,hjust=1,size =12,face="bold"), axis.title.x=(element_text(color="blue", size=14, face="bold")), axis.title.y = element_text(color="#993333", size=14, face="bold"))+
                    labs(x="Year",y="Victims")
                
                print(p)
                geo<-input$geo
                
                
                output$summary<-renderPrint({
                    p3 <- filter(p2, grepl(input$geo,geo))
                    summary(p3)})
                
                output$table<-renderTable({
                    p3 <- filter(p2, grepl(input$geo,geo))
                    head(p3)
                })
                
                
            }else{
                p4 <- filter(p2, grepl(input$time,time))
                pp<-ggplot(data=p4,aes(geo,values,fill=time))+
                    geom_bar(stat="identity")+theme_minimal()+theme(axis.text.x=element_text(angle=45,hjust=1,size =12,face="bold"), axis.title.x=(element_text(color="blue", size=14, face="bold")), axis.title.y = element_text(color="#993333", size=14, face="bold"),  legend.position="none")+
                    labs(x="Country",y="Victims")
                print(pp)
                time<-input$time
                output$summary<-renderPrint({
                    p4 <- filter(p2, grepl(input$time,time))
                    summary(p4)})
                
                output$table<-renderTable({
                    p4 <- filter(p2, grepl(input$time,time))
                    head(p4)
                })
                
                
                
            }
        })
    }
)