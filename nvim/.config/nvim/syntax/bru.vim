" === bruno Syntax ===

" Define filetype for 'bruno'
if exists("b:current_syntax")
  finish
endif
let b:current_syntax = "bruno"

" === String matching ===
syntax region brunoString start="\"" end="\"" contains=brunoEscape
highlight link brunoString String

syntax match brunoEscape /\\./
highlight link brunoEscape SpecialChar

" === Define the Dictionary Block ===
" This will match key-value pairs in blocks like `get { key: value }`
syntax match brunoDictionaryKeyValue /^\s*\([^:]*\)\s*:\s*\(.*\)$/ 
highlight link brunoDictionaryKeyValue Keyword

" This matches the key part (before the colon)
syntax match brunoDictionaryKey /^\s*\(~\?\w\+\(-\w\+\)*\)\s*:/ 
highlight link brunoDictionaryKey Identifier

" This matches the value part (after the colon)
syntax match brunoDictionaryValue /:\s*\(.*\)$/ 
highlight link brunoDictionaryValue String

" === @brunoDictionary Definition ===
" Define a region for key-value pairs (dictionary) to be reused in different blocks
syntax region brunoDictionary start="{" end="}" contains=brunoDictionaryKeyValue
highlight link brunoDictionary Keyword

" === Meta-block (e.g., meta { }) ===
syntax region brunoMetaBlock start="^\s*meta\s*{" end="^\s*}\s*" 
highlight link brunoMetaBlock Keyword
syntax include @brunoDictionary syntax/bru.vim

" === HTTP Method Blocks ===
" Example for a block like `get { ... }`
syntax region brunoGetBlock start="^\s*get\s*{" end="^\s*}\s*"
highlight link brunoGetBlock Keyword
syntax include @brunoDictionary syntax/bru.vim

syntax region brunoPostBlock start="^\s*post\s*{" end="^\s*}\s*"
highlight link brunoPostBlock Keyword
syntax include @brunoDictionary syntax/bru.vim

syntax region brunoPutBlock start="^\s*put\s*{" end="^\s*}\s*"
highlight link brunoPutBlock Keyword
syntax include @brunoDictionary syntax/bru.vim

syntax region brunoDeleteBlock start="^\s*delete\s*{" end="^\s*}\s*"
highlight link brunoDeleteBlock Keyword
syntax include @brunoDictionary syntax/bru.vim

syntax region brunoOptionsBlock start="^\s*options\s*{" end="^\s*}\s*"
highlight link brunoOptionsBlock Keyword
syntax include @brunoDictionary syntax/bru.vim

syntax region brunoHeadBlock start="^\s*head\s*{" end="^\s*}\s*"
highlight link brunoHeadBlock Keyword
syntax include @brunoDictionary syntax/bru.vim

syntax region brunoTraceBlock start="^\s*trace\s*{" end="^\s*}\s*"
highlight link brunoTraceBlock Keyword
syntax include @brunoDictionary syntax/bru.vim

syntax region brunoConnectBlock start="^\s*connect\s*{" end="^\s*}\s*"
highlight link brunoConnectBlock Keyword
syntax include @brunoDictionary syntax/bru.vim

" === Query and Headers Blocks ===
syntax region brunoQueryBlock start="^\s*query\s*{" end="^\s*}\s*"
highlight link brunoQueryBlock Keyword
syntax include @brunoDictionary syntax/bru.vim

syntax region brunoHeadersBlock start="^\s*headers\s*{" end="^\s*}\s*"
highlight link brunoHeadersBlock Keyword
syntax include @brunoDictionary syntax/bru.vim

" === Body Blocks ===
syntax region brunoBodyBlock start="^\s*body\s*{" end="^\s*}\s*"
highlight link brunoBodyBlock Keyword
syntax include @json syntax/json.vim

syntax region brunoBodyJsonBlock start="^\s*body\s*json\s*{" end="^\s*}\s*"
highlight link brunoBodyJsonBlock Keyword
syntax include @json syntax/json.vim

