{*-------------------------------------------------------+
| Project 60 - CiviBanking                               |
| Copyright (C) 2013-2015 SYSTOPIA                       |
| Author: B. Endres (endres -at- systopia.de)            |
| http://www.systopia.de/                                |
+--------------------------------------------------------+
| This program is released as free software under the    |
| Affero GPL v3 license. You can redistribute it and/or  |
| modify it under the terms of this license which you    |
| can read by viewing the included agpl.txt or online    |
| at www.gnu.org/licenses/agpl.html. Removal of this     |
| copyright header is strictly prohibited without        |
| written permission from the original author(s).        |
+--------------------------------------------------------*}

{assign var=contact_id value=$contact.id}
{assign var=contribution_id value=$contribution.id}
{assign var=mandate_id value=$mandate.id}

<h1>{ts 1=$mandate.type}SEPA %1 Cancellation Notification{/ts}</h1>
<table>
  <tr>
    <td>{ts}Mandate{/ts}</td>
    <td>({$mandate.type}) <a href="{crmURL p="civicrm/sepa/xmandate" q="mid=$mandate_id"}">{$mandate.reference}</a></td>
  </tr>
  <tr>
    <td>{ts}Contribution{/ts}</td>
    <td>
      <a href="{crmURL p="civicrm/contact/view/contribution" q="reset=1&id=$contribution_id&cid=$contact_id&action=view"}">
      {$contribution.receive_date|crmDate:$config->dateformatFull} [{$contribution.id}]<br/>
      {$contribution.total_amount|crmMoney:$contribution.currency} {$contribution.financial_type}
      </a>
    </td>
  </tr>
  <tr>
    <td>{ts}Cancellation{/ts}</td>
    <td>
      <a href="{crmURL p="civicrm/contact/view/contribution" q="reset=1&id=$contribution_id&cid=$contact_id&action=view"}">
      {$contribution.cancel_date|crmDate:$config->dateformatFull} [{$contribution.id}]<br/>
      {$cancel_fee|crmMoney:$contribution.currency} - "{$contribution.cancel_reason}"
      {if $mandate.type eq 'RCUR'}
        <br/>
        {if $cancelled_contribution_count eq 1}
          ({ts}first time (in a row){/ts})
        {else}
          <b>({ts 1=$cancelled_contribution_count}%1 times in a row!{/ts})</b>
        {/if}
      {/if}
      </a>
    </td>
  </tr>
  <tr>
    <td>{ts}Contact{/ts}</td>
    <td><a href="{crmURL p="civicrm/contact/view" q="reset=1&cid=$contact_id"}">{$contact.display_name} [{$contact.id}]</a></td>
  </tr>
  <tr>
    <td>{ts}Contact Address{/ts}</td>
    {if $contact.street_address or $contact.city}
    <td>{$contact.street_address}, {$contact.postal_code} {$contact.city}</td>
    {else}
    <td><i>{ts}unknown{/ts}</i></td>
    {/if}
  </tr>
  <tr>
    <td>{ts}Contact Phone Number{/ts}</td>
    {if $contact.phone}
    <td>{$contact.phone}</td>
    {else}
    <td><i>{ts}unknown{/ts}</i></td>
    {/if}
  </tr>
  <tr>
    <td>{ts}Contact Email{/ts}</td>
    {if $contact.email}
    <td>{$contact.email}</td>
    {else}
    <td><i>{ts}unknown{/ts}</i></td>
    {/if}
  </tr>
</table>