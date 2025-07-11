select * 
from PortfolioProject..CovidDeaths
order by 3,4

--select * 
--from PortfolioProject..CovidVaccinations
--order by 3,4

select location,date, total_cases, new_cases, total_deaths, population
from PortfolioProject..CovidDeaths
order by 1,2

----total cases vs total deaths
select location,
       date,
	   total_cases,
       total_deaths,
	   (CAST(total_deaths AS FLOAT) / total_cases) * 100 as "Death Percentage"
from PortfolioProject..CovidDeaths
order by 1,2

----total cases vs total deaths in Myanmar and Thailand
select location,
       date,
	   total_cases,
       total_deaths,
	   (CAST(total_deaths AS FLOAT) / total_cases) * 100 as "Death Percentage"
from PortfolioProject..CovidDeaths
where location in ('Myanmar', 'Thailand')
order by 1,2

select
      location,
	  date,
	  total_cases,
	  population,
	  (CAST(total_cases as float)/ population) * 100 as "Infected_Population_Percentage"
from PortfolioProject..CovidDeaths
order by 1,2

select
      location,
	  max(total_cases) as "Highest Infection Count",
	  population,
	  max((CAST(total_cases as float)/ population)) * 100 as "Infected_Population_Percentage"
from PortfolioProject..CovidDeaths
group by location, population
order by [Infected_Population_Percentage] desc

select
      Location,
	  max(total_deaths) as "Total Death Count"
from PortfolioProject..CovidDeaths
where continent is not Null
group by location
order by [Total Death Count] desc

---highest death count by continet
select
	  sum(new_cases) as total_cases,
	  sum(new_deaths) as total_deaths,
	  sum(cast(new_deaths as float))/ sum(new_cases) *100 as "Death Percentage"
from PortfolioProject..CovidDeaths
where continent is not Null 
--group by date
order by 1,2

select CD.continent, 
       CD.location,
	   CD.date,
	   CD.population,
	   CV.new_vaccinations,
	   sum(convert(int,CV.new_vaccinations)) over (partition by Cv.location order by CV.location, CV.date) as "RollingPeopleVacciated"
from PortfolioProject..CovidDeaths CD
Join PortfolioProject..CovidVaccinations CV
     On CD.location = CV.location
	 and CD.date = CV.date
where CD.continent is not Null
order by 2,3

---CTEs
With PopVsVac (Continent, Location, Date, Population, New_vaccinations, RollingPeopleVaccinated)
as(
select CD.continent, 
       CD.location,
	   CD.date,
	   CD.population,
	   CV.new_vaccinations,
	   sum(convert(int,CV.new_vaccinations)) over (partition by Cv.location order by CV.location, CV.date) as "RollingPeopleVacciated"
from PortfolioProject..CovidDeaths CD
Join PortfolioProject..CovidVaccinations CV
     On CD.location = CV.location
	 and CD.date = CV.date
where CD.continent is not Null)
select *, (Cast(RollingPeopleVaccinated as float)/Population) * 100 as "Vaccinated People Percenatage"
from PopVsVac;

--Temptable
Drop Table if exists #VaccinatedPopulationPercent
Create table #VaccinatedPopulationPercent(
Continent varchar(50),
Location varchar(50),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric)
Insert into #VaccinatedPopulationPercent
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
       sum(convert(int, vac.new_vaccinations)) over (Partition by dea.Location Order by dea.Location,
	   dea.date) as "RollingPeopleVaccinated"
from PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
     On dea.location = vac.location and 
	    dea.date = vac.date
--where dea.continent is not Null

select *, (RollingPeopleVaccinated/Population) *100 as "Vaccinated Population Percentage"
from #VaccinatedPopulationPercent

Create View VaccinatedPopulationPercent as 
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
       sum(convert(int, vac.new_vaccinations)) over (Partition by dea.Location Order by dea.Location,
	   dea.date) as "RollingPeopleVaccinated"
from PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
     On dea.location = vac.location and 
	    dea.date = vac.date
--where dea.continent is not Null

select * from VaccinatedPopulationPercent
