# NYC-311 Service Insights

Dive into the intricate details of NYC's 311 service requests spanning from 2010 to 2023. The primary objective was to design a data pipeline that seamlessly retrieves, processes, and channels data into a data repository, subsequently drawing significant insights. This pipeline is designed for batch processing, with capabilities for both on-demand data loading and daily data updates from the [official API](https://dev.socrata.com/foundry/data.cityofnewyork.us/erm2-nwe9). 


## Understanding NYC 311

NYC 311 serves as a round-the-clock helpline, offering non-critical services and information to the city's residents, businesses, and tourists. It's a platform where people can voice concerns on a myriad of issues, from deteriorating roads and noise disturbances to graffiti and air quality concerns. 311 efficiently directs these service requests to the most suitable of the 23 city agencies. With its multi-channel accessibility, including phone, web portal, mobile apps, and social media, NYC 311 stands as the go-to hub for all non-emergency city-related queries.

## Dataset Overview

The project leverages [data](https://data.cityofnewyork.us/Social-Services/311-Service-Requests-from-2010-to-Present/erm2-nwe9) sourced from the [NYC Open Data portal](https://opendata.cityofnewyork.us/), a transparent platform offering free access to over 2,100 datasets pertinent to NYC. The 311 dataset undergoes daily automatic updates.

## Key Questions Addressed

- Which complaint types dominate NYC 311's records?
- Which agency predominantly handles a specific complaint type?
- How have distinct complaint categories fluctuated over the past 13 years?
- Which areas register the highest number of complaints?
- Are there specific areas that consistently report a particular complaint type?
- Which agencies are at the forefront of addressing 311 complaints, and how has this trend shifted annually?
- Is there a noticeable change in the efficiency of city agencies over the years?

## Technology Behind the Scenes

- [Pandas Python Library](https://pandas.pydata.org/): For data retrieval, transformation, and loading to BigQuery from the [Socrata API](https://dev.socrata.com/foundry/data.cityofnewyork.us/erm2-nwe9).
- [Terraform](https://www.terraform.io/): Infrastructure management made easy.
- [Docker](https://www.docker.com/): For encapsulating our code.
- [Artifact Registry](https://cloud.google.com/artifact-registry): Docker image repository.
- [Compute Engine](https://cloud.google.com/compute): Hosting the Prefect Agent and monitoring queued tasks.
- [Cloud Run Jobs](https://cloud.google.com/run/docs/create-jobs): Serverless execution of our Prefect workflows.
- [Google BigQuery](https://cloud.google.com/bigquery): Our primary data storage solution.
- [Google Looker Studio](https://lookerstudio.google.com/): Dashboard creation tool.
- [Github](https://github.com/): Code hosting and CI/CD via Github Actions.
- [Prefect OSS and Prefect Cloud](https://www.prefect.io/): Deployment orchestration and monitoring.
- [DBT Core](https://www.getdbt.com/): Data transformation in our warehouse for visualization readiness.

## Pipeline Blueprint

The pipeline is triggered every time code updates are pushed to the main branch. This action, facilitated by Github Actions, builds a new Docker `flows` image, updates the Artifact Registry, and refreshes the CloudRunJob Prefect block with the latest image.

For a comprehensive understanding of the pipeline's architecture and flow, refer to the provided diagram.

## Data Structure

| Column         | Data Type | Description                                  |
| -------------- | --------- | -------------------------------------------- |
| unique_key     | INTEGER   | Distinct identifier for each complaint       |
| created_date   | TIMESTAMP | Complaint submission date                    |
| closed_date    | TIMESTAMP | Complaint resolution date                    |
| agency_name    | STRING    | Agency responsible for addressing the issue  |
| complaint_type | STRING    | Complaint category                           |
| descriptor     | STRING    | Detailed complaint description               |
| incident_zip   | INTEGER   | Incident location's zip code                 |


The data lineage graph illustrates the journey of the data from its source to the final visualization dashboard.

## Noteworthy Observations

- The New York City Police Department addresses approximately one-third of all 311 Service Requests.
- The most frequent complaints to the NYPD include Residential Noise, Illegal Parking, and Blocked Driveways.
- A significant surge in Residential Noise complaints was observed from 2019 to 2020, with the trend persisting in subsequent years.
- The Bronx, particularly the 10466 zip code, reports the highest noise complaints.
- While the NYPD handles a vast number of requests, their average response time is commendably less than a day.

## Replication Steps

1. Begin with the preliminary steps outlined.
2. Activate the `Build and Apply Prefect Deployment` action on Github.
3. Monitor the Prefect Cloud to ensure the Agent is operational.
4. Trigger a deployment via the Prefect Cloud UI.

## Potential Enhancements

- Integration of testing with Continuous Integration.
- Support for multiple environments (development, staging, production).
- Exploration of additional data sources to enrich the analysis.
