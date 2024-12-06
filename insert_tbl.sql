CREATE TABLE IF NOT EXISTS public.rag_source
(
    id SERIAL PRIMARY KEY,
    company_id bigint NOT NULL,
    question TEXT NOT NULL,
    answer TEXT NOT NULL,
    category VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Foreign Key untuk menghubungkan ke tabel companies
ALTER TABLE public.rag_source
ADD CONSTRAINT rag_source_company_id_fkey FOREIGN KEY (company_id)
REFERENCES public.companies (id) MATCH SIMPLE
ON UPDATE CASCADE
ON DELETE CASCADE;








-- Data untuk Perusahaan dengan company_id 1 (Toyota)

INSERT INTO public.rag_source (company_id, question, answer, category, created_at, updated_at) VALUES
-- Category: Automotive
(1, 'What is the best car brand in Indonesia?', 'Toyota is considered one of the best car brands in Indonesia.', 'Automotive', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'What are Toyota’s top-selling models?', 'Toyota’s top-selling models include the Avanza, Fortuner, and Innova.', 'Automotive', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'Does Toyota offer electric cars?', 'Yes, Toyota offers hybrid and electric vehicles like the Toyota Prius and Corolla Hybrid.', 'Automotive', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'What is the warranty period for Toyota cars?', 'Toyota provides a standard 3-year or 100,000 km warranty.', 'Automotive', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'What safety features are included in Toyota vehicles?', 'Toyota includes safety features like airbags, ABS, and stability control.', 'Automotive', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'What fuel efficiency does Toyota offer?', 'Toyota offers high fuel efficiency across most models, especially hybrids.', 'Automotive', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'Are Toyota cars made in Indonesia?', 'Yes, Toyota has manufacturing plants in Indonesia.', 'Automotive', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'What is Toyota’s most affordable model?', 'The Toyota Agya is among the most affordable Toyota models.', 'Automotive', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'What is the resale value of Toyota cars?', 'Toyota cars generally have a high resale value.', 'Automotive', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'Does Toyota provide vehicle customization?', 'Yes, Toyota offers customization options for several models.', 'Automotive', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

-- Category: Customer Service
(1, 'Where are Toyota service centers located?', 'Toyota service centers are located in major cities across Indonesia.', 'Customer Service', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'How can I book a service for my Toyota car?', 'You can book a service online through Toyota’s official website or app.', 'Customer Service', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'What are Toyota’s customer service hours?', 'Toyota’s customer service is available from 9 AM to 6 PM.', 'Customer Service', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'Does Toyota offer roadside assistance?', 'Yes, Toyota offers roadside assistance for specific models.', 'Customer Service', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'How do I file a complaint?', 'You can file a complaint through Toyota’s customer support line.', 'Customer Service', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'Can I reschedule my service appointment?', 'Yes, service appointments can be rescheduled online or by calling support.', 'Customer Service', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'How do I check my service history?', 'Your service history can be accessed through Toyota’s app.', 'Customer Service', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'What is the process for claiming warranty?', 'You can claim warranty by visiting an authorized service center.', 'Customer Service', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'Does Toyota provide free maintenance?', 'Toyota offers free maintenance on select models during the initial ownership period.', 'Customer Service', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'How can I contact Toyota customer support?', 'You can contact customer support through their hotline or email.', 'Customer Service', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

-- Category: Finance
(1, 'What financing options does Toyota offer?', 'Toyota offers financing options through Toyota Financial Services.', 'Finance', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'How can I apply for Toyota financing?', 'You can apply for Toyota financing through any Toyota dealership or online.', 'Finance', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'Does Toyota offer leasing options?', 'Yes, Toyota offers leasing options for selected models.', 'Finance', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'What is the interest rate for Toyota financing?', 'Interest rates vary by region and financial institution.', 'Finance', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'Can I finance a used Toyota car?', 'Yes, Toyota offers financing for certified pre-owned vehicles.', 'Finance', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'Are there any promotions on Toyota financing?', 'Promotions are periodically available, check Toyota’s website.', 'Finance', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'Can I refinance my Toyota car loan?', 'Yes, refinancing options are available for eligible customers.', 'Finance', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'Is a down payment required for Toyota financing?', 'A down payment is typically required for Toyota financing.', 'Finance', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'Does Toyota have a financial calculator?', 'Toyota’s website offers a financing calculator to estimate costs.', 'Finance', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'How do I contact Toyota Financial Services?', 'Contact details are available on Toyota’s finance page.', 'Finance', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

-- Category: General
(1, 'What are Toyota’s business hours?', 'Most Toyota dealerships operate from 9 AM to 6 PM, Monday to Saturday.', 'General', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'Where is Toyota’s main office in Indonesia?', 'Toyota’s main office is located in Jakarta, Indonesia.', 'General', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'How can I find a Toyota dealership?', 'You can find a Toyota dealership using the locator on Toyota’s website.', 'General', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'Does Toyota offer test drives?', 'Yes, Toyota dealerships offer test drives for most models.', 'General', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'Can I buy Toyota merchandise?', 'Toyota merchandise is available through authorized dealers and online.', 'General', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'What is Toyota’s corporate social responsibility policy?', 'Toyota focuses on sustainability and community development.', 'General', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'How do I get updates on Toyota events?', 'Toyota events are posted on their website and social media.', 'General', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'Does Toyota have a loyalty program?', 'Yes, Toyota offers a loyalty program for repeat customers.', 'General', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'What are Toyota’s main competitors?', 'Toyota’s competitors include Honda, Nissan, and Hyundai.', 'General', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(1, 'How long has Toyota been in Indonesia?', 'Toyota has been operating in Indonesia for over 50 years.', 'General', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Data untuk Perusahaan dengan company_id 2 (Daihatsu)

INSERT INTO public.rag_source (company_id, question, answer, category, created_at, updated_at) VALUES
-- Category: Automotive
(2, 'What is the best car brand in Indonesia?', 'Daihatsu is considered one of the top car brands in Indonesia.', 'Automotive', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'What are Daihatsu’s popular models?', 'Popular Daihatsu models include Terios, Xenia, and Sigra.', 'Automotive', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'Does Daihatsu offer electric vehicles?', 'Daihatsu is exploring options for electric vehicles but currently focuses on fuel-efficient cars.', 'Automotive', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'What is the warranty period for Daihatsu cars?', 'Daihatsu offers a 3-year or 100,000 km warranty on all vehicles.', 'Automotive', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'Where can I find Daihatsu service centers?', 'Daihatsu service centers are available in major cities across Indonesia.', 'Customer Service', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'How can I book a service for my Daihatsu car?', 'Service bookings can be made through Daihatsu’s official website or at a dealership.', 'Customer Service', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'What financing options does Daihatsu offer?', 'Daihatsu offers financing options through various partner banks and institutions.', 'Finance', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'How can I apply for Daihatsu financing?', 'Applications for Daihatsu financing are available at dealerships and online.', 'Finance', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'What are Daihatsu’s business hours?', 'Daihatsu dealerships generally operate from 9 AM to 6 PM, Monday to Saturday.', 'General', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'What safety features are included in Daihatsu vehicles?', 'Daihatsu vehicles come with airbags, ABS, and side-impact protection.', 'Automotive', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),

-- Category: Customer Service
(2, 'Where are Daihatsu service centers located?', 'Daihatsu service centers are located across Indonesia.', 'Customer Service', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'What are the customer service hours?', 'Daihatsu customer service is available 9 AM to 6 PM, Monday to Saturday.', 'Customer Service', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'How can I check my service history?', 'Service history is available via the Daihatsu app.', 'Customer Service', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'How do I contact Daihatsu customer support?', 'Customer support can be contacted through Daihatsu hotline or email.', 'Customer Service', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'How do I file a warranty claim?', 'Warranty claims are processed at any Daihatsu service center.', 'Customer Service', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'Can I reschedule my service appointment?', 'Service appointments can be rescheduled by calling support.', 'Customer Service', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'Is roadside assistance available?', 'Yes, Daihatsu offers roadside assistance for select models.', 'Customer Service', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'What payment methods are accepted?', 'Payments can be made via credit card, debit card, and bank transfer.', 'Finance', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'How do I update my account information?', 'Account details can be updated on the Daihatsu website.', 'Account Management', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'How can I get discounts on service?', 'Discounts are occasionally available; check Daihatsu promotions.', 'Customer Service', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Add more data for Finance and General categories for company_id 2 as needed...


INSERT INTO rag_source(question,answer,category) VALUES ('What is the best car brand in Indonesia?','Toyota is considered one of the best car brands in Indonesia.','Automotive');
INSERT INTO rag_source(question,answer,category) VALUES ('What are Toyota’s top-selling models?','Toyota’s top-selling models include the Avanza, Fortuner, and Innova.','Automotive');
INSERT INTO rag_source(question,answer,category) VALUES ('Does Toyota offer electric cars?','Yes, Toyota offers hybrid and electric vehicles like the Toyota Prius and Corolla Hybrid.','Automotive');
INSERT INTO rag_source(question,answer,category) VALUES ('What is the warranty period for Toyota cars?','Toyota provides a standard 3-year or 100,000 km warranty.','Automotive');
INSERT INTO rag_source(question,answer,category) VALUES ('What safety features are included in Toyota vehicles?','Toyota includes safety features like airbags, ABS, and stability control.','Automotive');
INSERT INTO rag_source(question,answer,category) VALUES ('What fuel efficiency does Toyota offer?','Toyota offers high fuel efficiency across most models, especially hybrids.','Automotive');
INSERT INTO rag_source(question,answer,category) VALUES ('Are Toyota cars made in Indonesia?','Yes, Toyota has manufacturing plants in Indonesia.','Automotive');
INSERT INTO rag_source(question,answer,category) VALUES ('What is Toyota’s most affordable model?','The Toyota Agya is among the most affordable Toyota models.','Automotive');
INSERT INTO rag_source(question,answer,category) VALUES ('What is the resale value of Toyota cars?','Toyota cars generally have a high resale value.','Automotive');
INSERT INTO rag_source(question,answer,category) VALUES ('Does Toyota provide vehicle customization?','Yes, Toyota offers customization options for several models.','Automotive');
INSERT INTO rag_source(question,answer,category) VALUES ('Where are Toyota service centers located?','Toyota service centers are located in major cities across Indonesia.','Customer Service');
INSERT INTO rag_source(question,answer,category) VALUES ('How can I book a service for my Toyota car?','You can book a service online through Toyota’s official website or app.','Customer Service');
INSERT INTO rag_source(question,answer,category) VALUES ('What are Toyota’s customer service hours?','Toyota’s customer service is available from 9 AM to 6 PM.','Customer Service');
INSERT INTO rag_source(question,answer,category) VALUES ('Does Toyota offer roadside assistance?','Yes, Toyota offers roadside assistance for specific models.','Customer Service');
INSERT INTO rag_source(question,answer,category) VALUES ('How do I file a complaint?','You can file a complaint through Toyota’s customer support line.','Customer Service');
INSERT INTO rag_source(question,answer,category) VALUES ('Can I reschedule my service appointment?','Yes, service appointments can be rescheduled online or by calling support.','Customer Service');
INSERT INTO rag_source(question,answer,category) VALUES ('How do I check my service history?','Your service history can be accessed through Toyota’s app.','Customer Service');
INSERT INTO rag_source(question,answer,category) VALUES ('What is the process for claiming warranty?','You can claim warranty by visiting an authorized service center.','Customer Service');
INSERT INTO rag_source(question,answer,category) VALUES ('Does Toyota provide free maintenance?','Toyota offers free maintenance on select models during the initial ownership period.','Customer Service');
INSERT INTO rag_source(question,answer,category) VALUES ('How can I contact Toyota customer support?','You can contact customer support through their hotline or email.','Customer Service');
INSERT INTO rag_source(question,answer,category) VALUES ('What financing options does Toyota offer?','Toyota offers financing options through Toyota Financial Services.','Finance');
INSERT INTO rag_source(question,answer,category) VALUES ('How can I apply for Toyota financing?','You can apply for Toyota financing through any Toyota dealership or online.','Finance');
INSERT INTO rag_source(question,answer,category) VALUES ('Does Toyota offer leasing options?','Yes, Toyota offers leasing options for selected models.','Finance');
INSERT INTO rag_source(question,answer,category) VALUES ('What is the interest rate for Toyota financing?','Interest rates vary by region and financial institution.','Finance');
INSERT INTO rag_source(question,answer,category) VALUES ('Can I finance a used Toyota car?','Yes, Toyota offers financing for certified pre-owned vehicles.','Finance');
INSERT INTO rag_source(question,answer,category) VALUES ('Are there any promotions on Toyota financing?','Promotions are periodically available, check Toyota’s website.','Finance');
INSERT INTO rag_source(question,answer,category) VALUES ('Can I refinance my Toyota car loan?','Yes, refinancing options are available for eligible customers.','Finance');
INSERT INTO rag_source(question,answer,category) VALUES ('Is a down payment required for Toyota financing?','A down payment is typically required for Toyota financing.','Finance');
INSERT INTO rag_source(question,answer,category) VALUES ('Does Toyota have a financial calculator?','Toyota’s website offers a financing calculator to estimate costs.','Finance');
INSERT INTO rag_source(question,answer,category) VALUES ('How do I contact Toyota Financial Services?','Contact details are available on Toyota’s finance page.','Finance');
INSERT INTO rag_source(question,answer,category) VALUES ('What are Toyota’s business hours?','Most Toyota dealerships operate from 9 AM to 6 PM, Monday to Saturday.','General');
INSERT INTO rag_source(question,answer,category) VALUES ('Where is Toyota’s main office in Indonesia?','Toyota’s main office is located in Jakarta, Indonesia.','General');
INSERT INTO rag_source(question,answer,category) VALUES ('How can I find a Toyota dealership?','You can find a Toyota dealership using the locator on Toyota’s website.','General');
INSERT INTO rag_source(question,answer,category) VALUES ('Does Toyota offer test drives?','Yes, Toyota dealerships offer test drives for most models.','General');
INSERT INTO rag_source(question,answer,category) VALUES ('Can I buy Toyota merchandise?','Toyota merchandise is available through authorized dealers and online.','General');
INSERT INTO rag_source(question,answer,category) VALUES ('What is Toyota’s corporate social responsibility policy?','Toyota focuses on sustainability and community development.','General');
INSERT INTO rag_source(question,answer,category) VALUES ('How do I get updates on Toyota events?','Toyota events are posted on their website and social media.','General');
INSERT INTO rag_source(question,answer,category) VALUES ('Does Toyota have a loyalty program?','Yes, Toyota offers a loyalty program for repeat customers.','General');
INSERT INTO rag_source(question,answer,category) VALUES ('What are Toyota’s main competitors?','Toyota’s competitors include Honda, Nissan, and Hyundai.','General');
INSERT INTO rag_source(question,answer,category) VALUES ('How long has Toyota been in Indonesia?','Toyota has been operating in Indonesia for over 50 years.','General');
INSERT INTO rag_source(question,answer,category) VALUES ('How can I track my service appointment?','You can track your service appointment through Toyota’s app or website.','Customer Service',NULL,NULL,'02:29.5','02:29.5',NULL);
INSERT INTO rag_source(question,answer,category) VALUES ('Can I cancel my Toyota service appointment online?','Yes, service appointments can be canceled online via Toyota’s app or by contacting support.','Customer Service',NULL,NULL,'02:29.5','02:29.5',NULL);
INSERT INTO rag_source(question,answer,category) VALUES ('What documents do I need to claim a warranty?','You need the vehicle registration and purchase invoice for warranty claims.','Customer Service',NULL,NULL,'02:29.5','02:29.5',NULL);
INSERT INTO rag_source(question,answer,category) VALUES ('Does Toyota provide live chat support?','Yes, Toyota offers live chat support during business hours.','Customer Service',NULL,NULL,'02:29.5','02:29.5',NULL);
INSERT INTO rag_source(question,answer,category) VALUES ('How long does a typical Toyota service take?','A typical Toyota service takes about 1 to 2 hours.','Customer Service',NULL,NULL,'02:29.5','02:29.5',NULL);
INSERT INTO rag_source(question,answer,category) VALUES ('What is the cost of a Toyota diagnostic service?','The cost varies but starts at approximately IDR 500,000.','Customer Service',NULL,NULL,'02:29.5','02:29.5',NULL);
INSERT INTO rag_source(question,answer,category) VALUES ('Does Toyota offer mobile servicing?','Yes, Toyota offers mobile servicing in select areas.','Customer Service',NULL,NULL,'02:29.5','02:29.5',NULL);
INSERT INTO rag_source(question,answer,category) VALUES ('Are replacement parts covered in the warranty?','Yes, replacement parts are generally covered under the warranty terms.','Customer Service',NULL,NULL,'02:29.5','02:29.5',NULL);
INSERT INTO rag_source(question,answer,category) VALUES ('Can I transfer my Toyota warranty to another owner?','Yes, Toyota warranties can be transferred to a new owner.','Customer Service',NULL,NULL,'02:29.5','02:29.5',NULL);
INSERT INTO rag_source(question,answer,category) VALUES ('How do I report a service issue with Toyota?','You can report service issues through Toyota’s hotline or website.','Customer Service',NULL,NULL,'02:29.5','02:29.5',NULL);
INSERT INTO rag_source(question,answer,category) VALUES ('What are the latest Toyota models?','Toyota’s latest models include the Corolla Cross and Hilux GR-Sport.','Automotive',NULL,NULL,'02:29.5','02:29.5',NULL);
INSERT INTO rag_source(question,answer,category) VALUES ('Does Toyota have luxury vehicles?','Yes, Toyota offers luxury vehicles like the Toyota Crown.','Automotive',NULL,NULL,'02:29.5','02:29.5',NULL);
INSERT INTO rag_source(question,answer,category) VALUES ('Which Toyota model is best for families?','The Toyota Innova is ideal for families due to its spacious design.','Automotive',NULL,NULL,'02:29.5','02:29.5',NULL);
INSERT INTO rag_source(question,answer,category) VALUES ('What is the towing capacity of a Toyota Hilux?','The Toyota Hilux has a towing capacity of up to 3,500 kg.','Automotive',NULL,NULL,'02:29.5','02:29.5',NULL);
INSERT INTO rag_source(question,answer,category) VALUES ('Does Toyota produce manual transmission cars?','Yes, Toyota still produces manual transmission vehicles for select models.','Automotive',NULL,NULL,'02:29.5','02:29.5',NULL);
INSERT INTO rag_source(question,answer,category) VALUES ('Are there any Toyota sports cars available?','Yes, Toyota offers sports cars like the GR Supra and GR86.','Automotive',NULL,NULL,'02:29.5','02:29.5',NULL);
INSERT INTO rag_source(question,answer,category) VALUES ('What is the range of Toyota’s electric vehicles?','Toyota’s electric vehicles have a range of up to 500 km.','Automotive',NULL,NULL,'02:29.5','02:29.5',NULL);
INSERT INTO rag_source(question,answer,category) VALUES ('Does Toyota offer off-road vehicles?','Yes, Toyota offers off-road models like the Land Cruiser.','Automotive',NULL,NULL,'02:29.5','02:29.5',NULL);
INSERT INTO rag_source(question,answer,category) VALUES ('How long does a Toyota hybrid battery last?','Toyota hybrid batteries typically last 8 to 10 years.','Automotive',NULL,NULL,'02:29.5','02:29.5',NULL);
INSERT INTO rag_source(question,answer,category) VALUES ('What is Toyota’s most eco-friendly car?','The Toyota Prius is one of the most eco-friendly cars by Toyota.','Automotive',NULL,NULL,'02:29.5','02:29.5',NULL);
INSERT INTO rag_source(question,answer,category) VALUES ('What are the requirements for Toyota financing?','You need a valid ID, proof of income, and a down payment for Toyota financing.','Finance',NULL,NULL,'02:29.5','02:29.5',NULL);
INSERT INTO rag_source(question,answer,category) VALUES ('Can I apply for Toyota financing as a business owner?','Yes, business owners can apply for Toyota financing with additional documentation.','Finance',NULL,NULL,'02:29.5','02:29.5',NULL);
INSERT INTO rag_source(question,answer,category) VALUES ('How is Toyota financing approval decided?','Approval depends on credit score, income stability, and down payment amount.','Finance',NULL,NULL,'02:29.5','02:29.5',NULL);
INSERT INTO rag_source(question,answer,category) VALUES ('Does Toyota offer financing for students?','Yes, Toyota offers student financing programs for eligible applicants.','Finance',NULL,NULL,'02:29.5','02:29.5',NULL);
INSERT INTO rag_source(question,answer,category) VALUES ('Are there any hidden fees in Toyota financing?','No, Toyota financing terms are transparent without hidden fees.','Finance',NULL,NULL,'02:29.5','02:29.5',NULL);
INSERT INTO rag_source(question,answer,category) VALUES ('How can I calculate my Toyota loan payments?','You can use Toyota’s online loan calculator to estimate payments.','Finance',NULL,NULL,'02:29.5','02:29.5',NULL);
INSERT INTO rag_source(question,answer,category) VALUES ('Does Toyota offer 0% financing?','Yes, Toyota offers 0% financing during promotional periods.','Finance',NULL,NULL,'02:29.5','02:29.5',NULL);
INSERT INTO rag_source(question,answer,category) VALUES ('Can I defer my Toyota loan payments?','Yes, deferment options are available under certain conditions.','Finance',NULL,NULL,'02:29.5','02:29.5',NULL);
INSERT INTO rag_source(question,answer,category) VALUES ('Is insurance included in Toyota financing packages?','No, insurance is not included but can be added as an extra package.','Finance',NULL,NULL,'02:29.5','02:29.5',NULL);
INSERT INTO rag_source(question,answer,category) VALUES ('How can I pay off my Toyota loan early?','You can pay off your loan early by contacting Toyota Financial Services.','Finance',NULL,NULL,'02:29.5','02:29.5',NULL);
INSERT INTO rag_source(question,answer,category) VALUES ('What is Toyota’s mission statement?','Toyota’s mission is to produce quality vehicles that enhance lives worldwide.','General',NULL,NULL,'02:29.5','02:29.5',NULL);
INSERT INTO rag_source(question,answer,category) VALUES ('How many employees does Toyota have worldwide?','Toyota employs over 360,000 people globally.','General',NULL,NULL,'02:29.5','02:29.5',NULL);
INSERT INTO rag_source(question,answer,category) VALUES ('Does Toyota participate in motorsports?','Yes, Toyota participates in motorsports like NASCAR and WEC.','General',NULL,NULL,'02:29.5','02:29.5',NULL);
INSERT INTO rag_source(question,answer,category) VALUES ('What is Toyota’s environmental impact policy?','Toyota aims to reduce carbon emissions and promote sustainability.','General',NULL,NULL,'02:29.5','02:29.5',NULL);
INSERT INTO rag_source(question,answer,category) VALUES ('Can I tour a Toyota manufacturing plant?','Yes, Toyota offers tours at select manufacturing plants.','General',NULL,NULL,'02:29.5','02:29.5',NULL);
INSERT INTO rag_source(question,answer,category) VALUES ('Does Toyota have a research and development division?','Yes, Toyota has a dedicated R&D division for innovation.','General',NULL,NULL,'02:29.5','02:29.5',NULL);
INSERT INTO rag_source(question,answer,category) VALUES ('How can I get updates on Toyota’s new releases?','You can subscribe to Toyota’s newsletter or follow their social media.','General',NULL,NULL,'02:29.5','02:29.5',NULL);
INSERT INTO rag_source(question,answer,category) VALUES ('Does Toyota have a certified pre-owned program?','Yes, Toyota offers a certified pre-owned vehicle program.','General',NULL,NULL,'02:29.5','02:29.5',NULL);
INSERT INTO rag_source(question,answer,category) VALUES ('Where can I buy genuine Toyota accessories?','Genuine Toyota accessories can be purchased at dealerships or online.','General',NULL,NULL,'02:29.5','02:29.5',NULL);
INSERT INTO rag_source(question,answer,category) VALUES ('What is Toyota’s return policy for accessories?','Toyota allows returns of accessories within 30 days with proof of purchase.','General',NULL,NULL,'02:29.5','02:29.5',NULL);
