from selenium import webdriver
from tempfile import mkdtemp
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import os
import requests

def handler(event=None, context=None):
    print("STARTING LAMBDA")
    x = requests.get('http://example.com/')
    print(x.status_code)
    x = requests.get('https://developer.spotify.com/')
    print(x.status_code)

    options = webdriver.ChromeOptions()
    options.binary_location = '/opt/chrome/chrome'
    options.add_argument('--headless')
    options.add_argument('--no-sandbox')
    options.add_argument("--disable-gpu")
    options.add_argument("--window-size=1280x1696")
    options.add_argument("--single-process")
    options.add_argument("--disable-dev-shm-usage")
    options.add_argument("--disable-dev-tools")
    options.add_argument("--no-zygote")
    options.add_argument(f"--user-data-dir={mkdtemp()}")
    options.add_argument(f"--data-path={mkdtemp()}")
    options.add_argument(f"--disk-cache-dir={mkdtemp()}")
    options.add_argument("--remote-debugging-port=9222")
    driver = webdriver.Chrome("/opt/chromedriver",
                              options=options)

    account_id = event["account_id"]
    email = event["email"]
    account_name = event["account_name"]

    print("before first wait")
    wait = WebDriverWait(driver, 10)

    print("LOC 34")
    driver.get('http://example.com/')
    print("LOC 35")
    driver.get('https://developer.spotify.com/')
    print("LOC 36")
    wait.until(EC.element_to_be_clickable((By.XPATH, '/html/body/div[1]/div/header/div[2]/button'))).click()
    print("LOC 38")
    wait.until(EC.presence_of_element_located((By.ID, 'login-username'))).send_keys(os.environ['SPOTIFY_ACCOUNT_EMAIL'])
    print("LOC 39")
    wait.until(EC.presence_of_element_located((By.ID, 'login-password'))).send_keys(os.environ['SPOTIFY_ACCOUNT_PASSWORD'])
    print("LOC 42")
    driver.find_element(By.XPATH, '/html/body/div[1]/div/div[2]/div/div/div[1]/div[4]/button/span[1]').click()

    print("LOC 45")
    wait.until(EC.presence_of_element_located((By.XPATH, '/html/body/div[1]/div/header/div[2]/div/div/button/span')))

    print("LOC 48")
    driver.get('https://developer.spotify.com/dashboard/9d48abfbbf194adc9051e1b82b0ecdb0/users')
    name_input = wait.until(EC.presence_of_element_located((By.ID, 'name')))
    name_input.send_keys(f"{account_name}{account_id}" if account_name else f"namelessUser{account_id}")
    email_input = wait.until(EC.presence_of_element_located((By.ID, 'email')))
    email_input.send_keys(email)
    driver.find_element(By.XPATH, '/html/body/div[1]/div/div/main/div/div/div[4]/div/div/div[2]/form/div/div[3]/button/span[1]').click()

    # Add a sleep if necessary
    # time.sleep(3)

    driver.quit()
    
    return "ok"
