# Multi-Tenant Access Control System

This Ruby on Rails application implements a sophisticated multi-tenant system with role-based access control and age-based content filtering. The system allows for organisations, spaces within organisations, and posts within spaces - all governed by a comprehensive permission system.

## Business Logic

### Core Entities

1. **Users**: Individual accounts with profiles and age information.
2. **Organisations**: Top-level containers that can have multiple users with different roles.
3. **Spaces**: Subdivisions within organisations that host content and have age restrictions.
4. **Posts**: Content items created within spaces, with age ratings for appropriate filtering.

### Membership & Role System

#### Organisation Memberships

Users can belong to organisations through the membership system with one of three roles:

- **Owner**: Has complete control over the organisation. Only one owner per organisation is allowed.
- **Admin**: Has administrative privileges but with some restrictions compared to owners.
- **Member**: Regular user with basic access to the organisation.

Memberships are stored in the `memberships` table, linking users to organisations with their respective roles.

#### Spaces Access

Users can access spaces through two mechanisms:

1. **Direct Access**: Through a `user_space` record that explicitly grants a user access to a space.
2. **Role-based Access**: Owners and admins of an organisation automatically have access to all spaces within that organisation without needing explicit `user_space` records.

### Access Control Rules

#### Organisation Access

- Users can only see organisations they are members of (owner, admin, or member).
- Only owners and admins can create new spaces within an organisation.

#### Space Access

- Space access is controlled by:
  - Organisation role (owners and admins have access to all spaces)
  - Direct space membership (through user_space records)
  - Age restrictions (spaces have min_age and max_age attributes)
  - Parental consent requirements (some spaces may require parental consent)

#### Post Visibility

- Posts have age ratings (general, teen, adult) that determine who can see them.
- Post visibility is filtered based on a user's age, but only for standard members.
- Organisation owners and admins can see all posts regardless of age rating for moderation purposes.

### Query System

The application implements a query interface for efficiently retrieving records based on user permissions and additional criteria:

- `OrganisationsQuery` filters organisations visible to a specific user.
- `Pundit` policies enforce permission checks throughout the application.

## Setup Instructions

### Prerequisites

- Ruby 3.2.0 or higher
- Rails 7.0.0 or higher
- PostgreSQL database
- Node.js and Yarn for the asset pipeline

### Installation

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd multi-tenant-access-control
   ```

2. Install dependencies:
   ```bash
   bundle install
   yarn install
   ```

3. Database setup:
   ```bash
   rails db:create
   rails db:migrate
   ```

4. Seed the database with initial data:
   ```bash
   rails db:seed
   ```

5. Start the Rails server:
   ```bash
   rails server
   ```

6. Access the application at `http://localhost:3000`

## Seed Data

The seed data creates:
- 3 users with different roles
- 3 organisations
- 3 spaces for each organisation with varying age restrictions
- 5 posts in each space with appropriate age ratings

## Key Features

### Automatic Space Access

When a space is created, the system automatically grants access to:
- The organisation's owner
- All organisation admins

### Age-based Content Filtering

Posts have three possible age ratings:
- **General**: Suitable for all ages
- **Teen**: Suitable for users 13 and older
- **Adult**: Suitable for users 18 and older

The system filters content based on user age, except for admins and owners who can see all content.

### Role-based Permissions

The application uses Pundit policies to enforce permissions:

- **Post management**: Users can only edit their own posts, but owners/admins can delete any post.
- **Space management**: Only owners and admins can create, edit, or delete spaces.
- **User space assignments**: Carefully controlled to respect organisational hierarchy.

## Testing

Run the test suite with:
```bash
rails test
```

## Development

This application uses:
- Turbo and Stimulus for frontend interactions
- Pundit for authorization
- Devise for authentication
- PostgreSQL for database
