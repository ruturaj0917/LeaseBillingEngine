

# Property Module

## Overview

The Property Module is the foundation of the Automated Lease & Billing Engine. It stores information about the real estate properties managed by the organization. Every building, apartment unit, lease, billing record, and payment in the system ultimately belongs to a property.

The module follows database normalization principles by storing reusable values such as property types and property statuses in separate reference tables. This improves data consistency, reduces redundancy, and enforces referential integrity.

---

# Business Workflow

```
Property Type
        │
        ▼
Property Status
        │
        ▼
Property
        │
        ▼
Building
        │
        ▼
Apartment Unit
        │
        ▼
Lease
        │
        ▼
Billing
        │
        ▼
Ledger
```

The Property module acts as the root of the business hierarchy.

---

# Objectives

The Property module is responsible for:

* Managing all properties owned or managed by the company.
* Classifying properties using predefined property types.
* Tracking the operational status of each property.
* Providing a parent entity for buildings, units, leases, and financial transactions.

---

# Database Design

## Reference Tables

### 1. PropertyType

**Purpose**

Stores all valid categories of properties.

Examples:

* Residential
* Commercial
* Industrial
* Mixed Use

**Reason for Separate Table**

Instead of storing text like "Residential" in every property record, the Property table stores a foreign key (`PropertyTypeId`). This eliminates duplicate values and prevents spelling inconsistencies.

---

### Structure

| Column           | Description          |
| ---------------- | -------------------- |
| PropertyTypeId   | Primary Key          |
| PropertyTypeCode | Business Code        |
| PropertyTypeName | Display Name         |
| Description      | Description          |
| IsActive         | Active Flag          |
| CreatedDate      | Record Creation Time |

---

### Sample Data

| Code | Name        |
| ---- | ----------- |
| RES  | Residential |
| COM  | Commercial  |
| IND  | Industrial  |
| MIX  | Mixed Use   |

---

## PropertyStatus

**Purpose**

Stores all possible operational states of a property.

Examples

* Active
* Inactive
* Under Maintenance

---

### Structure

| Column             | Description          |
| ------------------ | -------------------- |
| PropertyStatusId   | Primary Key          |
| PropertyStatusCode | Business Code        |
| PropertyStatusName | Display Name         |
| Description        | Description          |
| IsActive           | Active Flag          |
| CreatedDate        | Record Creation Time |

---

### Sample Data

| Code | Name              |
| ---- | ----------------- |
| ACT  | Active            |
| INA  | Inactive          |
| UM   | Under Maintenance |

---

# Business Table

## Property

### Purpose

Stores the master information for every property managed by the organization.

Each property belongs to exactly one property type and one property status.

---

## Structure

| Column           | Description          |
| ---------------- | -------------------- |
| PropertyId       | Primary Key          |
| PropertyCode     | Business Identifier  |
| PropertyName     | Property Name        |
| PropertyTypeId   | FK → PropertyType    |
| PropertyStatusId | FK → PropertyStatus  |
| AddressLine1     | Address              |
| AddressLine2     | Optional Address     |
| City             | City                 |
| State            | State                |
| Country          | Country              |
| PostalCode       | Postal Code          |
| OpeningDate      | Property Start Date  |
| TimeZone         | Property Time Zone   |
| IsActive         | Soft Delete Flag     |
| CreatedDate      | Record Creation Time |
| ModifiedDate     | Last Update Time     |

---

# Relationships

```
PropertyType (1)
      │
      │
      └───────────────∞
                    Property
      ∞───────────────┐
                      │
PropertyStatus (1)
```

Every Property must have:

* One Property Type
* One Property Status

---

# Constraints Implemented

## Primary Keys

```
PK_PropertyType

PK_PropertyStatus

PK_Property
```

---

## Unique Constraints

```
PropertyTypeCode

PropertyTypeName

PropertyStatusCode

PropertyStatusName

PropertyCode
```

These constraints prevent duplicate business identifiers.

---

## Default Constraints

```
IsActive = 1

CreatedDate = SYSDATETIME()
```

Automatically populated by SQL Server during record creation.

---

## Foreign Keys

```
Property.PropertyTypeId

↓

PropertyType.PropertyTypeId
```

```
Property.PropertyStatusId

↓

PropertyStatus.PropertyStatusId
```

These relationships enforce referential integrity.

---

# Normalization

The Property Module is designed according to Third Normal Form (3NF).

Instead of storing:

```
Property

Residential

Active
```

the database stores:

```
Property

↓

PropertyTypeId

↓

PropertyStatusId
```

Benefits:

* Eliminates redundant data
* Improves consistency
* Prevents invalid values
* Simplifies maintenance
* Supports future expansion

---

# Business Rules

* Every Property must have exactly one Property Type.
* Every Property must have exactly one Property Status.
* PropertyCode must be unique.
* PropertyName is mandatory.
* A Property cannot exist without a valid PropertyType.
* A Property cannot exist without a valid PropertyStatus.
* Records are never physically deleted; instead, `IsActive` is used for logical deactivation.

---

# SQL Concepts Used

During the Property Module implementation, the following SQL Server features were used:

* CREATE TABLE
* CREATE SCHEMA
* IDENTITY
* PRIMARY KEY
* FOREIGN KEY
* UNIQUE Constraint
* DEFAULT Constraint
* NOT NULL
* NULL
* Seed Data
* INSERT
* SELECT
* INNER JOIN
* Database Normalization (3NF)

---
