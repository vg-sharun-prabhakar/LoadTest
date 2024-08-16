# vlms-auto-tests
Automation framework for testing.

# Drivers:

    Drivers for respective browsers should be up to date and matching with the browser version.

# Installation

    Install all required pre-requisites using the below commmand:

        pip install --upgrade pip
        pip install -r requirements.txt

# Running suites

  1. When Test Executes size of browser window should be undisturbed. It should be either in maximized or totally minimized.

  2. Before Triggering Design Manager Process flow complete the Pre-Requisites which includes a Entity and Version number at the global level

  3. Before Triggering Functional CCR Process flow, check if there's any pre approved CCR for the user. If any, need to terminate it.

# Video Recording

    1. If we want to record all testcases in a Suite as a Single Video file, Turn on the Start Recording in suite setup and Stop Recording at suite teardown.

    2. If we want to record particular/all testcases in a Suite as a individual Video file for each tc, Turn on the Start Recording in Testcase level and Stop Recording at test teardown.

# Offline Word Editing

    When we edit word document from offline word editor in Entity Without Assessment Processflow TC_15,16, Make sure the word editor screen is opened. If any other screen/window is opened, it will edit in that current active screen.

# Dashboard Report

    To Generate Dashboard report we need output.xml file as pre-requisite.

# QMS_Report

    To Generate QMS report we need to Dashboard report(metrics.html) and Output.xml file as pre-requisite.

# Trigger Email

    Before Triggering email, Make sure you have given proper Sender_login, Sender_Password, Attachments(Report files), list of Recepients & output.xml file path to read and generate email body.

