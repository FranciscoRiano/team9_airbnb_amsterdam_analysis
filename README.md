# Does the infrastructure of Amsterdam make a difference?

---

__Do factors like distance to/from Amsterdam Central station, distance to/from Schiphol airport, distance to/from tram stops and distance to/from metro stops influence the prices of AirBnB listings? And does the effect of the several infrastructure components on AirBnB pricing differ depending on whether there is a holiday or not?__

<p align="center">
  <img width="70%" src="https://blog.atairbnb.com/wp-content/uploads/2015/06/DynamicPricing-Blog-AL-02-03.jpg">
</p>


## Motivation

Infrastructure is the key to developing a successful tourism destination. Tourism industry stimulates investments in new infrastructure, most of which improves the living conditions of local residents as well as tourists. While Airbnb plays an important role in the tourism industry of today, infrastructure components might influence prices of Airbnb listings accordingly. Therefore questions like: 'Does the distance to/from Amsterdam Central Station or the distance to/from Schiphol Airport in relation to the location of the Airbnb listing influence the prices of that Airbnb listing?' could be asked. This code is written in order to find answers to these questions which focuses on Airbnb listings in Amsterdam.

## Method and results

### Research method
The research method that is used in this project is a regression analysis. This method is used to predict the influence of the independent variables 'Distance to/from Amsterdam Central Station', 'Distance to/from Schiphol Airport', 'Distance to/from tram stops', 'Distance to/from metro stops' on the dependent variable 'Prices of Airbnb listings'. Furthermore the moderator 'Holidays in NL' will be included and analyzed. According to this model, the research questions can be answered.

![WhatsApp Image 2022-03-13 at 5 05 55 PM](https://user-images.githubusercontent.com/98962946/158178822-28fd9df1-2965-4463-89f9-adf1cc83551b.jpeg)

### Results

### Conclusion

## Repository overview

The various files in the repository will be explained further in this section.

The map source ("src") includes two subfolders data preparation and analysis. The subfolder data preparation includes code that is needed to download, clean and merge the data. Furthermore, the subfolder analysis includes the code that is needed to analyze the data. The makefile includes code that can easily run in the command prompt by typing "make". Doing so will automatically run the code in the src code and build the project. From this, two new directories are created: "data" and "gen" (generated). The gen folder consists of two sub-directories, namely "input" and "output". Gitignore includes files that should be ignore by Git and remain untracked, such as csv files or Rhistory files.

Moreover, an RMarkdown file is included. This file includes the report of our study with all the tables and plots that were built in the analysis part and includes sections that explain certain phases of the project, such as the data collection, processing parts and the discussion of the results. The RMarkdown file is also knitted as a PDF document and committed to the repository. Finally, this repository has also included a README.MD file that contains information about the project, the authors and the structure of our study. 

## Running instructions
First of all, [Make](https://tilburgsciencehub.com/building-blocks/configure-your-computer/automation-and-workflows/make/) is needed to run the files. The directory works with Make which should be run in the terminal (Mac users) or in git bash (Windows users). Moreover, [R-studio](https://tilburgsciencehub.com/building-blocks/configure-your-computer/statistics-and-computation/r/) is needed to run the R-files. To run the code used in the study, the following packages need to be installed first:
```{r}
install.packages("modelsummary")
install.packages("rlist")
install.packages("tidyverse")
install.packages("data.table")
install.packages("dplyr")
install.packages("googledrive")
```
## More resources
Related literature and/or documentation. (Link)

## About
This research is conducted as part of the course [Data Preparation and Workflow Management](https://github.com/hannesdatta/course-dprep) of TiSEM department at Tilburg University.
The study is conducted by Marketing master students who are part of team 9 during spring semester 2022. The data used for this project can be found at [Inside AirBnB](http://insideairbnb.com/get-the-data.html).

## Team 9 contributors
Team members: [Francisco Riaño Martinez](https://github.com/FranciscoRiano), [Jan van der Doe](https://github.com/janvanderdoe), [Kamila Majdlenová](https://github.com/kammaj), [Pomme Verhagen](https://github.com/pommeverhagen), [Yuetong Bi](https://github.com/YuetongBi)
