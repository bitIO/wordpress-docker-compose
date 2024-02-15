# TROUBLESHOOTING

This document contains a list of common issues and their solutions.

## Table of Contents

- [phpmyadmin] add a new wordpress admin user
- [wordpress] Deprecated: Unparenthesized `a ? b : c ? d : e` is deprecated

### [phpmyadmin] add a new wordpress admin user

<https://themeisle.com/blog/new-wordpress-admin-user/#:~:text=How%20to%20create%20a%20new%20WordPress%20admin%20user,4%20Step%204%3A%20Insert%20user%20meta%20values%20>

### [wordpress] Deprecated: Unparenthesized `a ? b : c ? d : e` is deprecated

Fixing the 673 line just by adding parenthesis So just replace :

```php
$host = (isset( $s['HTTP_X_FORWARDED_HOST'] ) ? $s['HTTP_X_FORWARDED_HOST'] : isset( $s['HTTP_HOST'] )) ? $s['HTTP_HOST'] : $s['SERVER_NAME'];
```

with

```php
if ( isset( $s['HTTP_X_FORWARDED_HOST'] ) ) {
  $host = $s['HTTP_X_FORWARDED_HOST'];
} else {
  $host = ( isset( $s['HTTP_HOST'] ) ? $s['HTTP_HOST'] : $s['SERVER_NAME'] );
}
```

<https://stackoverflow.com/questions/63419004/deprecated-unparenthesized-a-b-c-d-e-is-deprecated>
