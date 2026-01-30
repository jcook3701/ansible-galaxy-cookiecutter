<!--
  Auto-generated file. Do not edit directly.
  Edit /home/jcook/Documents/git_repo/ansible-galaxy-cookiecutter/docs/jekyll/README.md instead.
  Run ```make readme``` to regenerate this file
-->
<h1 id="ansible-galaxy-cookiecutter">ansible-galaxy-cookiecutter</h1>

<p><a href="LICENSE.md"><img src="https://img.shields.io/github/license/jcook3701/ansible-galaxy-cookiecutter" alt="License" /></a></p>

<p><strong>Author:</strong> Jared Cook<br />
<strong>Version:</strong> 0.1.1</p>

<h2 id="overview">Overview</h2>

<p>Ansible Galaxy cookiecutter template + integration with (github-docs-cookiecutter) Github docs template generation.</p>

<p>Ansible Galaxy cookiecutter template project /w Ansible Auto Documentation + <a href="https://github.com/jcook3701/github-docs-cookiecutter">Github docs</a> template generation + <a href="https://github.com/jcook3701/sphinx-cookiecutter">Sphinx docs</a> template generation.</p>

<hr />

<ul>
  <li><img src="https://github.com/jcook3701/ansible-galaxy-cookiecutter/actions/workflows/dependency-check.yml/badge.svg" alt="dependency-check" /></li>
  <li><img src="https://github.com/jcook3701/ansible-galaxy-cookiecutter/actions/workflows/format-check.yml/badge.svg" alt="format-check" /></li>
  <li><img src="https://github.com/jcook3701/ansible-galaxy-cookiecutter/actions/workflows/lint-check.yml/badge.svg" alt="lint-check" /></li>
  <li><img src="https://github.com/jcook3701/ansible-galaxy-cookiecutter/actions/workflows/security-audit.yml/badge.svg" alt="security-audit" /></li>
  <li><img src="https://github.com/jcook3701/ansible-galaxy-cookiecutter/actions/workflows/spellcheck.yml/badge.svg" alt="spellcheck" /></li>
  <li><img src="https://github.com/jcook3701/ansible-galaxy-cookiecutter/actions/workflows/tests.yml/badge.svg" alt="tests" /></li>
  <li><img src="https://github.com/jcook3701/ansible-galaxy-cookiecutter/actions/workflows/typecheck.yml/badge.svg" alt="typecheck" /></li>
</ul>

<hr />

<p><strong>Note:</strong> Unless you are using a newer version of cookiecutter &gt;= 2, <code class="language-plaintext highlighter-rouge">--no-input</code> is necessary for template generation without error.</p>

<h2 id="usage-examples">Usage Examples</h2>

<p><strong>Example:</strong> Pull from main branch.<br />
<strong>Note:</strong> <a href="https://github.com/jcook3701/nutri-matic">Nutri-Matic</a> is needed in active python environment.</p>

<div class="language-shell highlighter-rouge"><div class="highlight"><pre class="highlight"><code><span class="nv">$ </span>cookiecutter git@github.com:jcook3701/ansible-galaxy-cookiecutter.git <span class="se">\</span>
    <span class="nt">--no-input</span> <span class="se">\</span>
    <span class="nv">namespace</span><span class="o">=</span><span class="s2">"jcook3701"</span> <span class="se">\</span>
    <span class="nv">project_name</span><span class="o">=</span><span class="s2">"test-project"</span> <span class="se">\</span>
    <span class="nv">description</span><span class="o">=</span><span class="s2">"Ansible test project."</span>
</code></pre></div></div>

<p><strong>Example:</strong> Pull from develop branch.</p>

<div class="language-shell highlighter-rouge"><div class="highlight"><pre class="highlight"><code><span class="nv">$ </span>cookiecutter git@github.com:jcook3701/ansible-galaxy-cookiecutter.git <span class="se">\</span>
    <span class="nt">--checkout</span> develop <span class="se">\</span>
     <span class="nt">--no-input</span> <span class="se">\</span>
    <span class="nv">namespace</span><span class="o">=</span><span class="s2">"jcook3701"</span> <span class="se">\</span>
    <span class="nv">project_name</span><span class="o">=</span><span class="s2">"test-project"</span> <span class="se">\</span>
    <span class="nv">description</span><span class="o">=</span><span class="s2">"Ansible test project."</span>
</code></pre></div></div>

<p><strong>Note:</strong> replace <code class="language-plaintext highlighter-rouge">test-project</code> or any of the other variables with real context configuration variables.</p>

<hr />

<h2 id="development-strategy">Development Strategy</h2>

<p><strong>Note:</strong> All Makefile commands are used in ci/cd to ensure that if they pass locally they should also pass once pushed to github.</p>

<h3 id="️-build-environment-venv">🐍️ Build environment (.venv)</h3>

<div class="language-shell highlighter-rouge"><div class="highlight"><pre class="highlight"><code><span class="nv">$ </span>make <span class="nb">install</span>
</code></pre></div></div>

<h3 id="-dependency-management-deptry">🧬 Dependency Management (deptry)</h3>

<div class="language-shell highlighter-rouge"><div class="highlight"><pre class="highlight"><code><span class="nv">$ </span>make dependency-check
</code></pre></div></div>

<h3 id="️-security-audit-pip-audit">🛡️ Security Audit (pip-audit)</h3>

<div class="language-shell highlighter-rouge"><div class="highlight"><pre class="highlight"><code><span class="nv">$ </span>make security
</code></pre></div></div>

<h3 id="-formatting-black">🎨 Formatting (black)</h3>

