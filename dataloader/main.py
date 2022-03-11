import json
from bs4 import BeautifulSoup
import bs4
import requests


def main():

    url = "https://www.ilimgroup.ru/career/vakansii/"

    page = requests.get(url)

    print(f"{page.status_code=}")

    soup = BeautifulSoup(page.text, "html.parser")

    categories = [
        a.text.strip()
        for a in soup.find_all("a", class_="career_specializations_list sub-nav__link")
    ]

    all_jobs = soup.find_all("article", class_="news-card-mini")

    jobs = [parse_job(job) for job in all_jobs]

    model = {"categories": categories, "vacancies": jobs}
    with open("jobs.json", "w") as file:
        json.dump(model, file)


def parse_job(job):
    job_obj = {}
    job_obj["title"] = job.find("a", class_="news-card-mini__title").text

    job_obj["tag"] = job.find("a", class_="material-footer__link").text
    job_obj["location"] = job.find("span", class_="news-card-mini__location").text

    href = job.find("a", class_="news-card-mini__title")["href"]

    job_obj.update(parse_description(href))
    return job_obj


def parse_description(href):

    url = "https://www.ilimgroup.ru" + href
    page = requests.get(url)

    soap = BeautifulSoup(page.text, "html.parser")

    title = soap.find("h2", class_="article__title").text
    print(f'Parse page: "{title}"')

    elems = soap.find("div", class_="article__content")

    responsibilities = ""
    elems = elems.find_next("h4")
    if elems.text.lower() != "обязанности":
        raise ValueError(elems.text.lower())
    ul = elems.find_next("ul")
    for li in ul:
        if isinstance(li, bs4.Tag):
            responsibilities += f"- {li.text.strip()}\n"

    responsibilities = responsibilities.replace("<br>", "")

    requirements = ""
    elems = elems.find_next("h4")
    if elems.text.lower() != "требования":
        raise ValueError(elems.text.lower())
    ul = elems.find_next("ul")
    for li in ul:
        if isinstance(li, bs4.Tag):
            requirements += f"- {li.text.strip()}\n"

    requirements = requirements.replace("<br>", "")

    terms = ""
    elems = elems.find_next("h4")
    if elems.text.lower() != "условия":
        raise ValueError(elems.text.lower())
    ul = elems.find_next("ul")
    for li in ul:
        if isinstance(li, bs4.Tag):
            terms += f"- {li.text.strip()}\n"

    terms = terms.replace("<br>", "")

    contacts = []
    elems = elems.find_next("h4")
    if elems is not None:
        if elems.text.lower() != "контактная информация":
            raise ValueError(elems.text.lower())
        ul = elems.find_next("ul")
        for li in ul:
            if isinstance(li, bs4.Tag):
                contacts.append(li.text.strip())

    return {
        "responsibilities": responsibilities,
        "requirements": requirements,
        "terms": terms,
        "contacts": contacts,
    }


main()