syntax region brunoBodyTextBlock start="^\s*body\s*text\s*{" end="^\s*}\s*"
highlight link brunoBodyTextBlock Keyword
syntax include @markdown syntax/markdown.vim

syntax region brunoBodyXmlBlock start="^\s*body\s*xml\s*{" end="^\s*}\s*"
highlight link brunoBodyXmlBlock Keyword
syntax include @xml syntax/markdown.vim

syntax region brunoBodyFormUrlEncodedBlock start="^\s*body\s*form-urlencoded\s*{" end="^\s*}\s*"
highlight link brunoBodyFormUrlEncodedBlock Keyword
syntax include @brunoDictionary syntax/bru.vim

syntax region brunoBodyMultipartFormBlock start="^\s*body\s*multipart-form\s*{" end="^\s*}\s*"
highlight link brunoBodyMultipartFormBlock Keyword
syntax include @brunoDictionary syntax/bru.vim

syntax region brunoBodyGraphqlBlock start="^\s*body\s*graphql\s*{" end="^\s*}\s*"
highlight link brunoBodyGraphqlBlock Keyword
" syntax include @graphql syntax/graphql.vim

syntax region brunoBodyGraphqlVarsBlock start="^\s*body\s*graphql:vars\s*{" end="^\s*}\s*"
highlight link brunoBodyGraphqlVarsBlock Keyword
syntax include @json syntax/json.vim

" === Vars Blocks ===
syntax region brunoVarsBlock start="^\s*vars\s*{" end="^\s*}\s*"
highlight link brunoVarsBlock Keyword
syntax include @brunoDictionary syntax/bru.vim

syntax region brunoVarsReqBlock start="^\s*vars:pre-request\s*{" end="^\s*}\s*"
highlight link brunoVarsReqBlock Keyword
syntax include @brunoDictionary syntax/bru.vim

syntax region brunoVarsResBlock start="^\s*vars:post-response\s*{" end="^\s*}\s*"
highlight link brunoVarsResBlock Keyword
syntax include @brunoDictionary syntax/bru.vim

" === Assert Block ===
syntax region brunoAssertBlock start="^\s*assert\s*{" end="^\s*}\s*"
highlight link brunoAssertBlock Keyword
syntax include @brunoDictionary syntax/bru.vim

" === Script Blocks ===
syntax region brunoScriptReqBlock start="^\s*script:pre-request\s*{" end="^\s*}\s*"
highlight link brunoScriptReqBlock Keyword
syntax include @js syntax/javascript.vim

syntax region brunoScriptResBlock start="^\s*script:post-response\s*{" end="^\s*}\s*"
highlight link brunoScriptResBlock Keyword
syntax include @js syntax/javascript.vim

" === Tests Block ===
syntax region brunoTestsBlock start="^\s*tests\s*{" end="^\s*}\s*"
highlight link brunoTestsBlock Keyword
syntax include @js syntax/javascript.vim

" === Docs Block ===
syntax region brunoDocsBlock start="^\s*docs\s*{" end="^\s*}\s*"
highlight link brunoDocsBlock Keyword
syntax include @markdown syntax/markdown.vim

" === Include External Filetype Syntax ===
" Here we use the proper Vim syntax for including external filetypes
" This is assuming you have the proper syntax files for these filetypes

" Include JSON syntax
augroup BruJSON
  autocmd!
  autocmd FileType bru syntax include @json
augroup END

" Include JavaScript syntax
augroup BruJS
  autocmd!
  autocmd FileType bru syntax include @javascript
augroup END

" Include XML syntax
augroup BruXML
  autocmd!
  autocmd FileType bru syntax include @xml
augroup END

" Include GraphQL syntax
augroup BruGraphQL
  autocmd!
  autocmd FileType bru syntax include @graphql
augroup END

" Include Markdown syntax
augroup BruMarkdown
  autocmd!
  autocmd FileType bru syntax include @markdown
augroup END

