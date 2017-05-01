## What is This?

During late 2016 and early 2017 I worked with a diverse and ambitious team based in San Francisco on a startup that was geared towards helping new immigrants to the United States find meaningful work and get on their feet in America quickly.

The project was fundamentally a job-matching web platform, with a focus on cultural sensitivity and the specific needs of immigrants.

I headed the engineering efforts for the project during its earliest stages, while the team was all-volunteer, and unincorporated. My goal was to deliver a prototype platform that included real job-matching capability. As job-matching was the core value proposition of this platform, and the primary engineering challenge, it made sense to focus on demonstrating to funders that we were capable of delivering this requirement over the other, less technically-challenging features that are common in web applications.

I left the project before it was incorporated and my work was never used. I am publishing it here as part of my professional portfolio.

## Matching System

The platform matches users to jobs based on the following six dimensions:

- availability
- culture
- language
- location
- sex
- skills

The platform uses a scoring engine to generate a list of matches sorted by overall match score. This is utilized in the controller action `NominationsController#index`. The scoring engine itself can be found in the `app/services/kinployment` directory. All components are comprehensively unit tested. The system was architected in a modular fashion, to allow easy modification or replacement of matching logic as the team's understanding of business needs improved.

## To Run

Please see `developer_installation.md` for detailed instructions on installing and running the platform.

## Copyright

**Copyright © 2017 Nick McCrea**