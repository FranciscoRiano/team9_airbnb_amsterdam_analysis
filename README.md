# Does the infrastructure of Amsterdam matter in the growing industry of Airbnb?

---

__Do factors like distance to/from Amsterdam Central station, distance to/from Schiphol airport, distance to/from tram stops and distance to/from metro stops influence the prices of AirBnB listings? And does the effect of the several infrastructure components on AirBnB pricing differ depending on whether there is a holiday or not?__

<p align="center">
  <img width="70%" src="https://blog.atairbnb.com/wp-content/uploads/2015/06/DynamicPricing-Blog-AL-02-03.jpg">
</p>


## Motivation

This code is written in order to find answers to these questions.
The reason for diving into this problem is because


## Method and results

## Repository overview

The various files in the repository will be explained further in this section.

The map source ("src") includes two subfolders data preparation and analysis. The subfolder data preparation includes code that is needed to download, clean and merge the data. Furthermore, the subfolder analysis includes the code that is needed to analyze the data. The makefile includes code that can easily run in the command prompt by typing "make". Doing so will automatically run the code in the src code and build the project. From this, two new directories are created: "data" and "gen" (generated). The gen folder consists of two sub-directories, namely "input" and "output". Gitignore includes files that should be ignore by Git and remain untracked, such as csv files or Rhistory files.

Moreover, an RMarkdown file is included. This file includes the report of our study with all the tables and plots that were built in the analysis part and includes sections that explain certain phases of the project, such as the data collection, processing parts and the discussion of the results. The RMarkdown file is also knitted as a PDF document and committed to the repository. Finally, this repository has also included a README.MD file that contains information about the project, the authors and the structure of our study. 

## Running instructions
First of all, [Make](https://tilburgsciencehub.com/building-blocks/configure-your-computer/automation-and-workflows/make/) is needed to run the files. The directory works with Make which should be run in the terminal (Mac users) or in git bash (Windows users). Moreover, [R-studio](https://tilburgsciencehub.com/building-blocks/configure-your-computer/statistics-and-computation/r/) is needed to run the R-files. To run the code used in the study, the following packages need to be installed first:

[Will be updated] Explain to potential users how to run/replicate your workflow.

## More resources
Related literature and/or documentation. (Link)

## About
This research is conducted as part of the course [Data Preparation and Workflow Management](https://github.com/hannesdatta/course-dprep) of TiSEM department at Tilburg University.
The study is conducted by Marketing master students who are part of team 9 during spring semester 2022. The data used for this project can be found at [Inside AirBnB](http://insideairbnb.com/get-the-data.html).

## Team 9 contributors
Team members: [Francisco Riaño Martinez](https://github.com/FranciscoRiano), [Jan van der Doe](https://github.com/janvanderdoe), [Kamila Majdlenová](https://github.com/kammaj), [Pomme Verhagen](https://github.com/pommeverhagen), [Yuetong Bi](https://github.com/YuetongBi)
