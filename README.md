# Barcode Scanner

## Table of Contents

1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)

## Overview

### Description

BarcodeScanner is a user-friendly app designed to simplify shopping and product information retrieval. By utilizing the device's camera, users can effortlessly scan barcodes to access instant details, compare prices, and make informed purchasing decisions, all within a seamless and intuitive interface.

### App Evaluation

- **Category:** Shopping / Utilities
- **Mobile:** Optimized for both iOS and Android platforms, BarcodeScanner ensures a quick and efficient scanning experience, making it an essential tool for consumers who prioritize convenience and smart shopping.
- **Story:** In a world where choices abound, BarcodeScanner emerges as a trusted companion for savvy shoppers, simplifying the decision-making process and empowering users with valuable information at their fingertips. The app's narrative centers around enhancing the overall shopping experience, offering a tool that aligns with modern consumers' desire for efficiency and informed choices.
- **Market:** BarcodeScanner caters to a diverse audience of consumers who seek a convenient and time-saving solution for their shopping needs. From tech-savvy individuals to busy parents, the app addresses the universal demand for accessible and quick product information in the fast-paced retail landscape.
- **Habit:** Users develop a habit of scanning barcodes while shopping, whether in-store or online, to gain insights into product details, compare prices, and make well-informed decisions. BarcodeScanner seamlessly integrates into the user's shopping routine, becoming a go-to tool for smart and efficient purchasing.
- **Scope:** Beyond basic barcode scanning, the app aims to evolve with additional features such as product reviews, personalized recommendations, and integration with online shopping platforms, positioning BarcodeScanner as an evolving and indispensable shopping companion in the digital age.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

- As a user, I want to scan barcodes to retrieve product information.
- ...

**Optional Nice-to-have Stories**

- As a user, I want to compare prices by scanning barcodes of different products.
- As a user, I want to receive personalized product recommendations based on my scanning history.
- As a user, I want to read and submit product reviews through the app.
- ...

### 2. Screen Archetypes

- [ ] Home Screen
  * [List recently scanned products]
  * [Scan Barcode button]
- [ ] Product Details Screen
  * [Display detailed information about the scanned product]
  * [Option to compare prices]
  * [Option to view product reviews]
- [ ] Scan History Screen
  * [List of previously scanned products]

### 3. Navigation

**Tab Navigation** (Tab to Screen)

- [Home]
- [Scan History]

**Flow Navigation** (Screen to Screen)

- [Home]
  * [Scan Barcode]
  * [View Scan History]
- [Scan History]
  * [View Details of a scanned product]

## Wireframes

[Add picture of your hand-sketched wireframes in this section]

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

![BarcodeScannerApp](https://github.com/kenillo/Capstone_Project/assets/102697972/914138f9-a6e6-4f7e-b7f8-80daefa837be)

## Schema

### Models

#### ScannedProduct

| Property      | Type     | Description                              |
| ------------- | -------- | ---------------------------------------- |
| objectId      | String   | Unique identifier for the scanned product |
| name          | String   | Name of the product                      |
| barcode       | String   | Barcode associated with the product      |
| price         | Number   | Price of the product                     |
| description   | String   | Brief description of the product         |
| createdAt     | DateTime | Timestamp indicating when the scan was added |

### Networking

- **List of network requests by screen:**
  - Home Screen
    - (Read/GET) Retrieve the list of recently scanned products
  - Product Details Screen
    - (Read/GET) Retrieve detailed information about a scanned product
  - Scan History Screen
    - (Read/GET) Retrieve the list of previously scanned products
    - (Create/POST) Add a new scanned product to the history
