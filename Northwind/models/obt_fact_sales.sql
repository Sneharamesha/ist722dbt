with f_sales as (
    select * from {{ ref('fact_sales') }}
),
d_customer as (
    select 
        customerkey,
        customerid,
        companyname,
        contactname,
        contacttitle,
        address,
        city,
        region,
        postalcode,
        country,
        phone,
        fax
    from {{ ref('dim_customer') }}
),
d_employee as (
    select 
        employeekey,
        employeeid,
        employeenamelastfirst,
        employeenamefirstlast,
        employeetitle,
        supervisornamelastfirst,
        supervisornamefirstlast
    from {{ ref('dim_employee') }}
),
d_date as (
    select 
        datekey,
        date,
        year,
        quarter,
        month,
        day,
        dayofweek,
        weekofyear,
        dayname,
        monthname
    from {{ ref('dim_date') }}
),
d_product as (
    select 
        productkey,
        productname,
        supplierid,
        categoryid,
        quantityperunit,
        unitprice,
        unitsinstock,
        unitsonorder,
        reorderlevel,
        discontinued
    from {{ ref('dim_product') }}
)

select
    f.orderid,

    -- Customer info
    d_customer.customerid,
    d_customer.companyname,
    d_customer.contactname,
    d_customer.contacttitle,
    d_customer.address,
    d_customer.city,
    d_customer.region,
    d_customer.postalcode,
    d_customer.country,
    d_customer.phone,
    d_customer.fax,

    -- Employee info
    d_employee.employeeid,
    d_employee.employeenamelastfirst,
    d_employee.employeenamefirstlast,
    d_employee.employeetitle,
    d_employee.supervisornamelastfirst,
    d_employee.supervisornamefirstlast,

    -- Date info
    d_date.date,
    d_date.year,
    d_date.quarter,
    d_date.month,
    d_date.day,
    d_date.dayofweek,
    d_date.weekofyear,
    d_date.dayname,
    d_date.monthname,

    -- Product info
    d_product.productname,
    d_product.supplierid,
    d_product.categoryid,
    d_product.quantityperunit,
    d_product.unitprice,
    d_product.unitsinstock,
    d_product.unitsonorder,
    d_product.reorderlevel,
    d_product.discontinued,

    -- Facts
    f.quantity,
    f.extendedpriceamount,
    f.discountamount,
    f.soldamount
from f_sales as f
    left join d_customer on f.customerkey = d_customer.customerkey
    left join d_employee on f.employeekey = d_employee.employeekey
    left join d_date on f.orderdatekey = d_date.datekey
    left join d_product on f.productkey = d_product.productkey