<div class="language-shell highlighter-rouge"><div class="highlight"><pre class="highlight"><code><span class="nv">$ </span>make format-check
</code></pre></div></div>

<div class="language-shell highlighter-rouge"><div class="highlight"><pre class="highlight"><code><span class="nv">$ </span>make format-fix
</code></pre></div></div>

<h3 id="-linting-jinja2-cli-ruff-tomllint--yaml-lint">🔍 Linting (jinja2-cli, ruff, tomllint, &amp; yaml-lint)</h3>

<div class="language-shell highlighter-rouge"><div class="highlight"><pre class="highlight"><code><span class="nv">$ </span>make lint-check
</code></pre></div></div>

<div class="language-shell highlighter-rouge"><div class="highlight"><pre class="highlight"><code><span class="nv">$ </span>make lint-fix
</code></pre></div></div>

<h3 id="-spellchecking-codespell">🎓 Spellchecking (codespell)</h3>

<div class="language-shell highlighter-rouge"><div class="highlight"><pre class="highlight"><code><span class="nv">$ </span>make spellcheck
</code></pre></div></div>

<h3 id="-typechecking-mypy">🧠 Typechecking (mypy)</h3>

<div class="language-shell highlighter-rouge"><div class="highlight"><pre class="highlight"><code><span class="nv">$ </span>make typecheck
</code></pre></div></div>

<h3 id="-testing-pytest">🧪 Testing (pytest)</h3>

<div class="language-shell highlighter-rouge"><div class="highlight"><pre class="highlight"><code><span class="nv">$ </span>make <span class="nb">test</span>
</code></pre></div></div>

<h3 id="-release-git-tag">🚀 Release (git tag)</h3>

<div class="language-shell highlighter-rouge"><div class="highlight"><pre class="highlight"><code><span class="nv">$ </span>make release
</code></pre></div></div>

<h3 id="-build-help">❓ Build Help</h3>

<div class="language-shell highlighter-rouge"><div class="highlight"><pre class="highlight"><code><span class="nv">$ </span>make <span class="nb">help</span>
</code></pre></div></div>

<h2 id="commit-help">Commit Help</h2>

<p><strong>Note:</strong> Commits are required to be conventional git commit message.  This helps with the auto-generation of the changelog files and is enforced by pre-commit.<br />
<strong>example:</strong></p>

<div class="language-shell highlighter-rouge"><div class="highlight"><pre class="highlight"><code>&lt;<span class="nb">type</span><span class="o">&gt;[</span>optional scope]: &lt;description&gt;

<span class="o">[</span>optional body]

<span class="o">[</span>optional footer<span class="o">(</span>s<span class="o">)]</span>
</code></pre></div></div>

<ul>
  <li><code class="language-plaintext highlighter-rouge">&lt;type&gt;</code>: A required noun that describes the nature of the change.</li>
  <li><code class="language-plaintext highlighter-rouge">[optional scope]</code>: An optional phrase within parentheses that specifies the part of the codebase being affected (e.g., fix(parser):).</li>
  <li><code class="language-plaintext highlighter-rouge">&lt;description&gt;</code>: A required short, imperative-mood summary of the changes.</li>
  <li><code class="language-plaintext highlighter-rouge">[optional body]</code>: A longer description providing additional context and “what and why” details.</li>
  <li><code class="language-plaintext highlighter-rouge">[optional footer(s)]</code>: Used for adding meta-information, such as issue references (Fixes #123) or indicating breaking changes.</li>
</ul>

<hr />

<h2 id="requirements">Requirements</h2>

<p><strong>Python 3.11</strong></p>

<div class="language-shell highlighter-rouge"><div class="highlight"><pre class="highlight"><code><span class="nv">$ </span><span class="nb">sudo </span>apt <span class="nb">install </span>python3.11
</code></pre></div></div>

<p><strong><a href="https://github.com/jcook3701/nutri-matic">Nutri-Matic</a></strong><br />
<strong>Note:</strong> This is needed for the cookiecutter hooks to run correctly.  Without this package installed in active python environment cookiecutter pull will fail.</p>

<div class="language-shell highlighter-rouge"><div class="highlight"><pre class="highlight"><code><span class="nv">$ </span>pip <span class="nb">install </span>nutri-matic
</code></pre></div></div>

<p><strong><a href="https://rust-lang.org/tools/install/">rustup</a></strong><br />
<strong>Note:</strong> I found that it is easiest to use rustup to manage rustc and cargo but this is not required.<br />
<strong>Example:</strong> Install rustup with the following:</p>

<div class="language-shell highlighter-rouge"><div class="highlight"><pre class="highlight"><code><span class="nv">$ </span>curl <span class="nt">--proto</span> <span class="s1">'=https'</span> <span class="nt">--tlsv1</span>.2 <span class="nt">-sSf</span> https://sh.rustup.rs | sh
</code></pre></div></div>

<p><strong><a href="https://git-cliff.org/">git-cliff</a></strong><br />
<strong>Note:</strong> git-cliff can generate changelog files from the Git history by utilizing conventional commits as well as regex-powered custom parsers.</p>

<div class="language-shell highlighter-rouge"><div class="highlight"><pre class="highlight"><code><span class="nv">$ </span>cargo <span class="nb">install </span>git-cliff
</code></pre></div></div>

<hr />

<h2 id="authors-notes">Authors Notes</h2>

<ol>
  <li>This code currently works with cookiecutter (V2.6) from Ubuntu’s apt repositories.</li>
</ol>

<!--
### Helpful Emojis:

📡🐋🛢️🚢 🦊💼 👨🏼‍💻🚧 📌 🌱🌳 ⏳🔑 🔫⌚ 🧼🧽 🔌💉
--->
