DROP TABLE IF EXISTS CovidDeaths;

CREATE TABLE CovidDeaths (
    iso_code VARCHAR(10),
    continent VARCHAR(50),
    location VARCHAR(100),
    date DATE,
    population BIGINT,
    total_cases DOUBLE,
    new_cases DOUBLE,
    new_cases_smoothed DOUBLE,
    total_deaths DOUBLE,
    new_deaths DOUBLE,
    new_deaths_smoothed DOUBLE,
    total_cases_per_million DOUBLE,
    new_cases_per_million DOUBLE,
    new_cases_smoothed_per_million DOUBLE,
    total_deaths_per_million DOUBLE,
    new_deaths_per_million DOUBLE,
    new_deaths_smoothed_per_million DOUBLE,
    reproduction_rate DOUBLE,
    icu_patients DOUBLE,
    icu_patients_per_million DOUBLE,
    hosp_patients DOUBLE,
    hosp_patients_per_million DOUBLE,
    weekly_icu_admissions DOUBLE,
    weekly_icu_admissions_per_million DOUBLE,
    weekly_hosp_admissions DOUBLE,
    weekly_hosp_admissions_per_million DOUBLE
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/CovidDeaths.csv'
INTO TABLE CovidDeaths
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(@iso_code,@continent,@location,@date,@population,@total_cases,@new_cases,@new_cases_smoothed,
@total_deaths,@new_deaths,@new_deaths_smoothed,@total_cases_per_million,@new_cases_per_million,
@new_cases_smoothed_per_million,@total_deaths_per_million,@new_deaths_per_million,
@new_deaths_smoothed_per_million,@reproduction_rate,@icu_patients,@icu_patients_per_million,
@hosp_patients,@hosp_patients_per_million,@weekly_icu_admissions,
@weekly_icu_admissions_per_million,@weekly_hosp_admissions,@weekly_hosp_admissions_per_million,
@extra1,@extra2)
SET
iso_code = NULLIF(@iso_code,''),
continent = NULLIF(@continent,''),
location = NULLIF(@location,''),
date = STR_TO_DATE(@date, '%m/%d/%Y'),
population = NULLIF(@population,''),
total_cases = NULLIF(@total_cases,''),
new_cases = NULLIF(@new_cases,''),
new_cases_smoothed = NULLIF(@new_cases_smoothed,''),
total_deaths = NULLIF(@total_deaths,''),
new_deaths = NULLIF(@new_deaths,''),
new_deaths_smoothed = NULLIF(@new_deaths_smoothed,''),
total_cases_per_million = NULLIF(@total_cases_per_million,''),
new_cases_per_million = NULLIF(@new_cases_per_million,''),
new_cases_smoothed_per_million = NULLIF(@new_cases_smoothed_per_million,''),
total_deaths_per_million = NULLIF(@total_deaths_per_million,''),
new_deaths_per_million = NULLIF(@new_deaths_per_million,''),
new_deaths_smoothed_per_million = NULLIF(@new_deaths_smoothed_per_million,''),
reproduction_rate = NULLIF(@reproduction_rate,''),
icu_patients = NULLIF(@icu_patients,''),
icu_patients_per_million = NULLIF(@icu_patients_per_million,''),
hosp_patients = NULLIF(@hosp_patients,''),
hosp_patients_per_million = NULLIF(@hosp_patients_per_million,''),
weekly_icu_admissions = NULLIF(@weekly_icu_admissions,''),
weekly_icu_admissions_per_million = NULLIF(@weekly_icu_admissions_per_million,''),
weekly_hosp_admissions = NULLIF(@weekly_hosp_admissions,''),
weekly_hosp_admissions_per_million = NULLIF(@weekly_hosp_admissions_per_million,'');

SELECT *
FROM CovidDeaths;


CREATE TABLE CovidVaccinations (
    iso_code VARCHAR(10),
    continent VARCHAR(50),
    location VARCHAR(100),
    date DATE,

    new_tests DOUBLE,
    total_tests DOUBLE,
    total_tests_per_thousand DOUBLE,
    new_tests_per_thousand DOUBLE,
    new_tests_smoothed DOUBLE,
    new_tests_smoothed_per_thousand DOUBLE,
    positive_rate DOUBLE,
    tests_per_case DOUBLE,
    tests_units VARCHAR(50),

    total_vaccinations DOUBLE,
    people_vaccinated DOUBLE,
    people_fully_vaccinated DOUBLE,
    new_vaccinations DOUBLE,
    new_vaccinations_smoothed DOUBLE,

    total_vaccinations_per_hundred DOUBLE,
    people_vaccinated_per_hundred DOUBLE,
    people_fully_vaccinated_per_hundred DOUBLE,
    new_vaccinations_smoothed_per_million DOUBLE,

    stringency_index DOUBLE,
    population_density DOUBLE,
    median_age DOUBLE,
    aged_65_older DOUBLE,
    aged_70_older DOUBLE,

    gdp_per_capita DOUBLE,
    extreme_poverty DOUBLE,
    cardiovasc_death_rate DOUBLE,
    diabetes_prevalence DOUBLE,

    female_smokers DOUBLE,
    male_smokers DOUBLE,
    handwashing_facilities DOUBLE,
    hospital_beds_per_thousand DOUBLE,
    life_expectancy DOUBLE,
    human_development_index DOUBLE
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/CovidVax.csv'
INTO TABLE CovidVaccinations
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

/*MySQL tries to insert the raw value before your SET clause converts it, which causes the failure.*/
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/CovidVax.csv'
INTO TABLE CovidVaccinations
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
SET
date = STR_TO_DATE(@date,'%m/%d/%Y');

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/CovidVax.csv'
INTO TABLE CovidVaccinations
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(@iso_code,@continent,@location,@date,@new_tests,@total_tests,@total_tests_per_thousand,
@new_tests_per_thousand,@new_tests_smoothed,@new_tests_smoothed_per_thousand,
@positive_rate,@tests_per_case,@tests_units,@total_vaccinations,@people_vaccinated,
@people_fully_vaccinated,@new_vaccinations,@new_vaccinations_smoothed,
@total_vaccinations_per_hundred,@people_vaccinated_per_hundred,
@people_fully_vaccinated_per_hundred,@new_vaccinations_smoothed_per_million,
@stringency_index,@population_density,@median_age,@aged_65_older,@aged_70_older,
@gdp_per_capita,@extreme_poverty,@cardiovasc_death_rate,@diabetes_prevalence,
@female_smokers,@male_smokers,@handwashing_facilities,@hospital_beds_per_thousand,
@life_expectancy,@human_development_index)
SET
iso_code = NULLIF(@iso_code,''),
continent = NULLIF(@continent,''),
location = NULLIF(@location,''),
date = STR_TO_DATE(@date,'%m/%d/%Y'),

new_tests = NULLIF(@new_tests,''),
total_tests = NULLIF(@total_tests,''),
total_tests_per_thousand = NULLIF(@total_tests_per_thousand,''),
new_tests_per_thousand = NULLIF(@new_tests_per_thousand,''),
new_tests_smoothed = NULLIF(@new_tests_smoothed,''),
new_tests_smoothed_per_thousand = NULLIF(@new_tests_smoothed_per_thousand,''),
positive_rate = NULLIF(@positive_rate,''),
tests_per_case = NULLIF(@tests_per_case,''),
tests_units = NULLIF(@tests_units,''),

total_vaccinations = NULLIF(@total_vaccinations,''),
people_vaccinated = NULLIF(@people_vaccinated,''),
people_fully_vaccinated = NULLIF(@people_fully_vaccinated,''),
new_vaccinations = NULLIF(@new_vaccinations,''),
new_vaccinations_smoothed = NULLIF(@new_vaccinations_smoothed,''),

total_vaccinations_per_hundred = NULLIF(@total_vaccinations_per_hundred,''),
people_vaccinated_per_hundred = NULLIF(@people_vaccinated_per_hundred,''),
people_fully_vaccinated_per_hundred = NULLIF(@people_fully_vaccinated_per_hundred,''),
new_vaccinations_smoothed_per_million = NULLIF(@new_vaccinations_smoothed_per_million,''),

stringency_index = NULLIF(@stringency_index,''),
population_density = NULLIF(@population_density,''),
median_age = NULLIF(@median_age,''),
aged_65_older = NULLIF(@aged_65_older,''),
aged_70_older = NULLIF(@aged_70_older,''),

gdp_per_capita = NULLIF(@gdp_per_capita,''),
extreme_poverty = NULLIF(@extreme_poverty,''),
cardiovasc_death_rate = NULLIF(@cardiovasc_death_rate,''),
diabetes_prevalence = NULLIF(@diabetes_prevalence,''),

female_smokers = NULLIF(@female_smokers,''),
male_smokers = NULLIF(@male_smokers,''),
handwashing_facilities = NULLIF(@handwashing_facilities,''),
hospital_beds_per_thousand = NULLIF(@hospital_beds_per_thousand,''),
life_expectancy = NULLIF(@life_expectancy,''),
human_development_index = NULLIF(@human_development_index,'');

select * from covidvaccinations;

CREATE TABLE CovidVaccinations2 (
    iso_code VARCHAR(10),
    continent VARCHAR(50),
    location VARCHAR(100),
    date DATE,

    new_tests DOUBLE,
    total_tests DOUBLE,
    total_tests_per_thousand DOUBLE,
    new_tests_per_thousand DOUBLE,
    new_tests_smoothed DOUBLE,
    new_tests_smoothed_per_thousand DOUBLE,
    positive_rate DOUBLE,
    tests_per_case DOUBLE,
    tests_units VARCHAR(50),

    total_vaccinations DOUBLE,
    people_vaccinated DOUBLE,
    people_fully_vaccinated DOUBLE,
    new_vaccinations DOUBLE,
    new_vaccinations_smoothed DOUBLE,

    total_vaccinations_per_hundred DOUBLE,
    people_vaccinated_per_hundred DOUBLE,
    people_fully_vaccinated_per_hundred DOUBLE,
    new_vaccinations_smoothed_per_million DOUBLE,

    stringency_index DOUBLE,
    population_density DOUBLE,
    median_age DOUBLE,
    aged_65_older DOUBLE,
    aged_70_older DOUBLE,

    gdp_per_capita DOUBLE,
    extreme_poverty DOUBLE,
    cardiovasc_death_rate DOUBLE,
    diabetes_prevalence DOUBLE,

    female_smokers DOUBLE,
    male_smokers DOUBLE,
    handwashing_facilities DOUBLE,
    hospital_beds_per_thousand DOUBLE,
    life_expectancy DOUBLE,
    human_development_index DOUBLE
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/CovidVax.csv'
INTO TABLE CovidVaccinations2
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(@iso_code,@continent,@location,@date,@new_tests,@total_tests,@total_tests_per_thousand,
@new_tests_per_thousand,@new_tests_smoothed,@new_tests_smoothed_per_thousand,
@positive_rate,@tests_per_case,@tests_units,@total_vaccinations,@people_vaccinated,
@people_fully_vaccinated,@new_vaccinations,@new_vaccinations_smoothed,
@total_vaccinations_per_hundred,@people_vaccinated_per_hundred,
@people_fully_vaccinated_per_hundred,@new_vaccinations_smoothed_per_million,
@stringency_index,@population_density,@median_age,@aged_65_older,@aged_70_older,
@gdp_per_capita,@extreme_poverty,@cardiovasc_death_rate,@diabetes_prevalence,
@female_smokers,@male_smokers,@handwashing_facilities,@hospital_beds_per_thousand,
@life_expectancy,@human_development_index)
SET
date = STR_TO_DATE(@date,'%m/%d/%Y');

select * from covidvaccinations;

select location, date, total_cases, new_cases, total_deaths, population 
from coviddeaths
order by 1,2;

/* Looking at Total Cases vs total deaths in the US to show the likelihood of dying if you contracted covid in each country,
in this case, the United States*/
select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as deathspercase
from coviddeaths
where location like '%states%'
order by date desc;

/*Looking at Total Cases vs Population
in this case, the United States*/
select location, date, total_cases, population, (total_cases/population)*100 as contractionpercentage
from coviddeaths
where location like '%states%'
order by date;

/*Look at Counties with Highest Infection Rate compared to Population*/
select location, population, MAX(total_cases) as HighestInfectionCount, max(total_cases/population)*100 as HighestInfectionRate
from coviddeaths
Group by location,population
order by HighestInfectionRate desc;

/*Look at countries with highest death count*/
/*Includes clean-up for where Location is not Subtotaled by Continent*/
select location, MAX(total_deaths) as TotalDeathCount
from coviddeaths
	/*Includes clean-up for where Location is not Subtotaled by Continent. 
	We noticed that in raw data, Location is listed as a continent where the continent column is listed as null*/
	where continent is not null
Group by location
order by TotalDeathCount desc;

/*Look at continent with highest death count
We noticed that in raw data, Location is listed as a continent where the continent column is listed as null**/
select continent, MAX(total_deaths) as TotalDeathCount
from coviddeaths
	/*We noticed that in raw data, Location is listed as a continent where the continent column is listed as null*/
	where continent is not null
Group by continent
order by TotalDeathCount desc;


/*Global numbers per day*/
select date, sum(new_cases) as total_cases, sum(new_deaths) as total_deaths, (sum(new_deaths)/sum(new_cases))*100 as DeathPercentage
from coviddeaths
	/*Includes clean-up for where Location is not Subtotaled by Continent. 
	We noticed that in raw data, Location is listed as a continent where the continent column is listed as null*/
	where continent is not null
    group by date
order by 1;


/*Using Window Function for Rolling Count*/
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
	sum(vac.new_vaccinations) over (partition by dea.Location order by dea.location, dea.date) as rollingvaccinationcount,
    ((sum(vac.new_vaccinations) over (partition by dea.Location order by dea.location, dea.date))/dea.population)*100 as vaccination_rate
from coviddeaths dea
join covidvaccinations vac
	on dea.location=vac.location 
    and dea.date=vac.date
where dea.continent is not null
order by 2,3;
    
/*Using CTE to also Find Vaccination Rate and CASE WHEN to confirm calculations match, handles Nulls */
With PopvsVac (Continent,Location, Date, Population, NewVaccinations, RollingPeopleVaccinated, VaccinationRate_NoCte)
as 
(select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
	sum(vac.new_vaccinations) over (partition by dea.Location order by dea.location, dea.date) as rollingvaccinationcount,
    ((sum(vac.new_vaccinations) over (partition by dea.Location order by dea.location, dea.date))/dea.population)*100 as vaccination_rate
from coviddeaths dea
join covidvaccinations vac
	on dea.location=vac.location 
    and dea.date=vac.date
where dea.continent is not null
order by 2,3
)
Select *, 
	(RollingPeopleVaccinated/Population) * 100 as VaccinationRate_Cte /*This works because we ordered data set already by Location and Date in CTE*/,
	CASE 
		WHEN VaccinationRate_NoCte = (RollingPeopleVaccinated/Population) * 100 then 'Matched' 
		WHEN VaccinationRate_NoCte is null and (RollingPeopleVaccinated/Population) * 100 is null then 'Matched'
		else 'Different' end as VaccinationRate_Check
from PopvsVac;


/*Using Temp Table to also Find Vaccination Rate*/
DROP TABLE if exists PercentPopVaccination;
CREATE TEMPORARY TABLE PercentPopVaccination
(Continent varchar(255),
Location varchar(255), 
Date datetime, 
Population numeric, 
NewVaccinations numeric, 
RollingPeopleVaccinated numeric);

Insert into PercentPopVaccination
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
	sum(vac.new_vaccinations) over (partition by dea.Location order by dea.location, dea.date) as rollingvaccinationcount
from coviddeaths dea
join covidvaccinations vac
	on dea.location=vac.location 
    and dea.date=vac.date
where dea.continent is not null
order by 2,3;

Select *, (RollingPeopleVaccinated/Population) * 100 as VaccinationRate_TempTable
from PercentPopVaccination;

/*Create Views to Store Data for visualizations*/
DROP VIEW if exists TotalDeathbyContinent;
Create View TotalDeathbyContinent
as
select continent, MAX(total_deaths) as TotalDeathCount
from coviddeaths
	/*We noticed that in raw data, Location is listed as a continent where the continent column is listed as null*/
	where continent is not null
Group by continent
order by TotalDeathCount desc;

Select * from totaldeathbycontinent;