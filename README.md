## Trucking Nexus

## Summary:

Trucking Nexus is a Ruby on Rails application that serves as your one-stop destination for all things trucking-related. Whether you're a professional truck driver, an aspiring CDL (Commercial Driver's License) holder, or just an enthusiast looking to stay updated on the trucking industry, Trucking Nexus has you covered.

## Key Features:

- **Job Rating System:** Rate and review trucking jobs at different companies, helping fellow truckers make informed decisions about their career choices.

- **CDL Test Training:** Access comprehensive training materials and practice tests to prepare for your CDL exams, ensuring you're well-equipped for success.

- **Trip Planning (Not Available):** Plan your route with Google Maps API. Print completed DOT time sheets using the FMSCA time sheet form.

## Technologies Used:

- Ruby on Rails
- HTML/CSS (ERB & Tailwind.css)
- JavaScript (Stimulus JS)
- ActiveStorage image file uploading
- RSpec / Capybara for Testing
- Docker / Deployment
- 
## Images
Work in Progress
CDL Quiz | Results
:-------------------------:|:-------------------------:
![Screenshot from 2024-03-07 08-52-34](https://github.com/Nick-Damico/truckingnexus/assets/19657584/be0346fe-209d-4159-a2a5-963b7b71e136) | ![Screenshot from 2024-03-07 09-02-13](https://github.com/Nick-Damico/truckingnexus/assets/19657584/e750922f-6cb2-44f3-ac75-7aa37ab3ad3e)


Dashboard | Reviews
:-------------------------:|:-------------------------:
![Screenshot from 2024-03-07 08-53-04](https://github.com/Nick-Damico/truckingnexus/assets/19657584/f57d4d0a-4713-45eb-88c1-9512de24d2a8) | ![Screenshot from 2024-03-07 08-52-47](https://github.com/Nick-Damico/truckingnexus/assets/19657584/4b18ba66-353a-49ad-ae59-e05db8b914f0)


## Installation:

1. Copy Repository locally

```bash
git clone https://github.com/Nick-Damico/truckingnexus.git
cd /truckingnexus
```

2. Install dependencies

```bash
bundle install
```

3. Setup the database

```bash
bin/rails db:setup
```

4. Start Server

```bash
./bin/dev
# or if you use overmind
overmind start
# or just use
bin/rails server
```

### Docker

If you prefer to use Docker and have it installed

1. Modify production config `SSL` setting:

```ruby
# config/production.rb

# Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
config.force_ssl = false # swith to false if true
```

2. Start App and DB containers

```bash
docker compose up
```

3. Access site

```bash
localhost:3000
```

2. Stop and tear down

```bash
docker compose down --rmi all
```

## File Upload

Active Storage is using the `image_processing` gem
along with `mini_magick` gem, a lightweight wrapper around `imagemagick`.

This is used for generating variant images from attachables.
This can be changed via the `application.rb`.

Development is using local storage.
Production is using `Amazon S3`

### AWS S3

TruckingNexus is configured to use Amazon S3 in production.

You just need to setup a bucket and IAM user with policies per the documentation
form the [Rails ActiveStorage guide](https://edgeguides.rubyonrails.org/active_storage_overview.html#s3-service-amazon-s3-and-s3-compatible-apis)

**Tip:** The best way to test that the bucket and policy is setup correctly and objects are **publicly accessible**, is to update the `development.rb` config file for active_storage from `:local` to `:amazon`.

## Usage:

Trucking Nexus is designed with simplicity in mind. Sign up, browse trucking job listings, rate your experiences, access CDL test prep materials, and stay informed about the trucking industry—all within a few clicks.

## Development

### Running Dev with Overmind

- `brew install tmux`
- `brew install overmind`

Start up development environment with command: `overmind start`

### Running Dev with Foreman

Start up development environment with command: `./bin/dev`

## Design

- **Quizzes:** [dbdiagrm.io Quizzes] (https://dbdiagram.io/d/testing-6512dd32ffbf5169f08733cb)

### Quizzes

## Contributing:

We welcome contributions from the trucking community and developers alike. Whether you want to suggest features, report bugs, or submit code improvements, please follow our [contribution guidelines on GitHub](link_to_contributing_guidelines).

## License:

Trucking Nexus is an open-source project released under the [license_name] license. See the [LICENSE](link_to_license_file) file for details.

## Contact:

- GitHub Repository: [Link to your GitHub repository]
- Email: [Your contact email address, if applicable]
- [Other contact methods if relevant, such as a website or social media]

## Demo:

## Screenshots:
